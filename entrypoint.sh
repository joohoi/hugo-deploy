#!/bin/bash

set -e
set -o pipefail

if [[ "$DEPLOY_TOKEN" ]]; then
    GITHUB_TOKEN=$DEPLOY_TOKEN
fi

if [[ -z "$DEPLOY_REPO" ]]; then
    echo "You must define DEPLOY_REPO."
    exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "DEPLOY_TOKEN / GITHUB_TOKEN is required."
	exit 1
fi

git config --global user.name "${DEPLOY_USER}"
git config --global user.email "${DEPLOY_USER}@users.noreply.github.com" 

curl -sSL https://github.com/spf13/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.tar.gz -o /var/tmp/hugo.tar.gz && tar -zxf /var/tmp/hugo.tar.gz

./hugo

git clone "https://${GITHUB_TOKEN}@github.com/${DEPLOY_REPO}.git" /tmp/hugo_dest
cp -Rp public/* /tmp/hugo_dest/
cd /tmp/hugo_dest/
git add .
git commit -m "Deploying $(git rev-parse --verify HEAD)"
git push origin master
