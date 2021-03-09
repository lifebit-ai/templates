get_gh_actions_workflow <- function(repo_url){
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  workflows <- gh::gh("/repos/:owner/:repo/actions/workflows", 
                  owner = github_org, repo = github_repo)
  return(workflows)
}

get_workflow_badges <- function(repo_url){
  workflows <- get_gh_actions_workflow(repo_url)
  all_badges <- c()
  if(workflows$total_count == 0){
    return(paste0("&#10008;"))
  }

  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]

  for(n in 1:workflows$total_count){
    workflow_url <- paste0("https://github.com/", github_org,"/", github_repo, 
                           "/actions?workflow=", workflows$workflows[[n]]$name)
    workflow_badge <- workflows$workflows[[n]]$badge_url
    all_badges <- c(all_badges, paste0("<a href='",workflow_url,"'>","<img src='",workflow_badge,"'></img>","</a>"))
  }
  return(paste(all_badges, collapse = "&nbsp;<br>"))
}

get_gh_contents_docs <- function(repo_url){
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  gh_contents <- gh::gh("/repos/:owner/:repo/contents/", 
                    owner = github_org, repo = github_repo)
  
  for(n in 1:length(gh_contents)){
    if (gh_contents[[n]]$path == "docs"){
      return(paste0("<a href='",gh_contents[[n]]$html_url,"'>","&#10004;","</a>"))
    }
  }
  # if no docs path present 
  return("&#10008;")
}

get_gh_check_report_rmd <- function(repo_url){
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  gh_contents <- gh::gh("/repos/:owner/:repo/contents/", 
                    owner = github_org, repo = github_repo)
  
  # check only in bin folder
  for(n in 1:length(gh_contents)){
    if (gh_contents[[n]]$path == "bin"){
      gh_contents_bin <- gh::gh("/repos/:owner/:repo/contents/:path", 
                            owner = github_org, repo = github_repo, path = "bin")
      # check for the file report.Rmd
      if (any(grepl("report.Rmd", gh_contents_bin))){
        return("&#10004;")
      }
      # check inside 1st level directory
      for(n in 1:length(gh_contents_bin)){
        if (gh_contents_bin[[n]]$type == "dir"){
          gh_contents_bin_first_level_dir <- gh::gh("/repos/:owner/:repo/contents/:path", 
                                                owner = github_org, repo = github_repo, path = gh_contents_bin[[n]]$path)
          if (any(grepl("report.Rmd", gh_contents_bin_first_level_dir))){
            return("&#10004;")
          }
        }
      }
    }
  }
  # if no report.Rmd
  return("&#10008;")
}

get_gh_repo_open_issues <- function(repo_url){
  
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  gh_issues <- gh::gh("/repos/:owner/:repo/issues", 
                  owner = github_org, repo = github_repo, 
                  per_page = 100)
  
  gh_issues_number_with_link <- paste0("<a href='",repo_url,"/issues","'>",length(gh_issues),"</a>")
  return(gh_issues_number_with_link)
}

get_gh_repo_open_pulls <- function(repo_url){
  
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  gh_pulls <- gh::gh("/repos/:owner/:repo/pulls", 
                 owner = github_org, repo = github_repo, 
                 per_page = 100)
  
  gh_pulls_number_with_link <- paste0("<a href='",repo_url,"/pulls","'>",length(gh_pulls),"</a>")
  return(gh_pulls_number_with_link)
}

get_gh_repo_branches <- function(repo_url){
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  gh_branches <- gh::gh("/repos/:owner/:repo/branches", 
                    owner = github_org, repo = github_repo)
  return(gh_branches)
}

if_a_branch_present <- function(repo_url, branch = "dev"){
  
  gh_branches <- get_gh_repo_branches(repo_url)
  branch_names <- unlist(do.call( rbind, gh_branches)[,1])
  
  if (branch %in% branch_names){
    return(paste0("<a href='",repo_url,"/tree/",branch,"'>","&#10004;","</a>"))
  }
  if (!branch %in% branch_names){
    # if branch not present 
    return("&#10008;")
  }
}

get_gh_repo_details <- function(repo_url){
  repo_meta <- strsplit(sub("/$","",repo_url), "/")
  github_org <- repo_meta[[1]][4]
  github_repo <- repo_meta[[1]][5]
  
  repo_details <- gh::gh("/repos/:owner/:repo", 
                     owner = github_org, repo = github_repo)
}

get_gh_repo_default_branch <- function(repo_url){
  repo_details <- get_gh_repo_details(repo_url)
  default_branch <- repo_details$default_branch
  return(paste0("<a href='",repo_url,"/tree/","'>",default_branch,"</a>"))
}

get_gh_repo_last_update <- function(repo_url){
  repo_details <- get_gh_repo_details(repo_url)
  last_updated <- repo_details$updated_at
}

get_gh_repo_last_push <- function(repo_url){
  repo_details <- get_gh_repo_details(repo_url)
  last_updated <- repo_details$pushed_at
}

get_cloudos_public_links <- function(repo_json_obj){
  cloudos_job_link <- "&#10008;"
  if("cloudos_public_run" %in% names(repo_json_obj)){
    cloudos_job_link <- paste0("<a href='",repo_json_obj$cloudos_public_run,"'>","<img src='img/cloudos-logo.svg' alt='drawing' style='width:30px;'/>","</a>")
    return(cloudos_job_link)
  }
  return(cloudos_job_link)
}
