resource "heroku_app" "hashitalks_latam_demo" {
  name   = "heroku-terraform-demo"
  region = "us"
  organization {
    name = "hashitalks-latam"
  }
}

resource "heroku_pipeline" "hashitalks_latam" {
  name = "hashitalks-latam"
  owner {
    id = var.HEROKU_ORGANIZATION
    type = "team"
  }
}

resource "herokux_pipeline_github_integration" "hashitalks_latam" {
  pipeline_id = heroku_pipeline.hashitalks_latam.id
  org_repo = "hdanniel/hashitalks-latam"
}

resource "heroku_pipeline_coupling" "staging" {
  app      = heroku_app.hashitalks_latam_demo.id
  pipeline = heroku_pipeline.hashitalks_latam.id
  stage    = "staging"
}

resource "heroku_review_app_config" "hashitalks_latam" {
  depends_on = [
    herokux_pipeline_github_integration.hashitalks_latam
  ]
  pipeline_id = heroku_pipeline.hashitalks_latam.id
  org_repo = "hdanniel/hashitalks-latam"
  automatic_review_apps = true
  base_name = "hashitalks-latam"

  deploy_target {
    id   = "us"
    type = "region"
  }

  destroy_stale_apps = true
  stale_days = 5
    wait_for_ci = false
}

resource "heroku_addon" "demo_postgres" {
  app  = heroku_app.hashitalks_latam_demo.name
  plan = "heroku-postgresql:hobby-basic"
}

resource "heroku_addon" "demo_newrelic" {
  app  = heroku_app.hashitalks_latam_demo.name
  plan = "newrelic:wayne"
}

resource "heroku_app" "hashitalks_latam_online" {
  name   = "heroku-terraform-online"
  region = "us"
  organization {
    name = "hashitalks-latam"
  }
}

resource "heroku_domain" "hashitalks_latam" {
  app      = heroku_app.hashitalks_latam_online.name
  hostname = "hashitalks-latam.getsysmin.com"
}

