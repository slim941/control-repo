[![Build Status][travis-img-master]][travis-ci]
[![GitHub tag][gh-tag-img]][gh-link]

# Control Repo

This repository is a template control-repo that can be used with r10k as part of
my sample Foreman / Puppet / PuppetDB setup.

The major points are:
 - An environment.conf that correctly implements:
   - A site directory for roles, profiles, and any custom modules for your organization.
   - A config_version script.
 - Provided config_version scripts to output the commit of code that your agent just applied.
 - Basic example of roles/profiles code.
 - hieradata directory with common.yaml and nodes directory.

## Copy This Repo Into Your Own Git Server

### GitLab

1. Install GitLab.
 - https://about.gitlab.com/downloads/

2. After GitLab is installed you may sign if with the `root` user and password `5iveL!fe`.

3. Make a user for yourself.

4. Make an SSH key to link with your user. You’ll want to do this on the machine you intend to edit code from (most likely not your Puppet master, but your local workstation or laptop).
 - http://doc.gitlab.com/ce/ssh/README.html
 - https://help.github.com/articles/generating-ssh-keys/

5. Create a group called `puppet` (this is case sensitive).
 - http://doc.gitlab.com/ce/workflow/groups.html

6. Add your user to the `puppet` group as well.

7. Create a project called `control-repo`, and set the Namespace to be the `puppet` group.

8. Clone this control repository to your laptop/workstation:
 - `git clone <repository url>`
 - `cd control-repo`

9. Remove this repository as the origin remote:
 - `git remote remove origin`

10. Add your internal repository as the origin remote:
 - `git remote add origin <url of your gitlab repository>`

11. Push the production branch of the repository from your machine up to your git server
 - `git push origin production`


 [gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-control-repo.svg
 [gh-link]: https://github.com/genebean/genebean-control-repo
 [travis-ci]: https://travis-ci.org/genebean/genebean-control-repo
 [travis-img-master]: https://img.shields.io/travis/genebean/genebean-control-repo/master.svg
