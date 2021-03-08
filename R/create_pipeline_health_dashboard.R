#' @title Render table
#'
#' @description Render a pipeline health dashboard table
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
  
  all_files_in_template <- list.files(paste0(pkg_loc, "/templates/pipeline_health_dashboard"), 
                          full.names = TRUE, 
                          all.files = TRUE)
  
  repo_dir <- paste(output_path, output, sep = "/")
  dir.create(repo_dir, showWarnings = F)
  
  file.copy(from = all_files_in_template, 
            to = repo_dir, 
            recursive = TRUE,
            overwrite = TRUE, 
            copy.mode = TRUE)
}