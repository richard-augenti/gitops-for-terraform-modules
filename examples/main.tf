locals {
  gitlab_repos = jsondecode(file("./gitlab-repo-config/gitlab-repo-${var.environment}.json"))
}

# Create the configured GitLab Repositories configured in gitlab-config file
module "gitlab" {
  for_each     = { for repo in local.gitlab_repos.repositories : repo.name => repo }
  source       = "./modules/gitlab/"
  name         = each.key
  gitlab_token = var.gitlab_token
  group_id     = var.group_id
  environment  = var.environment
  c4e          = var.c4e
  security     = var.security
  iam          = var.iam
  providers = {
    gitlab = gitlab.terraform_repos
  }
}

module "tfe" {
  for_each         = { for repo in local.gitlab_repos.repositories : repo.name => repo }
  source           = "./modules/terraform/"
  service_provider = var.service_provider
  group_name       = var.group_name
  name             = each.key
  organization     = var.organization
  providers = {
    tfe = tfe.tfcloud
  }
}

