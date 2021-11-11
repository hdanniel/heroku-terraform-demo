terraform {
  backend "remote" {
    organization = "getsysadmin"
    workspaces {
      name = "hashitalks-latam"
    }
  }
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "4.6.0"
    }
    herokux = {
      source = "davidji99/herokux"
      version = "0.30.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
