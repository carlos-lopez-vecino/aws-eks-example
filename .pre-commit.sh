#!/usr/bin/env bash

set -e

# generating terraform documentation. please note that partially staged files are going to be commited!

find "./base/" -maxdepth 0 -type d -name ".terraform" -prune -o -name ".git" -prune -o -type d -print -exec bash -c 'terraform-docs md "{}" > "{}"/README.md;' \;
find "./base/" -maxdepth 0 -name "README.md" -size 1c -type f -delete
printf "\n\033[32;1m* The following READMEs will be generated with terraform-docs and commited:\033[0m\n\n"
find "./base/" -name "README.md"
cp "./base/README.md" "./README.md"
git add "./base/README.md"
git add "./README.md"

# formatting *.tf files according to Hashicorp's convention. please note that partially staged files are going to be commited!

printf "\n\033[32;1m* The following files will be formatted (Hashicorp's convention) and commited:\033[0m\n\n"
terraform fmt -list=true
echo ""
files=$(git diff --cached --name-only)
for f in $files
do
  if [ -e "$f" ] && [[ $f == *.tf ]]; then
    terraform fmt "$f"
    git add "$f"
  fi
done
