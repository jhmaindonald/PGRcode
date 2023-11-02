## ----setup, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----exampleCode, eval=F------------------------------------------------------------------------
#  tools::buildVignettes(dir = ".", lib.loc='~/pkgs/PGRcode', tangle=TRUE)
#  if(!dir.exists('inst/doc')dir.create("inst/doc")
#  ## On installation, files in 'inst/doc/' are copied to 'doc/'
#  file.copy(dir("vignettes", full.names=TRUE), "inst/doc", overwrite=TRUE)

