#' @title Create R script template
#'
#' @description Create parametrised R script template
#' @param script_name Script name
#' @export
create_R_script <- function(script_name){
  if(missing(script_name)){
    script_name = "script.R"
  }
  
  usethis::use_template(template = "script.R", 
               save_as = script_name,
               package = "templates")
}
