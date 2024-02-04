# Code and Other Resources for "A Practical Guide to Data Analysis Using R"

This website makes available code and other supplementary content 
that relates to the new Cambridge University Press text, due to
appear in print in May or June 2024.

"A Practical Guide to Data Analysis Using R -- An Example-Based Approach",  
by John H Maindonald, W John Braun, and Jeffrey L Andrews.   

The new text builds on "Data Analysis and Graphics Using R" (Maindonald 
and Braun, CUP, 3rd edn, 2010.)

<!-- badges: start -->
  [![R-CMD-check](https://github.com/jhmaindonald/PGRcode/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jhmaindonald/PGRcode/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

To install the package that holds the files from the website,
proceed thus:
```
## If necessary, first install the 'remotes' package
if(!require("remotes"))install.packages("remotes")
remotes::install_github('jhmaindonald/PGRcode')
```
R files that have the code, html browser files, and Rmd files from
which these have been generated, should then be available under 
"User guides, package vignettes and other documentation".

Individual code files or other vignette files can be accessed by going
to https://github.com/jhmaindonald/PGRcode/tree/main/inst/doc/, then clicking 
on the file name of interest.  Click on first icon to the right of __Raw__
to copy the file, or on the second icon to download it. 

Or, from the R command line, type:
```
vigdir <- "https://github.com/jhmaindonald/PGRcode/raw/main/vignettes/"
if(!file.exists('~/tmp'))system('mkdir ~/tmp')
download.file(paste0(vigdir, 'ch1.Rmd'), '~/tmp/ch1.Rmd')
  ## Replace 'ch1' by other names as required.
```


