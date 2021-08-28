---
title: Git
---

## Usage
```bash
# set a commit as HEAD
git reset --hard <commit_id>

# set global config
$ git config --global user.name NAME
$ git config --global user.email EMAIL

# ignore file mode changes
git config core.fileMode false

# create local branch from remote branch
git checkout -b test <name of remote>/test

# force push
git push origin <your_branch_name> --force

# visualize lineage
git log --graph --oneline --all

# compare tips of different branches
git diff branch1..branch2

# ignore whitespace
git diff -w

# remove some commits in-between
## https://stackoverflow.com/questions/51249344/deleting-commits-with-git-rebase
## Assuming the structure of your repo is like this (the letters denote commits)
#### X - Y - A - B - Z    (<--dev)
### the current branch points to Z and you want to get rid of commits A and B (and make Z a child of Y), the Git command you are looking for is:
git rebase --onto Y B
```

## GitHub Actions
```yaml
name: Deploy

on:
  push:
    branches: [ master ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
```

## Visualize
### gitinspector
```
$ npm i -g gitinspector
$ gitinspector -T  -F html > stats.html
```
