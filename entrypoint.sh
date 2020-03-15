#!/bin/bash

set -e
set -o pipefail

if [[ -z "$DEPLOY_REPO" ]]; then
    echo "DEPLOY_REPO is required."
    exit 1
fi

if [[ -z "$DEPLOY_SSH_KEY" ]]; then
	echo "DEPLOY_SSH_KEY is required."
	exit 1
fi

if [[ -z "$DEPLOY_USER" ]]; then
	echo "DEPLOY_USER is required."
	exit 1
fi

# Deploy ssh key
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
eval $(ssh-agent -s)
bash -c 'ssh-add <(echo "$DEPLOY_SSH_KEY")'

git config --global user.name "${DEPLOY_USER}"
git config --global user.email "${DEPLOY_USER}@users.noreply.github.com" 

curl -sSL https://github.com/spf13/hugo/releases/download/v0.67.0/hugo_0.67.0_Linux-64bit.tar.gz -o /var/tmp/hugo.tar.gz && tar -zxf /var/tmp/hugo.tar.gz

./hugo

GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git clone -v "git@github.com:${DEPLOY_REPO}.git" /tmp/hugo_dest
cp -Rp public/* /tmp/hugo_dest/
cd /tmp/hugo_dest/
git add .
git commit -m "Deploying $(git rev-parse --verify HEAD)"
git push origin master
