## ----setup, include = FALSE----------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----exampleCode, eval=F-------------------------------------------------------------------------
## tools::buildVignettes(dir = ".", tangle=TRUE)
## dir.create("inst")
## dir.create("inst/doc")
## file.copy(dir("vignettes", full.names=TRUE), "inst/doc", overwrite=TRUE)

