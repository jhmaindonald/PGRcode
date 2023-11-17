## ----echo=F-----------------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, include = FALSE-------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setupCode, eval=F------------------------------------------------------
#  usethis::use_pkgdown()
#  pkgdown::build_site()
#  usethis::use_pkgdown_github_pages()

## ----exampleCode, eval=F----------------------------------------------------
#  tools::buildVignettes(dir = ".", tangle=FALSE)
#  if(!dir.exists('inst'))dir.create("~/pkgs/PGRcode/inst")
#  if(!dir.exists('inst/doc'))dir.create("~/pkgs/PGRcode/inst/doc")
#  ## On installation, files in 'inst/doc/' are copied to 'doc/'
#  file.copy(dir("vignettes", full.names=TRUE), "~/pkgs/PGRcode/inst/doc", overwrite=TRUE)
#  ## For an individual file, go e.g., for GITready.Rmd
#  tools::buildVignette('~/pkgs/PGRcode/vignettes/GITready.Rmd', dir = "inst/doc", tangle=F)

