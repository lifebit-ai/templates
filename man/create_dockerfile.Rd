% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_dockerfile.R
\name{create_dockerfile}
\alias{create_dockerfile}
\title{Create Dockerfile}
\usage{
create_dockerfile(
  output = "Dockerfile",
  output_path,
  from = paste0("rocker/r-ver:", R.Version()$major, ".", R.Version()$minor),
  maintainer = "your_name",
  maintainer_email = "your_email@website.domain",
  system_requirement = c("procps", "jq")
)
}
\arguments{
\item{output}{Dockerfile}

\item{output_path}{The path where Dockerfile will be saved (Default: working directory)}

\item{from}{Base image}

\item{maintainer}{Maintainer}

\item{maintainer_email}{Maintainer email address}

\item{system_requirement}{System requirement tools (Default: procps, jq)}
}
\description{
Create a docker file teamplate
}
