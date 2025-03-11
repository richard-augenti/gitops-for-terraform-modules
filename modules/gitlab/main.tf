resource "gitlab_project" "this" {
  name                   = var.name
  namespace_id           = var.group_id
  description            = var.description
  visibility_level       = var.visibility_level
  default_branch         = "master"
  initialize_with_readme = var.initialize_with_readme
  request_access_enabled = var.request_access_enabled

  lfs_enabled      = var.lfs_enabled
  packages_enabled = var.packages_enabled
  snippets_enabled = var.snippets_enabled
  wiki_enabled     = var.wiki_enabled
  archive_on_destroy = true

  merge_method                                     = var.merge_method
  approvals_before_merge                           = var.approvals_before_merge
  only_allow_merge_if_pipeline_succeeds            = var.only_allow_merge_if_pipeline_succeeds
  only_allow_merge_if_all_discussions_are_resolved = var.only_allow_merge_if_all_discussions_are_resolved
  remove_source_branch_after_merge                 = var.remove_source_branch_after_merge

  pages_access_level = var.pages_access_level

  push_rules {
    commit_committer_check = var.commit_committer_check
    deny_delete_tag        = var.deny_delete_tag
    member_check           = var.member_check
    prevent_secrets        = var.prevent_secrets
    branch_name_regex      = var.branch_name_regex
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "gitlab_branch_protection" "this" {
  project                      = gitlab_project.this.id
  branch                       = var.default_branch
  push_access_level            = var.push_access_level
  merge_access_level           = var.merge_access_level
  code_owner_approval_required = var.code_owner_approval_required
}

data "gitlab_user" "c4e" {
  for_each = toset(var.c4e)

  username = each.value
}

resource "gitlab_project_approval_rule" "c4e" {
  project            = gitlab_project.this.id
  name               = "C4E Team"
  approvals_required = 1
  user_ids           = [for user in data.gitlab_user.c4e : user.id]
}

data "gitlab_user" "iam" {
  for_each = toset(var.iam)

  username = each.value
}

resource "gitlab_project_approval_rule" "iam" {
  project            = gitlab_project.this.id
  name               = "IAM Team"
  approvals_required = 1
  user_ids           = [for user in data.gitlab_user.iam : user.id]
}

data "gitlab_user" "security" {
  for_each = toset(var.security)

  username = each.value
}

resource "gitlab_project_approval_rule" "security" {
  project            = gitlab_project.this.id
  name               = "Security Office Team"
  approvals_required = 1
  user_ids           = [for user in data.gitlab_user.security : user.id]
}

resource "gitlab_project_level_mr_approvals" "this" {
  project                                        = gitlab_project.this.id
  reset_approvals_on_push                        = var.reset_approvals_on_push
  disable_overriding_approvers_per_merge_request = var.disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.merge_requests_disable_committers_approval
}