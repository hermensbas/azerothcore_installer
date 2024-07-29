#!/bin/bash

# Alias GIT (git lg for git commits, git ls for commits with changed files)
git config --global alias.lg 'log --graph --abbrev-commit --decorate --date=relative --all'
git config --global alias.ls 'log --stat --pretty=short --graph'
