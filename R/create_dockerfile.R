#' @title Create Dockerfile
#'
#' @description Create a docker file teamplate
#' 
#' @param output Dockerfile
#' @param output_path The path where Dockerfile will be saved (Default: working directory)
#' @param from Base image
#' @param maintainer Maintainer 
#' @param maintainer_email Maintainer email address
#' @param system_requirement System requirement tools (Default: procps, jq)
#' @export
create_dockerfile <- function(
  output = "Dockerfile",
  output_path,
  from = paste0(
    "rocker/r-ver:", 
    R.Version()$major,".", 
    R.Version()$minor
  ),
  maintainer= "your_name", 
  maintainer_email = "your_email@website.domain",
  system_requirement = c("procps", "jq")
) {
  
  if(missing(output_path)){
    output_path = getwd()
  }
  
  dock <- dockerfiler::Dockerfile$new(FROM = from)
  dock$MAINTAINER(maintainer, maintainer_email)
  dock$RUN(paste("apt-get update && apt-get install -y",
                 paste(system_requirement, collapse = " "),
                 "&& rm -rf /var/lib/apt/lists/*"
                 )
           )
  
  dock$RUN(dockerfiler::r(utils::install.packages(c("cloudos", "remote"), repo = "http://cran.irsn.fr/")))
  
  dock$write(paste(output_path, output, sep = "/"))
  cli::cli_alert_success("{output} created at - {.url {output_path}}")
}
