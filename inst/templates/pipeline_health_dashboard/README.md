# Lifebit Pipelines Health

Dashboard - https://<github_org>.github.io/<github_repo_name>/

Updates every midnight or when main branch updates - [![render-and-deploy](https://github.com/<github_org>/<github_repo_name>/workflows/render-and-deploy/badge.svg)](https://github.com/<github_org>/<github_repo_name>/actions?query=workflow%3Arender-and-deploy)

## About

This uses [GitHub API](https://docs.github.com/en/rest/reference) though [gh R-package](https://cran.r-project.org/web/packages/gh/index.html) to get informations about a particular repository and shows them in a dashboard format.

## Usage

The HTML dashboard is rendered from [index.Rmd](index.Rmd) file.

### Render locally

```
rmarkdown::render('index.Rmd', output_dir = '.')
```

> Note: If there are private repo, it will require Authentication token. (Defaults to `GITHUB_PAT` or `GITHUB_TOKEN` as environment variables)

### Add a pipeline to dashboard

Wants to add a repo!! Please edit one of the `*-pipeline.json` file.