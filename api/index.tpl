<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Rxivist: Popular biology pre-print papers ranked</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/rxivist.css">
  </head>

  <body>
  <br>
    <div class="container">
      <div class="row" id="header">
        <div class="col col-sm-10">
          <img src="/static/rxivist_logo_bad.png">
        </div>
        <div class="col col-sm-2">
          <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#about">
            About
          </button>
        </div>
      </div>
      <div class="row">
        <div class="col">
          <h2>Most popular bioinformatics papers, all-time</h2>
          <div class="accordion" id="alltime">
            % for result in rankings:
              <div class="card">
                <div class="card-header" id="heading{{result["id"]}}">
                  <h5 class="mb-0">
                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapse{{result["id"]}}" aria-expanded="true" aria-controls="collapse{{result["id"]}}">
                      <strong>{{result["rank"]}}:</strong> {{result["title"]}} <span class="badge badge-secondary" style="margin-left: 10px;">{{result["downloads"]}} downloads</span>
                    </button>
                  </h5>
                </div>
                <div id="collapse{{result["id"]}}" class="collapse" aria-labelledby="heading{{result["id"]}}" data-parent="#alltime">
                  <div class="card-body">
                    <p>
                    % for i, author in enumerate(result["authors"]):
                      {{author}}{{", " if i < (len(result["authors"]) - 1) else ""}}
                    % end
                    <a href="{{result["url"]}}" target="_blank" class="btn btn-primary float-right" role="button">view paper</a>
                    <p>{{result["abstract"]}}
                  </div>
                </div>
              </div>
            % end
          </div>
        </div>
      </div>


      <div class="modal fade" id="about" tabindex="-1" role="dialog" aria-labelledby="aboutLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="aboutLabel">About</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>Rxivist indexes and sorts metadata from <a href="https://www.biorxiv.org/">bioRxiv</a>, a <a href="http://www.sciencemag.org/news/2017/09/are-preprints-future-biology-survival-guide-scientists">preprint</a> server operated by Cold Spring Harbor Laboratory. There is absolutely no official association between bioRxiv and this project.
              
              <p>Rxivist was developed in 2018 by the <a href="http://blekhmanlab.org">Blekhman Lab</a> at the University of Minnesota. Its source code is <a href="https://github.com/rabdill/rxivist">available on GitHub</a>.
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>

      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    </div>
  </body>
</html>