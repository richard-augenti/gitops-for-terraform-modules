# Configure the GitLab Provider
provider "gitlab" {
  token    = var.gitlab_token
  base_url = "https://code.gitlab.prod.us-west-2.tlz.svbank.com/"
  insecure = true
  alias    = "terraform_repos"
}

provider "tfe" {
  hostname = "tfe.preprod.tlz.svbank.com"
  token    = var.token
  alias    = "tfcloud"
}
