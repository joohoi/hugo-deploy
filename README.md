# Deploy Hugo project to a repository

Available variables:
  - `DEPLOY_SSH_KEY` SSH private key stored in secrets. This is added to the `DEPLOY_REPO` as adeploy key and does not have to be stored for the user itself.
  - `DEPLOY_REPO` GitHub repository to deploy the project to, in format of `username/repositoryname`  
  - `DEPLOY_USER` GitHub username to deploy with.


```
name: Deploy Hugo project to GitHub repository
on:
  push:
    branches:
      - master

jobs:
  build:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
      - name: Checkout master
        uses: actions/checkout@v1

      - name: Deploy the site
        uses: joohoi/hugo-deploy@master
        env:
          DEPLOY_REPO: username/reponame
          DEPLOY_SSH_KEY: ${{ secrets.DEPLOY_TOKEN }}
          DEPLOY_USER: username
```
