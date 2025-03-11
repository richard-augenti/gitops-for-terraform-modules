data "tfe_oauth_client" "client" {
  organization     = var.organization
  service_provider = var.service_provider
}

resource "tfe_registry_module" "registry-module" {
  vcs_repo {
    display_identifier = "${var.group_name}/${var.name}"
    identifier         = "${var.group_name}/${var.name}"
    oauth_token_id     = data.tfe_oauth_client.client.oauth_token_id
  }
}
