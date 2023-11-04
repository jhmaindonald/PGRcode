# PGRcode -- Code and Complements for "A Practical Guide . . ."

Vignettes included in this package make available code and other supplementary content 
that relates to the new text  

"A Practical Guide to Data Analysis Using R -- An Example-Based Approach",  
by John H Maindonald, W John Braun, and Jeffrey L Andrews.   

The draft of this new text is currently making its way through the Cambridge University Press copy-editing process, and is due for publication in May 2024. It is a derivative of
"Data Analysis and Graphics Using R" (Maindonald and Braun, CUP, 3rd edn, 2010.)

<!-- badges: start -->
  [![R-CMD-check](https://github.com/jhmaindonald/PGRcode/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jhmaindonald/PGRcode/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

To install the package, do 
```
## If necessary, first install the 'remotes' package
if(!require("remotes"))install.packages("remotes")
remotes::install_github('jhmaindonald/PGRcode')
```
R files that have the code, html browser files, and Rmd files from
which these have been generated, should then be available under 
"User guides, package vignettes and other documentation".

Individual code files or other vignette files can be downloaded thus:
```
vigdir <- "https://github.com/jhmaindonald/PGRcode/raw/main/vignettes/"
if(!file.exists('~/tmp'))system('mkdir ~/tmp')
download.file(paste0(vigdir, 'ch1.Rmd'), '~/tmp/ch1.Rmd')
  ## Replace 'ch1' by other names as required.
```

Or, go to https://github.com/jhmaindonald/PGRcode/blob/main/vignettes/,
click on file name on the far left, then on the far right of the
row that is immediately above the first line of the file, click on
the download symbol that is the second symbol across from __Raw__.
