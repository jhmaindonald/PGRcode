
## setup
options(rmarkdown.html_vignette.check_title = FALSE)
knitr::opts_chunk$set(echo = TRUE)

## unnamed-chunk-1
library(knitr)
opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.width=6, fig.height=6, fig.align='center', size="small", ps=10, strip.white = TRUE,
                    comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## CodeControl
xtras=FALSE
## xtras <- TRUE
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)
## opts_chunk[['set']](eval=T)

## unnamed-chunk-2
z <- seq(-4,4,length=101)
plot(z, dnorm(z), type="l", ylab="Normal density")
plot(z, dt(z, df=5), type="l", ylab="t-statistic density, 5 df")

## unnamed-chunk-3
Hmisc::knitrSet(basename="tmp", lang='markdown', fig.path="figs/g", w=6, h=6)
z <- seq(-4,4,length=101)
plot(z, dnorm(z), type="l", ylab="Normal density")
plot(z, dt(z, df=5), type="l", ylab="t-statistic density, 5 df")

## unnamed-chunk-4
code <- knitr::knit_code$get()
txt <- paste0("\n## ", names(code),"\n", sapply(code, paste, collapse='\n'))
writeLines(txt, con="../inst/doc/UsingCode.R")
