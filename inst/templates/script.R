#!/usr/bin/env Rscript

#### Options/Params and Help menu ####
library("optparse")
params_list <- list(
  make_option(c("-f", "--file"), action="store", 
              type='character', default=NA, 
              help="A input file"),
  make_option(c("-t", "--thread"), action="store", 
              type='integer', default=1,
              help="Number of threads [default - %default]"),
  make_option(c("-v", "--verbose"), action="store_true", 
              type='logical',default=TRUE,
              help="Make the program not be verbose [default - %default]"),
  make_option(c("-c", "--cvar"), action="store", 
              type='character', default="this is c",
              help="a variable named c, with a default [default - %default]") 
)
params = parse_args(OptionParser(option_list = params_list,
                                 description = "A simple R script template",
                                 usage = "script.R --file input.txt"
                                 )
                    )

#### Script required library ####
library(dplyr)

#### Main scrip starts here ####
paste("The input file is", params$file)
paste("Number of thread", params$thread)