#' @title Render table
#'
#' @description Render a pipeline health dashboard table
#' 
#' @param all_repo A specific structed json object
#' @export
render_datatable <- function(all_repo){
  pipeline_df <- data.frame()
  for(n in 1:length(all_repo$repo)){
    repo <- all_repo$repo[[n]]
    repo_meta <- strsplit(sub("/$","",repo$repo_url), "/")
    github_org <- repo_meta[[1]][4]
    github_repo <- repo_meta[[1]][5]
    pipeline_df[n,1] <- paste0("<a href='",repo$repo_url,"'>",github_org, "/",github_repo,"</a>")
    pipeline_df[n,2] <- paste0(get_gh_contents_docs(repo$repo_url))
    pipeline_df[n,3] <- get_gh_check_report_rmd(repo$repo_url)
    pipeline_df[n,4] <- get_gh_repo_open_issues(repo$repo_url)
    pipeline_df[n,5] <- get_gh_repo_open_pulls(repo$repo_url)
    pipeline_df[n,6] <- if_a_branch_present(repo$repo_url, branch = "dev")
    pipeline_df[n,7] <- get_gh_repo_default_branch(repo$repo_url)
    pipeline_df[n,8] <- get_gh_repo_last_update(repo$repo_url)
    pipeline_df[n,9] <- get_gh_repo_last_push(repo$repo_url)
    pipeline_df[n,10] <- get_cloudos_public_links(repo)
    pipeline_df[n,11] <- get_workflow_badges(repo$repo_url)
  }
  names(pipeline_df) <- c("pipeline", "docs", "report.Rmd","open-issues", "open-pulls", "dev-branch", "default-branch", "last-updated" , "last-pushed", "cloudos-run", "status")
  
  sketch = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th('', title = 'Row Names'),
        th('pipeline', title = 'The github repo name'),
        th('docs', title = 'If the "docs" folder is present in default branch?'),
        th('report.Rmd', title = 'If the "bin" folder contains a *report.Rmd file in default branch? it checked 1st and 2nd level directory only'),
        th('open-issues', title = 'Number of open issues'),
        th('open-pulls', title = 'Number of open pull requests'),
        th('dev-branch', title = 'If a "dev" branch is present?'),
        th('default-branch', title = 'Default branch name'),
        th('last-updated', title = 'Last updated in default branch'),
        th('last-pushed', title = 'Last pushed to any branch'),
        th('cloudos-run', title = 'CloudOS run link (if provided in json file)'),
        th('status', title = "All GitHub-Actions-CI Status (For private repos it won't show)")
      )
    )
  ))
  
  DT::datatable(pipeline_df, escape = FALSE, container = sketch,
                extensions = c('Buttons', 'ColReorder', 'FixedColumns' ,'Responsive'),
                options = list(
                  dom = 'Bfrtip',
                  buttons = c('colvis', 'copy', 'csv', 'excel', 'pdf', 'print'),
                  colReorder = TRUE
                )
  )
}