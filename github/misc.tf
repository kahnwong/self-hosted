locals {
  all_repos_raw = yamldecode(file("~/.config/workspace-init/config.yaml"))
  all_repos = flatten([
    for item in local.all_repos_raw.orgs[0].categories :
    lookup(item, "repos", [])
  ])

  repos_to_subtract_list = local.tangled_mirror_repos
  remaining_repos        = setsubtract(toset(local.all_repos), toset(local.repos_to_subtract_list))
}
