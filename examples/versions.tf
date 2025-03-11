terraform {
  required_version = ">=0.14"

  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
    tfe = {
      version = "~> 0.48.0"
    }
  }
}
