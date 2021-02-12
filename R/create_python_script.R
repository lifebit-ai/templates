#' @title Create python script template
#'
#' @description Create parametrised python script template
#' @param script_name Script name
#' @export
create_python_script <- function(script_name){
  if(missing(script_name)){
    script_name = "script.py"
  }
  
  usethis::use_template(template = "script.py", 
               save_as = script_name,
               package = "onboarding")
}
