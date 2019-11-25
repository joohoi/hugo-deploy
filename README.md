# Deploy Hugo project to a repository

Available variables:
  - `DEPLOY_TOKEN` GitHub access token that has write access to the destination deployment repository. 
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
          DEPLPOY_REPO: username/reponame
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
          DEPLOY_USER: username
```
