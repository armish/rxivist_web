# rxivist API

(RESTful endpoints have not yet been implemented.)

## Admin endpoints

* `/db`: Displays the tables currently stored in the Rxivist database.
* `/db/$table_name`: Displays the contents of the `$table_name` table in the database.

## Frontend

Though the Rxivist web application may one day be broken out into its own codebase, it's currently integrated directly into this Bottle app and uses the SimpleTemplateEngine elements defined in the `/views` directory. It currently has three pages:

### `/`: Main search page
Query parameters:
* `q`: string for text search of paper titles and abstracts.
* `timeframe`: What range of time to use (year to date, all time, etc.) when ordering results by number of downloads.
* `category`: Which bioRxiv collections to include in the results. *Multiple categories* can be included, though there is not currently a way to select multiple categories in the search form.

### `/papers/$paperID`: Paper details
Shows authorship, download an ranking information for a single paper.

### `/authors/$authorID`: Author details
Shows all of an author's papers and their respective rankings.


## Deployment to production
The rxivist web application and API is designed to be run from a Docker container. The current official deployment is Docker running on a virtual machine. Once Docker is installed on whatever instance you're running, there are only a few commands to run:

```sh
docker swarm init
docker build . -t rxivist:latest
docker service create --name rxivist_service   --replicas 3   --publish published=80,target=80 rxivist:latest
```

This builds a new image based on the current code on the repository, and deploys three containers to which all requests are load balanced. If one becomes unhealthy, it's removed and replaced with a fresh container.

**Note:** You'll want to modify the `config.py` file *before* you run `docker build`, not after—for now, the configuration must be copied into the container at build time. This will change one day and be much nicer.

## Development

### Using Docker

For local development, you don't need to rebuild a container image every time you want to test a change. Mounting the repository to the container will allow you to test changes as you make them.

1. Start the database: `docker run -d --rm --name rxdb -e POSTGRES_PASSWORD=mysecretpassword postgres` (This may already be running if you spun up the spider first.)
1. `git clone https://github.com/rabdill/rxivist.git`
1. `cd rxivist/api`
1. `docker run -it --rm --name rxapi -p 8123:80 -v "$(pwd)":/app --link rxdb:postgres python:slim bash /app/prep.sh`

*Note:* To run the container in the background, replace the `-it` flags in the docker command above with `-d`. In addition, remove the `--link rxdb:postgres` section if you aren't connecting to a local database.

Because the repository is bind-mounted to the container, editing the files locally using your editor of choice will result in the files also changing within the container. The server reloads the applications whenever a modification is detected, but **will exit if it encounters an uncaught exception**. At that point, you should land in a shell; running `python main.py` again should start up the server again.

**Exiting the container's TTY will cause the container to stop,** and you will have to run step 4 again.
