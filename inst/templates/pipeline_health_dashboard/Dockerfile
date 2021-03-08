FROM rocker/tidyverse:latest

LABEL authors="sangram@lifebit.ai" \
      description="Docker image containing dependencies for lifebit-ai/pipeline-health"

RUN apt-get update \
    && R -e 'install.packages(c("rmarkdown","jsonlite", "gh", "flexdashboard", "DT", "remotes"))' \
    && R -e 'remotes::install_github("lifebit-ai/templates")'

# "lifebit-ai/templates" is a private repo, need Sys.setenv(GITHUB_PAT = PAT) to build this docker image.
# this docker image can pulled from - lifebitai/pipeline-health:latest
