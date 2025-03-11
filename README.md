# service-catalogue-gitops

Overview
--------
This repository hosts a Terraform Workspace used to provision new GitLab repos for new Terraform modules. This repository also includes the GitLab repository which the Terraform Workspace calls when creating new GitLab repositories.

Process
-------
Create a GitLab repo in the following steps:

1. Create a feature branch
2. Edit gitlab-repo-config/gitlab-repo-preprod.json file in this repository
3. Copy an existing snippet of code and paste. Also, seperate code blocks with a comma as shown in the example below.
```     
        {
           "name": "gitlab_repo1"
        },
        {
           "name": "gitlab_repo1"
        }
```
4. Rename the value to the desired name for the new repository.
```     
        {
           "name": "gitlab_repo1"
        },
        {
           "name": "gitlab_repo2"
        }
```
5. Commit changes to the repo
6. Create a Merge Request and merge from feature branch to master
7. Go to the terraform workspace https://tfe.preprod.tlz.svbank.com/app/svb/workspaces/service-catalogue-gitops
8. Perform a Terraform Apply


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| gitlab | n/a |
| terraform | n/a |


