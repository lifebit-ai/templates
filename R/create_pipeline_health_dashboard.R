#' @title Create pipeline health dashboard
#'
#' @description Create pipeline health dashboard repo/folder
#' 
#' @param all_repo A specific structed json object
#' @param output The repo/folder name
#' @param output_path The path where folder will be saved (Default: working directory)
#' @export
create_pipeline_health_dashboard <- function(
  output = "my_pipeline_health_dashboard",
  output_path
){
  if(missing(output_path)){
    output_path = getwd()
  }
  
  pkg_loc <- system.file(package = "templates")
  input_template_dir <- paste0(pkg_loc, "/templates/pipeline_health_dashboard/")
  output_repo_dir <- paste(output_path, output, sep = "/")
  dir.create(output_repo_dir, showWarnings = F)
  
  file.copy(from = input_template_dir, 
            to = output_repo_dir, 
            recursive = TRUE,
          )
}