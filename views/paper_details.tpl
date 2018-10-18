% import helpers
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist details – {{paper["title"]}}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-annotation/0.5.5/chartjs-plugin-annotation.js"></script>
    <script src="https://cdn.rawgit.com/chartjs/Chart.js/master/samples/utils.js"></script>
  </head>

  <body>
    <div class="container" id="main">

      %include("components/header")

      <div class="row">
        <div class="col">
          <h1>{{paper["title"]}}</h1>
          <div>
            <a href="/?metric=downloads&timeframe=alltime&category={{paper["category"]}}" class="btn btn-secondary " role="button">{{ helpers.formatCategory(paper["category"]) }}</a>
            <a href="{{paper["biorxiv_url"]}}" target="_blank" class="btn btn-altcolor " role="button">view on bioRxiv</a>
            % if "publication" in paper.keys() and len(paper["publication"].keys()) > 0:
              <a href="https://doi.org/{{ paper["publication"]["doi"] }}" target="_blank" class="btn btn-warning" role="button">view in {{ "publication" if "journal" not in paper["publication"].keys() or paper["publication"]["journal"] == "" else paper["publication"]["journal"] }}</a>
            % end
          </div>
          <p>By
          % for i, coauthor in enumerate(paper["authors"]):
            <a href="/authors/{{ coauthor["id"] }}">{{ coauthor["name"] }}</a>{{", " if i < (len(paper["authors"]) - 1) else ""}}
          % end
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <p>{{paper["abstract"]}}
        </div>
        <div class="col-md-6">
          %include("components/paper_stats", paper=paper)
        </div>
      </div>
      % if "ranks" in paper.keys():
        <div class="row">
          <div class="col-md-6">
            <h3>Downloads over time</h3>
            <canvas id="downloadsOverTime"></canvas>
          </div>
          <div class="col-md-6">
            <h3>Distribution of downloads per paper, site-wide</h3>
            <canvas id="downloadsDistribution"></canvas>
          </div>
          %include("components/download_distribution", entity=paper,  entity_name="paper", download_distribution=download_distribution, averages=averages)
          %include("components/download_graph", paper=paper)
        </div>
       % end
    </div>

    %include("components/footer")

  </body>
</html>