## ----setup, include=FALSE-------------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
knitr::opts_chunk$set(echo = TRUE)

## -------------------------------------------------------------------------------------
library(knitr)
opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.width=6, fig.height=6, fig.align='center', size="small", ps=10, strip.white = TRUE,
                    comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## ----CodeControl, echo=FALSE----------------------------------------------------------
xtras=FALSE
## xtras <- TRUE
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)
## opts_chunk[['set']](eval=T)

## ----fig.width=4, fig.height=4,fig.show="hold", fig.align="default", out.width="48.5%"----
#  z <- seq(-4,4,length=101)
#  plot(z, dnorm(z), type="l", ylab="Normal density")
#  plot(z, dt(z, df=5), type="l", ylab="t-statistic density, 5 df")

## ----fig.width=4, fig.height=4,fig.show="hold", fig.align="default", out.width="48.5%"----
#  Hmisc::knitrSet(basename="tmp", lang='markdown', fig.path="figs/g", w=6, h=6)
#  z <- seq(-4,4,length=101)
#  plot(z, dnorm(z), type="l", ylab="Normal density")
#  plot(z, dt(z, df=5), type="l", ylab="t-statistic density, 5 df")

