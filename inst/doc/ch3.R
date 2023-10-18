## ----CodeControl, echo=FALSE----------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
xtras <- F
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)

## ----setup, cache=FALSE, echo=FALSE---------------------------------------------------
#  Hmisc::knitrSet(basename="multilr", lang='markdown', fig.path="figs/g", w=7, h=7)
#  oldopt <- options(digits=4, formatR.arrow=FALSE, width=70, scipen=999)
#  library(knitr)
#  ## knitr::render_listings()
#  opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.align="center",
#                      fig.show='hold', size="small", ps=10, strip.white = TRUE,
#                      comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## ----C1a------------------------------------------------------------------------------
#  allbacks <- DAAG::allbacks  # Place the data in the workspace
#  allbacks.lm <- lm(weight ~ volume+area, data=allbacks)
#  print(coef(summary(allbacks.lm)), digits=2)

## ----3_1, echo=FALSE, w=3.5, h=3.5, left=-1, ps=10, out.width="45%"-------------------
#  xlim <- range(allbacks$volume)
#  xlim <- xlim+c(-.075,.075)*diff(xlim)
#  ## Plot of weight vs volume: data frame allbacks (DAAG)
#  plot(weight ~ volume, data=allbacks, pch=c(16,1)[unclass(cover)],
#  lwd=1.25, xlim=xlim, fg="gray")
#  ## unclass(cover) gives the integer codes that identify levels
#  ## As text() does not accept the parameter data, use with()
#  ## to specify the data frame.
#  with(allbacks, text(weight ~ volume, labels=paste(1:15), cex=0.75, offset=0.35,
#  pos=c(2,4)[unclass(cover)]))
#  legend(x='topleft', pch=c(16,1), legend=c("hardback  ","softback"),
#  horiz=T, bty="n", xjust=0.5, x.intersp=0.75, )

## ----3_1, eval=FALSE------------------------------------------------------------------
#  xlim <- range(allbacks$volume)
#  xlim <- xlim+c(-.075,.075)*diff(xlim)
#  ## Plot of weight vs volume: data frame allbacks (DAAG)
#  plot(weight ~ volume, data=allbacks, pch=c(16,1)[unclass(cover)],
#  lwd=1.25, xlim=xlim, fg="gray")
#  ## unclass(cover) gives the integer codes that identify levels
#  ## As text() does not accept the parameter data, use with()
#  ## to specify the data frame.
#  with(allbacks, text(weight ~ volume, labels=paste(1:15), cex=0.75, offset=0.35,
#  pos=c(2,4)[unclass(cover)]))
#  legend(x='topleft', pch=c(16,1), legend=c("hardback  ","softback"),
#  horiz=T, bty="n", xjust=0.5, x.intersp=0.75, )

## ----C1c------------------------------------------------------------------------------
#  ## Correlations between estimates -- model with intercept
#  round(summary(allbacks.lm, corr=TRUE)$correlation, 3)

## ----C1d------------------------------------------------------------------------------
#  out <- capture.output(summary(allbacks.lm,digits=2))
#  cat(out[15:17], sep='\n')

## ----C1e, size='normalsize'-----------------------------------------------------------
#  ## 5% critical value; t-statistic with 12 d.f.
#  qt(0.975, 12)

## ----C1f------------------------------------------------------------------------------
#  cat(out[5:7], sep='\n')

## ----C1_1a----------------------------------------------------------------------------
#  anova(allbacks.lm)

## ----C1_1b----------------------------------------------------------------------------
#  ## Show rows 1, 7, 8 and 15 only
#  model.matrix(allbacks.lm)[c(1,7,8,15), ]
#  ## NB, also, code that returns the data frame used
#  model.frame(allbacks.lm)

## ----C1_1c----------------------------------------------------------------------------
#  allbacks.lm0 <- lm(weight ~ -1+volume+area, data=allbacks)
#  print(coef(summary(allbacks.lm0)), digits=2)

## ----C1_2d----------------------------------------------------------------------------
#  ## Correlations between estimates -- no intercept
#  print(round(summary(allbacks.lm0, corr=TRUE)$correlation, 3))

## ----3_2, echo=FALSE, w=7.25, h=1.65, left=-0.5, mgp=c(1.85,0.5,0), top=1, ps=10, mfrow=c(1,4), out.width="100%"----
#  allbacks.lm0 <- lm(weight ~ -1+volume+area, data=allbacks)
#  plot(allbacks.lm0, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
#       'C: Scale-Location', '', 'D: Resids vs Leverage'), cex.caption=0.85,
#       fg='gray')

## ----3_2, eval=FALSE------------------------------------------------------------------
#  allbacks.lm0 <- lm(weight ~ -1+volume+area, data=allbacks)
#  plot(allbacks.lm0, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
#       'C: Scale-Location', '', 'D: Resids vs Leverage'), cex.caption=0.85,
#       fg='gray')

## ----C1_3a, eval=FALSE----------------------------------------------------------------
#  ## To show all plots in the one row, precede with
#  par(mfrow=c(1,4))      # Follow with par(mfrow=c(1,1))

## ----C1_3b, eval=xtras, w=7.25, h=1.65, mfrow=c(1,4)----------------------------------
#  ## The following has the default captions
#  plot(allbacks.lm0)

## ----C1_3d----------------------------------------------------------------------------
#  allbacks.lm13 <- lm(weight ~ -1+volume+area, data=allbacks[-13, ])
#  print(coef(summary(allbacks.lm13)), digits=2)

## ----3_3, w=4.5, h=4.65, echo=FALSE, lwd=0.75, out.width="49%"------------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  nihr <- within(DAAG::nihills, {mph <- dist/time; gradient <- climb/dist})
#  nihr <- nihr[, c("time", "dist", "climb", "gradient", "mph")]
#  varLabs <- c("\ntime\n(hours)","\ndist\n(miles)","\nclimb\n(feet)",
#               "\ngradient\n(ft/mi)", "\nmph\n(mph)")
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=0.5, spread=0)
#  car::spm(nihr, cex.labels=1.2, regLine=FALSE, col='blue',
#           oma=c(1.95,3,4, 3), gap=.25, var.labels=varLabs, smooth=smoothPars)
#  title(main="A: Untransformed scales:", outer=TRUE,
#  adj=0, line=-1.0, cex.main=1, font.main=1)
#  ## Panel B: Repeat with log(nihills) in place of nihills,
#  ## and with variable labels suitably modified.
#  varLabs <- c("\ntime\n(log h)","\ndist\n(log miles)", "\nclimb\n(log feet)",
#               "\ngradient\n(log ft/mi)", "\nmph\n(log mph)")
#  car::spm(log(nihr), regLine=FALSE, col="blue", oma=c(1.95,2.5,4, 2.5),
#           gap=.25, var.labels=varLabs, smooth=smoothPars)
#  title("B: Logarithmic scales", outer=TRUE,
#        adj=0, line=-1.0, cex.main=1, font.main=1)
#  par(oldpar)

## ----3_3, eval=F----------------------------------------------------------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  nihr <- within(DAAG::nihills, {mph <- dist/time; gradient <- climb/dist})
#  nihr <- nihr[, c("time", "dist", "climb", "gradient", "mph")]
#  varLabs <- c("\ntime\n(hours)","\ndist\n(miles)","\nclimb\n(feet)",
#               "\ngradient\n(ft/mi)", "\nmph\n(mph)")
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=0.5, spread=0)
#  car::spm(nihr, cex.labels=1.2, regLine=FALSE, col='blue',
#           oma=c(1.95,3,4, 3), gap=.25, var.labels=varLabs, smooth=smoothPars)
#  title(main="A: Untransformed scales:", outer=TRUE,
#  adj=0, line=-1.0, cex.main=1, font.main=1)
#  ## Panel B: Repeat with log(nihills) in place of nihills,
#  ## and with variable labels suitably modified.
#  varLabs <- c("\ntime\n(log h)","\ndist\n(log miles)", "\nclimb\n(log feet)",
#               "\ngradient\n(log ft/mi)", "\nmph\n(log mph)")
#  car::spm(log(nihr), regLine=FALSE, col="blue", oma=c(1.95,2.5,4, 2.5),
#           gap=.25, var.labels=varLabs, smooth=smoothPars)
#  title("B: Logarithmic scales", outer=TRUE,
#        adj=0, line=-1.0, cex.main=1, font.main=1)
#  par(oldpar)

## ----C2_1c----------------------------------------------------------------------------
#  ##  Hold climb constant at mean on logarithmic scale
#  mphClimb.lm <- lm(mph ~ log(dist)+log(climb), data = nihr)
#  ## Hold `gradient=climb/dist` constant at mean on logarithmic scale
#  mphGradient.lm <- lm(mph ~ log(dist)+log(gradient), data = nihr)
#  avRate <- mean(nihr$mph)
#  bClimb <- coef(mphClimb.lm)
#  constCl <- c(bClimb[1]+bClimb[3]*mean(log(nihr$climb)), bClimb[2])
#  bGradient <- coef(mphGradient.lm)
#  constSl <- c(bGradient[1]+bGradient[3]*mean((log(nihr$climb/nihr$dist))),
#               bGradient[2])
#  # Use `dist` and `climb` as explanatory variables
#  coef(mphClimb.lm)
#  # Use `dist` and `gradient` as explanatory variables
#  coef(mphGradient.lm)

## ----3_4, echo=FALSE, fig.width=8.25, fig.asp=0.5, out.width="90%", fig.show="hold"----
#  opar <- par(mfrow=c(1,2), mgp=c(2.25,0.5,0), mar=c(3.6,4.1,2.1,1.6))
#  lineCols <- c("red", adjustcolor("magenta",0.4))
#  yaxlab<-substitute(paste("Minutes per mile (Add ", ym, ")"), list(ym=round(avRate,2)))
#  car::crPlots(mphClimb.lm, terms = . ~ log(dist), xaxt='n',
#               xlab="Distance", col.lines=lineCols,  ylab=yaxlab)
#  axis(2, at=4:7, labels=paste(4:7))
#  labx <- c(4,8,16,32)
#  axis(1, at=log(2^(2:5)), labels=paste(2^(2:5)))
#  box(col="white")
#  mtext("A: Hold climb constant at mean value", adj=0,
#        line=0.8, at=0.6, cex=1.15)
#  car::crPlots(mphGradient.lm, terms = . ~log(dist), xaxt='n',
#               xlab="Distance", col.lines=lineCols, ylab=yaxlab)
#  axis(1, at=log(2^(2:5)), labels=paste(2^(2:5)))
#  axis(2, at=4:7, labels=paste(4:7))
#  box(col="white")
#  mtext("B: Hold log(gradient) constant at mean", adj=0, line=0.8, at=0.6, cex=1.15)
#  par(opar)

## ----3_4, eval=F----------------------------------------------------------------------
#  opar <- par(mfrow=c(1,2), mgp=c(2.25,0.5,0), mar=c(3.6,4.1,2.1,1.6))
#  lineCols <- c("red", adjustcolor("magenta",0.4))
#  yaxlab<-substitute(paste("Minutes per mile (Add ", ym, ")"), list(ym=round(avRate,2)))
#  car::crPlots(mphClimb.lm, terms = . ~ log(dist), xaxt='n',
#               xlab="Distance", col.lines=lineCols,  ylab=yaxlab)
#  axis(2, at=4:7, labels=paste(4:7))
#  labx <- c(4,8,16,32)
#  axis(1, at=log(2^(2:5)), labels=paste(2^(2:5)))
#  box(col="white")
#  mtext("A: Hold climb constant at mean value", adj=0,
#        line=0.8, at=0.6, cex=1.15)
#  car::crPlots(mphGradient.lm, terms = . ~log(dist), xaxt='n',
#               xlab="Distance", col.lines=lineCols, ylab=yaxlab)
#  axis(1, at=log(2^(2:5)), labels=paste(2^(2:5)))
#  axis(2, at=4:7, labels=paste(4:7))
#  box(col="white")
#  mtext("B: Hold log(gradient) constant at mean", adj=0, line=0.8, at=0.6, cex=1.15)
#  par(opar)

## ----C2_1f----------------------------------------------------------------------------
#  summary(mphClimb.lm, corr=T)$correlation["log(dist)", "log(climb)"]
#  summary(mphGradient.lm, corr=T)$correlation["log(dist)", "log(gradient)"]

## ----C2_1g, eval=FALSE----------------------------------------------------------------
#  ## Show the plots, with default captions
#  plot(mphClimb.lm, fg='gray')

## ----3_5, echo=FALSE, w=7.25, h=1.65, mgp=c(2.5,0.5,0), top=1, left=-0.5, bot=1, ps=10, mfrow=c(1,4), out.width="100%"----
#  plot(mphGradient.lm, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
#  'C: Scale-Location', '', 'D: Resids vs Leverage'),
#  cex.caption=0.85, fg='gray')

## ----3_5, eval=FALSE------------------------------------------------------------------
#  plot(mphGradient.lm, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
#  'C: Scale-Location', '', 'D: Resids vs Leverage'),
#  cex.caption=0.85, fg='gray')

## ----C2_2a----------------------------------------------------------------------------
#  lognihr <- setNames(log(nihr), paste0("log", names(nihr)))
#  timeClimb.lm <- lm(logtime ~ logdist + logclimb, data = lognihr)

## ----3_6, echo=FALSE, w=7.25, h=1.65, mgp=c(2.5,0.5,0), top=1, left=-0.5, bot=1, ps=10, mfrow=c(1,4), out.width="100%"----
#  plot(timeClimb.lm, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
#                               'C: Scale-Location', '', 'D: Resids vs Leverage'),
#                               cex.caption=0.85, fg='gray')

## ----C2_2d----------------------------------------------------------------------------
#  print(coef(summary(timeClimb.lm)), digits=2)

## ----C2_2f----------------------------------------------------------------------------
#  timeGradient.lm <- lm(logtime ~ logdist + loggradient, data=lognihr)
#  print(coef(summary(timeGradient.lm)), digits=3)

## ----3_7, w=3.65, h=4.0, echo=FALSE, lwd=0.75, out.width="49%"------------------------
#  oldpar <- par(fg='gray40',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  ## Code for Panel A
#  oddbooks <- DAAG::oddbooks
#  pairs(log(oddbooks), lower.panel=panel.smooth, upper.panel=panel.smooth,
#        labels=c("log(thick)", "log(breadth)", "log(height)", "log(weight)"),
#        gap=0.25, oma=c(1.95,1.95,4, 1.95), col='blue')
#  title(main="A: Columns from log(oddbooks)",
#        outer=TRUE, adj=0, line=-1.0, cex.main=1.1, font.main=1)
#  ## Panel B
#  oddothers <-
#    with(oddbooks, data.frame(density = weight/(breadth*height*thick),
#  area = breadth*height, thick=thick, weight=weight))
#  pairs(log(oddothers), lower.panel=panel.smooth, upper.panel=panel.smooth,
#  labels=c("log(density)", "log(area)", "log(thick)", "log(weight)"),
#  gap=0.5, oma=c(1.95,1.95,4, 1.95), col='blue')
#  title("B: Add density & area; omit breadth & height",
#  outer=TRUE, adj=0, line=-1.0, cex.main=1.1, font.main=1)
#  par(oldpar)

## ----3_7, eval=F----------------------------------------------------------------------
#  oldpar <- par(fg='gray40',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  ## Code for Panel A
#  oddbooks <- DAAG::oddbooks
#  pairs(log(oddbooks), lower.panel=panel.smooth, upper.panel=panel.smooth,
#        labels=c("log(thick)", "log(breadth)", "log(height)", "log(weight)"),
#        gap=0.25, oma=c(1.95,1.95,4, 1.95), col='blue')
#  title(main="A: Columns from log(oddbooks)",
#        outer=TRUE, adj=0, line=-1.0, cex.main=1.1, font.main=1)
#  ## Panel B
#  oddothers <-
#    with(oddbooks, data.frame(density = weight/(breadth*height*thick),
#  area = breadth*height, thick=thick, weight=weight))
#  pairs(log(oddothers), lower.panel=panel.smooth, upper.panel=panel.smooth,
#  labels=c("log(density)", "log(area)", "log(thick)", "log(weight)"),
#  gap=0.5, oma=c(1.95,1.95,4, 1.95), col='blue')
#  title("B: Add density & area; omit breadth & height",
#  outer=TRUE, adj=0, line=-1.0, cex.main=1.1, font.main=1)
#  par(oldpar)

## ----C2_5d----------------------------------------------------------------------------
#  lob3.lm <- lm(log(weight) ~ log(thick)+log(breadth)+log(height),
#                data=oddbooks)
#  coef(summary(lob3.lm))
#  drop1(lob3.lm)           # Compare all three leave one out models

## ----C2_5e----------------------------------------------------------------------------
#  lob2.lm <- lm(log(weight) ~ log(thick)+log(breadth), data=oddbooks)
#  coef(summary(lob2.lm))

## ----C2_5f----------------------------------------------------------------------------
#  lob0.lm <- lm(log(weight) ~ 1, data=oddbooks)
#  add1(lob0.lm, scope=~log(breadth) + log(thick) + log(height))
#  lob1.lm <- update(lob0.lm, formula=. ~ .+log(breadth))

## ----C2_5g----------------------------------------------------------------------------
#  round(rbind("lob1.lm"=predict(lob1.lm), "lob2.lm"=predict(lob2.lm),
#              "lob3.lm"=predict(lob3.lm)),2)

## ----C2_5h----------------------------------------------------------------------------
#  oddbooks <- within(oddbooks, density <- weight/(thick*breadth*height))
#  lm(log(weight) ~ log(density), data=oddbooks) |> summary() |> coef() |>
#    round(3)

## ----C2.5i, eval=xtras----------------------------------------------------------------
#  ## Code that the reader may care to try
#  lm(log(weight) ~ log(thick)+log(breadth)+log(height)+log(density),
#     data=oddbooks) |> summary() |> coef() |> round(3)

## ----3_8, echo=FALSE, w=3.5, h=3.5, out.width="55%"-----------------------------------
#  oldpar <- par(fg='gray40',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  litters <- DAAG::litters
#  pairs(litters, labels=c("lsize\n\n(litter size)", "bodywt\n\n(Body Weight)",
#                          "brainwt\n\n(Brain Weight)"), gap=0.5, fg='gray',
#                          col="blue", oma=rep(1.95,4))
#  par(oldpar)

## ----3_8, eval=F----------------------------------------------------------------------
#  oldpar <- par(fg='gray40',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  litters <- DAAG::litters
#  pairs(litters, labels=c("lsize\n\n(litter size)", "bodywt\n\n(Body Weight)",
#                          "brainwt\n\n(Brain Weight)"), gap=0.5, fg='gray',
#                          col="blue", oma=rep(1.95,4))
#  par(oldpar)

## ----C2_6c----------------------------------------------------------------------------
#  ## Regression of brainwt on lsize
#  summary(lm(brainwt ~ lsize, data = litters), digits=3)$coef
#  ## Regression of brainwt on lsize and bodywt
#  summary(lm(brainwt ~ lsize + bodywt, data = litters), digits=3)$coef

## ----C3_2a----------------------------------------------------------------------------
#  oddbooks.lm <- lm((weight) ~ log(thick)+log(height)+log(breadth),
#  data=DAAG::oddbooks)
#  yterms <- predict(oddbooks.lm, type="terms")

## ----3_9, echo=FALSE, w=5.5, h=1.65, bot=1, mgp=c(2,0.5,0), mfrow=c(1,3), cex.lab=0.7, ps=10, out.width="100%"----
#  oddbooks.lm <- lm(log(weight) ~ log(thick)+log(height)+log(breadth),
#  data=DAAG::oddbooks)
#  termplot(oddbooks.lm, partial.resid = TRUE, smooth=panel.smooth,
#  col.res="gray40", transform.x=TRUE, fg="gray")

## ----C3_3a----------------------------------------------------------------------------
#  ## Use car::powerTransform
#  nihr <- within(DAAG::nihills, {mph <- dist/time; gradient <- climb/dist})
#  summary(car::powerTransform(nihr[, c("dist", "gradient")]), digits=3)

## ----C3_3b----------------------------------------------------------------------------
#  form <- mph ~ log(dist) + log(gradient)
#  summary(car::powerTransform(form, data=nihr))

## ----C3_4a----------------------------------------------------------------------------
#  lognihr <- log(DAAG::nihills)
#  names(lognihr) <- paste0("log", names(lognihr))
#  timeClimb.lm <- lm(logtime  ~ logdist + logclimb, data = lognihr)
#  ## Coverage intervals; use exp() to undo the log transformation
#  citimes <- exp(predict(timeClimb.lm, interval="confidence"))
#  ## Prediction intervals, i.e., for new observations
#  pitimes <- exp(predict(timeClimb.lm, newdata=lognihr, interval="prediction"))
#  ## fit ci:lwr ci:pwr pi:lwr pi:upr
#  ci_then_pi <- cbind(citimes, pitimes[,2:3])
#  colnames(ci_then_pi) <- paste0(c("", rep(c("ci-","pi-"), c(2,2))),
#                                 colnames(ci_then_pi))
#  ## First 4 rows
#  print(ci_then_pi[1:4,], digits=2)

## ----3_10-----------------------------------------------------------------------------
#  timeClimb2.lm <- update(timeClimb.lm, formula = . ~ . + I(logdist^2))
#  g3.10 <-
#  function(model1=timeClimb.lm, model2=timeClimb2.lm)
#  {
#  ## Panel A
#  citimes <- predict(model1, interval="confidence")
#  ord <- order(citimes[,"fit"])
#  citimes <- citimes[ord,]
#  hat <- citimes[,"fit"]
#  pitimes <- predict(model1, newdata=lognihr, interval="prediction")[ord,]
#  logobs <- log(nihr[ord,"time"])
#  xtiks <- pretty(exp(hat))
#  ylim <- range(c(pitimes[,"lwr"], pitimes[,"upr"], logobs)-rep(hat,3))
#  logytiks <- pretty(ylim,5)
#  ytiks <- round(exp(logytiks),2)
#  xlim <- range(hat)
#  plot(hat, citimes[,"lwr"]-hat, type="n", xlab = "Time (fitted)",
#  ylab = "Difference from fit",
#  xlim=xlim, ylim = ylim, xaxt="n", yaxt="n", fg="gray")
#  mtext(side=3, line=0.75, adj=0, at=-2.0, "A: CIs and PIs: Mean, prediction")
#  mtext(side=4, line=1.25, "exp(Difference from fit)", las=0)
#  axis(1, at=log(xtiks), labels=paste(xtiks), lwd=0, lwd.ticks=1)
#  axis(2, at=logytiks, las=1, lwd=0, lwd.ticks=1)
#  axis(4, at=logytiks, labels=paste(ytiks), las=0, lwd=0, lwd.ticks=1)
#  points(hat, logobs-hat, pch=16, cex=0.65)
#  lines(hat, citimes[,"lwr"]-hat, col = "red")
#  lines(hat, citimes[,"upr"]-hat, col = "red")
#  lines(hat, pitimes[,"lwr"]-hat, col = "black")
#  lines(hat, pitimes[,"upr"]-hat, col = "black")
#  ## Panel B
#  citimes2 <- predict(model2, interval="confidence")[ord,]
#  plot(hat, citimes[,"lwr"]-hat, type="n", xlab = "Time (fitted)",
#  ylab = "Difference from fit",
#  xlim=xlim, ylim = ylim, xaxt="n", yaxt="n", fg="gray")
#  mtext(side=3, line=0.75, adj=0, at=-2.0,
#  "B: CIs for fit, compare two models")
#  mtext(side=4, line=1.25, "exp(Difference from fit)", las=0)
#  axis(1, at=log(xtiks), labels=paste(xtiks), lwd=0, lwd.ticks=1)
#  axis(2, at=logytiks,las=1, lwd=0, lwd.ticks=1)
#  axis(4, at=logytiks, labels=paste(ytiks), las=0,, lwd=0, lwd.ticks=1)
#  points(hat, logobs-hat, pch=16, cex=0.65)
#  lines(hat, citimes[,"lwr"]-hat, col = "red")
#  lines(hat, citimes[,"upr"]-hat, col = "red")
#  hat2 <- citimes2[,"fit"]
#  lines(hat, citimes2[,"lwr"]-hat2, col = "blue", lty=2, lwd=1.5)
#  lines(hat, citimes2[,"upr"]-hat2, col = "blue", lty=2, lwd=1.5)
#  }

## ----3_10x, echo=FALSE, w=6.25, h=2.75, bot=1, top=1.5, rt=1.5, ps=9, mgp=c(2.15, 0.5,0), mar=c(3.6,3.1,4.1,3.1), mfrow=c(1,2), out.width="100%"----
#  g3.10()

## ----C3_4d----------------------------------------------------------------------------
#  timeClimb2.lm <- update(timeClimb.lm, formula = . ~ . + I(logdist^2))

## ----3_11, echo=FALSE, w=3.8, h=3.8, rt=2, lwd=0.75, out.width="55%"------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  hurric <- DAAG::hurricNamed[,c("LF.PressureMB", "BaseDam2014", "deaths")]
#  thurric <- car::powerTransform(hurric, family="yjPower")
#  transY <- car::yjPower(hurric, coef(thurric, round=TRUE))
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=1, spread=0)
#  car::spm(transY, lwd=0.5, regLine=FALSE, oma=rep(2.5,4), gap=0.5,
#           col="blue", smooth=smoothPars, cex.labels=1)
#  par(oldpar)

## ----3_11-----------------------------------------------------------------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  hurric <- DAAG::hurricNamed[,c("LF.PressureMB", "BaseDam2014", "deaths")]
#  thurric <- car::powerTransform(hurric, family="yjPower")
#  transY <- car::yjPower(hurric, coef(thurric, round=TRUE))
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=1, spread=0)
#  car::spm(transY, lwd=0.5, regLine=FALSE, oma=rep(2.5,4), gap=0.5,
#           col="blue", smooth=smoothPars, cex.labels=1)
#  par(oldpar)

## ----C3_5b----------------------------------------------------------------------------
#  modelform <- deaths ~ log(BaseDam2014) + LF.PressureMB
#  powerT <- car::powerTransform(modelform, data=as.data.frame(hurric),
#                                family="yjPower")
#  summary(powerT, digits=3)

## ----C3_5c----------------------------------------------------------------------------
#  deathP <- with(hurric, car::yjPower(deaths, lambda=-0.2))
#  power.lm <- MASS::rlm(deathP ~ log(BaseDam2014) + LF.PressureMB, data=hurric)
#  print(coef(summary(power.lm)),digits=2)

## ----3_12, w=7.25, h=1.65, echo=F, mgp=c(1.85,0.5,0), top=1, left=-0.5, ps=10, mfrow=c(1,4), out.width="100%", fig.pos="t"----
#  ## Use (deaths+1)^(-0.2) as outcome variable
#  plot(power.lm, cex.caption=0.85, fg="gray",
#    caption=list('A: Resids vs Fitted', 'B: Normal Q-Q', 'C: Scale-Location', '',
#                 'D: Resids vs Leverage'))

## ----3_12, eval=F---------------------------------------------------------------------
#  ## Use (deaths+1)^(-0.2) as outcome variable
#  plot(power.lm, cex.caption=0.85, fg="gray",
#    caption=list('A: Resids vs Fitted', 'B: Normal Q-Q', 'C: Scale-Location', '',
#                 'D: Resids vs Leverage'))

## ----3_13, echo=FALSE, w=3.5, h=3.5, lwd=0.75, out.width="55%"------------------------
#  hills2000 <- DAAG::hills2000[,c("dist", "climb", "time")]
#  varLabels <- c("\ndist\n(log miles)", "\nclimb\n(log feet)", "\ntime\n(log hours)")
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=1, spread=0)
#  hills2000 <- DAAG::hills2000[,c("dist", "climb", "time")]
#  varLabels <- c("\ndist\n(log miles)", "\nclimb\n(log feet)", "\ntime\n(log hours)")
#  car::spm(log(hills2000), smooth=smoothPars,  regLine=FALSE, cex.labels=1.5,
#  var.labels = varLabels, lwd=0.5, gap=0.5, oma=c(1.95,1.95,1.95,1.95))

## ----3_13, eval=F---------------------------------------------------------------------
#  hills2000 <- DAAG::hills2000[,c("dist", "climb", "time")]
#  varLabels <- c("\ndist\n(log miles)", "\nclimb\n(log feet)", "\ntime\n(log hours)")
#  smoothPars <- list(col.smooth='red', lty.smooth=2, lwd.smooth=1, spread=0)
#  hills2000 <- DAAG::hills2000[,c("dist", "climb", "time")]
#  varLabels <- c("\ndist\n(log miles)", "\nclimb\n(log feet)", "\ntime\n(log hours)")
#  car::spm(log(hills2000), smooth=smoothPars,  regLine=FALSE, cex.labels=1.5,
#  var.labels = varLabels, lwd=0.5, gap=0.5, oma=c(1.95,1.95,1.95,1.95))

## ----3_14, w=6, h=2.65, top=1, mgp=c(2,0.5,0), cex.lab=0.9, echo=FALSE, ps=9, mfrow=c(1,2), out.width="90%"----
#  ## Panel A
#  lhills2k.lm <- lm(log(time) ~ log(climb) + log(dist), data = hills2000)
#  plot(lhills2k.lm, caption="", which=1, fg="gray", col=adjustcolor("black", alpha=0.8))
#  mtext(side=3, line=0.75, "A: Least squares (lm) fit", adj=0, cex=1.1)
#  ## Panel B
#  lhills2k.lqs <- MASS::lqs(log(time) ~ log(climb) + log(dist), data = hills2000)
#  reres <- residuals(lhills2k.lqs)
#  refit <- fitted(lhills2k.lqs)
#  big3 <- which(abs(reres) >= sort(abs(reres), decreasing=TRUE)[3])
#  plot(reres ~ refit, xlab="Fitted values (resistant fit)",
#  ylab="Residuals (resistant fit)", col=adjustcolor("black", alpha=0.8), fg="gray")
#  lines(lowess(reres ~ refit), col=2)
#  text(reres[big3] ~ refit[big3], labels=rownames(hills2000)[big3],
#  pos=4-2*(refit[big3] > mean(refit)), cex=0.8)
#  mtext(side=3, line=0.75, "B: Resistant (lqs) fit", adj=0, cex=1.1)

## ----3_14, eval=F---------------------------------------------------------------------
#  ## Panel A
#  lhills2k.lm <- lm(log(time) ~ log(climb) + log(dist), data = hills2000)
#  plot(lhills2k.lm, caption="", which=1, fg="gray", col=adjustcolor("black", alpha=0.8))
#  mtext(side=3, line=0.75, "A: Least squares (lm) fit", adj=0, cex=1.1)
#  ## Panel B
#  lhills2k.lqs <- MASS::lqs(log(time) ~ log(climb) + log(dist), data = hills2000)
#  reres <- residuals(lhills2k.lqs)
#  refit <- fitted(lhills2k.lqs)
#  big3 <- which(abs(reres) >= sort(abs(reres), decreasing=TRUE)[3])
#  plot(reres ~ refit, xlab="Fitted values (resistant fit)",
#  ylab="Residuals (resistant fit)", col=adjustcolor("black", alpha=0.8), fg="gray")
#  lines(lowess(reres ~ refit), col=2)
#  text(reres[big3] ~ refit[big3], labels=rownames(hills2000)[big3],
#  pos=4-2*(refit[big3] > mean(refit)), cex=0.8)
#  mtext(side=3, line=0.75, "B: Resistant (lqs) fit", adj=0, cex=1.1)

## ----C4_1c, eval=FALSE----------------------------------------------------------------
#  ## Show only the 2nd diognostic plot, i.e., a normal Q-Q plot
#  ## plot(lhills2k.lm, which=2)

## ----C4_2a----------------------------------------------------------------------------
#  round(unname(hatvalues(timeClimb.lm)),2)

## ----3_15, echo=FALSE, w=4, h=4.5, top=1, lwd=0.75, ps=10, out.width="40%"------------
#  ## Residuals versus leverages
#  nihills <- DAAG::nihills
#  timeClimb.lm <- lm(log(time)  ~ log(dist) + log(climb), data = nihills)
#  plot(timeClimb.lm, which=5, add.smooth=FALSE, ps=9, sub.caption="",
#       cex.caption=1.1, fg="gray")
#    ## The points can alternatively be plotted using
#    ## plot(hatvalues(model.matrix(timeClimb.lm)), residuals(timeClimb.lm))

## ----3_15, eval=FALSE-----------------------------------------------------------------
#  ## Residuals versus leverages
#  nihills <- DAAG::nihills
#  timeClimb.lm <- lm(log(time)  ~ log(dist) + log(climb), data = nihills)
#  plot(timeClimb.lm, which=5, add.smooth=FALSE, ps=9, sub.caption="",
#       cex.caption=1.1, fg="gray")
#    ## The points can alternatively be plotted using
#    ## plot(hatvalues(model.matrix(timeClimb.lm)), residuals(timeClimb.lm))

## ----C4_2b, eval=F--------------------------------------------------------------------
#  ## Residuals versus leverages
#  plot(timeClimb.lm, which=5, add.smooth=FALSE)
#  ## The points can alternatively be plotted using
#  ## plot(hatvalues(model.matrix(timeClimb.lm)), residuals(timeClimb.lm))

## ----C4_2c, eval=FALSE----------------------------------------------------------------
#  ## This code is designed to be evaluated separately from other chunks
#  with(nihills, scatter3d(x=log(dist), y=log(climb), z=log(time), grid=FALSE,
#                          point.col="black", surface.col="gray60",
#                          surface.alpha=0.2, axis.scales=FALSE))
#  with(nihills, Identify3d(x=log(dist), y=log(climb), z=log(time),
#                  labels=row.names(DAAG::nihills), minlength=8), offset=0.05)
#  ## To rotate display, hold down the left mouse button and move the mouse.
#  ## To put labels on points, right-click and drag a box around them, perhaps
#  ## repeatedly.  Create an empty box to exit from point identification mode.

## ----3_16, w=4.25, h=1.4, bot=1, left=1, top=1, ps=9, mgp=c(1.25,0.25,0), echo=FALSE----
#  allbacks.lm0 <- lm(weight ~ -1+volume+area, data=allbacks)
#  z <- dfbetas(allbacks.lm0)
#  par(xpd=T, mgp=c(1.5,0.25,0))
#  plot(range(z), c(0.25,1), xlab="Standardized change in coefficient",
#  ylab="", axes=F, type="n", cex.lab=0.9)
#  chh <- par()$cxy[2]
#  axis(1, lwd=0, lwd.ticks=1)
#  abline(h=par()$usr[3])
#  m <- dim(z)[1]
#  points(z[,1], rep(0.5,m), pch="|")
#  points(z[,2], rep(1.0,m), pch="|")
#  idrows <- (1:m)[apply(z,1,function(x)any(abs(x)>2))]
#  if(length(idrows)>0)text(z[idrows,],rep(c(.5,1)-0.25*chh,rep(length(idrows),2)),
#  rep(paste(idrows), 2), pos=3, cex=0.8, offset=0.65)
#  par(family="mono")
#  text(rep(par()$usr[1],2), c(.5,1), c("volume", "area"), pos=2)
#  title(sub="dfbetas(allbacks.lm0)")
#  par(family="sans")

## ----3_15, eval=F---------------------------------------------------------------------
#  ## Residuals versus leverages
#  nihills <- DAAG::nihills
#  timeClimb.lm <- lm(log(time)  ~ log(dist) + log(climb), data = nihills)
#  plot(timeClimb.lm, which=5, add.smooth=FALSE, ps=9, sub.caption="",
#       cex.caption=1.1, fg="gray")
#    ## The points can alternatively be plotted using
#    ## plot(hatvalues(model.matrix(timeClimb.lm)), residuals(timeClimb.lm))

## ----C4_2d, w=4.5, h=4.5, out.width="50%"---------------------------------------------
#  ## As an indication of what is available, try
#  car::influencePlot(allbacks.lm)

## ----C5_3a----------------------------------------------------------------------------
#  ## Calculations using mouse brain weight data
#  mouse.lm <- lm(brainwt ~ lsize+bodywt, data=DAAG::litters)
#  mouse0.lm <- update(mouse.lm, formula = . ~ . - lsize)

## ----C5_3b----------------------------------------------------------------------------
#  aicc <- sapply(list(mouse0.lm, mouse.lm), AICcmodavg::AICc)
#  infstats <- cbind(AIC(mouse0.lm, mouse.lm), AICc=aicc,
#                    BIC=BIC(mouse0.lm, mouse.lm)[,-1])
#  print(rbind(infstats, "Difference"=apply(infstats,2,diff)), digits=3)

## ----3_17, w=6, h=3.5, echo=F, out.width="80%"----------------------------------------
#  library(lattice)
#  df <- data.frame(n=5:35, AIC=rep(2,31), BIC=log(5:35))
#  cfAICc <- function(n,p,d) 2*(p+d)*n/(n-(p+d)-1) - 2*p*n/(n-p-1)
#  df <- cbind(df, AICc12=cfAICc(5:35,1,1), AICc34=cfAICc(5:35,3,1))
#  labs <- sort(c(2^(0:6),2^(0:6)*1.5))
#  xyplot(AICc12+AICc34+AIC+BIC ~ n, data=df, type='l', auto.key=list(columns=4),
#         scales=list(y=list(log=T, at=labs, labels=paste(labs))),
#   par.settings=simpleTheme(lty=c(1,1:3), lwd=2, col=rep(c('gray','black'), c(1,3))))

## ----3_17, eval=F---------------------------------------------------------------------
#  library(lattice)
#  df <- data.frame(n=5:35, AIC=rep(2,31), BIC=log(5:35))
#  cfAICc <- function(n,p,d) 2*(p+d)*n/(n-(p+d)-1) - 2*p*n/(n-p-1)
#  df <- cbind(df, AICc12=cfAICc(5:35,1,1), AICc34=cfAICc(5:35,3,1))
#  labs <- sort(c(2^(0:6),2^(0:6)*1.5))
#  xyplot(AICc12+AICc34+AIC+BIC ~ n, data=df, type='l', auto.key=list(columns=4),
#         scales=list(y=list(log=T, at=labs, labels=paste(labs))),
#   par.settings=simpleTheme(lty=c(1,1:3), lwd=2, col=rep(c('gray','black'), c(1,3))))

## ----C5_3c----------------------------------------------------------------------------
#  ## Obtain AIC or BIC using `drop1()` or `add1()`
#  n <- nrow(DAAG::litters)
#  drop1(mouse.lm, scope=~lsize)              # AIC, with/without `lsize`
#  drop1(mouse.lm, scope=~lsize, k=log(n))   # BIC, w/wo `lsize`
#  add1(mouse0.lm, scope=~bodywt+lsize)     # AIC, w/wo `lsize`, alternative

## ----C5_3d----------------------------------------------------------------------------
#  suppressPackageStartupMessages(library(BayesFactor))
#  bf1 <- lmBF(brainwt ~ bodywt, data=DAAG::litters)
#  bf2 <- lmBF(brainwt ~ bodywt+lsize, data=DAAG::litters)
#  bf2/bf1

## ----C5_3e----------------------------------------------------------------------------
#  ## Relative support statistics
#  setNames(exp(-apply(infstats[,-1],2,diff)/2), c("AIC","AICc","BIC"))

## ----C5_3f----------------------------------------------------------------------------
#  lognihr <- log(DAAG::nihills)
#  lognihr <- setNames(log(nihr), paste0("log", names(nihr)))
#  timeClimb.lm <- lm(logtime ~ logdist + logclimb, data = lognihr)
#  timeClimb2.lm <- update(timeClimb.lm, formula = . ~ . + I(logdist^2))
#  print(anova(timeClimb.lm, timeClimb2.lm, test="F"), digits=4)

## ----C5_3g----------------------------------------------------------------------------
#  print(anova(timeClimb.lm, timeClimb2.lm, test="Cp"), digits=3)
#  ## Compare with the AICc difference
#  sapply(list(timeClimb.lm, timeClimb2.lm), AICcmodavg::AICc)

## ----C5_3h----------------------------------------------------------------------------
#  form1 <- update(formula(timeClimb.lm), ~ . + I(logdist^2) + logdist:logclimb)
#  addcheck <- add1(timeClimb.lm, scope=form1, test="F")
#  print(addcheck, digits=4)

## ----C5_4a----------------------------------------------------------------------------
#  ## Check how well timeClimb.lm model predicts for hills2000 data
#  timeClimb.lm <- lm(logtime  ~ logdist + logclimb, data = lognihr)
#  logscot <- log(subset(DAAG::hills2000,
#                 !row.names(DAAG::hills2000)=="Caerketton"))
#  names(logscot) <- paste0("log", names(hills2000))
#  scotpred <- predict(timeClimb.lm, newdata=logscot, se=TRUE)
#  trainVar <- summary(timeClimb.lm)[["sigma"]]^2
#  trainDF <- summary(timeClimb.lm)[["df"]][2]
#  mspe <- mean((logscot[,'logtime']-scotpred[['fit']])^2)
#  mspeDF <- nrow(logscot)

## ----C5_4b----------------------------------------------------------------------------
#  pf(mspe/trainVar, mspeDF, trainDF, lower.tail=FALSE)

## ----C5_4c----------------------------------------------------------------------------
#  scot.lm <- lm(logtime ~ logdist+logclimb, data=logscot)
#  signif(summary(scot.lm)[['sigma']]^2, 4)

## ----3_18, w=5.2, h=3.25, echo=FALSE, mfrow=c(2,4), out.width="95%XS"-----------------
#  set.seed(91)        # Reproduce plots as shown in text
#  gph <- DAAG::plotSimDiags(timeClimb.lm, layout=c(4,2), which=1)
#  update(gph, par.settings=list(fontsize=list(text=8, points=5)))

## ----C6_1a----------------------------------------------------------------------------
#  y <- rnorm(100)
#  ## Generate a 100 by 40 matrix of random normal data
#  xx <- matrix(rnorm(4000), ncol = 40)
#  dimnames(xx)<- list(NULL, paste("X",1:40, sep=""))

## ----C6_1b, warning=FALSE-------------------------------------------------------------
#  ## ## Find the best fitting model. (The 'leaps' package must be installed.)
#  xx.subsets <- leaps::regsubsets(xx, y, method = "exhaustive", nvmax = 3, nbest = 1)
#  subvar <- summary(xx.subsets)$which[3,-1]
#  best3.lm <- lm(y ~ -1+xx[, subvar])
#  print(summary(best3.lm, corr = FALSE))

## ----C6_1c----------------------------------------------------------------------------
#  ## DAAG::bestsetNoise(m=100, n=40)
#  best3 <- capture.output(DAAG::bestsetNoise(m=100, n=40))
#  cat(best3[9:14], sep='\n')

## ----3_20, echo=FALSE, w=4.25, h=2.75, top=1, ps=10, out.width="60%",message=FALSE, warning=FALSE, mgp=c(3,0.5,0)----
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  set.seed(41)
#  library(splines)
#  DAAG::bsnVaryNvar(nvmax=3, nvar = 3:35, xlab="")
#  mtext(side=1, line=1.75, "Number selected from")

## ----3_20, eval=F---------------------------------------------------------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20')
#  set.seed(41)
#  library(splines)
#  DAAG::bsnVaryNvar(nvmax=3, nvar = 3:35, xlab="")
#  mtext(side=1, line=1.75, "Number selected from")

## ----C6_2a----------------------------------------------------------------------------
#  data(Coxite, package="compositions")  # Places Coxite in the workspace
#    # NB: Proceed thus because `Coxite` is not exported from `compositions`
#  coxite <- as.data.frame(Coxite)

## ----3_19, echo=FALSE, w=4.5, h=4.5, lwd=0.5, ps=8, tcl=-0.25, out.width="100%"-------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20', tcl=-0.25)
#  panel.cor <- function(x, y, digits = 3, prefix = "", cex.cor=0.8, ...)
#  {
#  old.par <- par(usr = c(0, 1, 0, 1)); on.exit(par(old.par))
#  r <- abs(cor(x, y))
#  txt <- format(c(r, 0.123456789), digits = digits)[1]
#  txt <- paste0(prefix, txt)
#  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
#  text(0.5, 0.5, txt, cex = cex.cor * sqrt(r))
#  }
#  pairs(coxite, gap=0.4, col=adjustcolor("blue", alpha=0.9), upper.panel=panel.cor)
#  par(oldpar)

## ----3_19, eval=F---------------------------------------------------------------------
#  oldpar <- par(fg='gray20',col.axis='gray20',lwd=0.5,col.lab='gray20', tcl=-0.25)
#  panel.cor <- function(x, y, digits = 3, prefix = "", cex.cor=0.8, ...)
#  {
#  old.par <- par(usr = c(0, 1, 0, 1)); on.exit(par(old.par))
#  r <- abs(cor(x, y))
#  txt <- format(c(r, 0.123456789), digits = digits)[1]
#  txt <- paste0(prefix, txt)
#  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
#  text(0.5, 0.5, txt, cex = cex.cor * sqrt(r))
#  }
#  pairs(coxite, gap=0.4, col=adjustcolor("blue", alpha=0.9), upper.panel=panel.cor)
#  par(oldpar)

## ----C6_2d----------------------------------------------------------------------------
#  coxiteAll.lm <- lm(porosity ~ A+B+C+D+E+depth, data=coxite)
#  print(coef(summary(coxiteAll.lm)), digits=2)

## ----3_21, echo=FALSE, h=2.75, w=3.25, ps=9, tcl=-0.25, mgp=c(1.85,0.4,0), out.width="50%"----
#  coxiteAll.lm <- lm(porosity ~ A+B+C+D+E+depth, data=coxite)
#  coxite.hat <- predict(coxiteAll.lm, interval="confidence")
#  hat <- coxite.hat[,"fit"]
#  plot(porosity ~ hat, data=coxite, fg="gray", type="n", xlab="Fitted values",
#  ylab="Fitted values, with 95% CIs\n(Points are observed porosities)",
#  tcl=-0.35)
#  with(coxite, points(porosity ~ hat, cex=0.75, col="gray45"))
#  lines(hat, hat, lwd=0.75)
#  ord <- order(hat)
#  sebar <- function(x, y1, y2, eps=0.15, lwd=0.75){
#  lines(rep(x,2), c(y1,y2), lwd=lwd)
#  lines(c(x-eps,x+eps), rep(y1,2), lwd=lwd)
#  lines(c(x-eps,x+eps), rep(y2,2), lwd=lwd)
#  }
#  q <- ord[round(quantile(1:length(hat), (1:9)/10))]
#  for(i in q)sebar(hat[i], coxite.hat[i,"lwr"], coxite.hat[i,"upr"])
#  coxiteAll.lm <- lm(porosity ~ A+B+C+D+E+depth, data=coxite)
#  coxite.hat <- predict(coxiteAll.lm, interval="confidence")
#  hat <- coxite.hat[,"fit"]

## ----3_21, eval=FALSE-----------------------------------------------------------------
#  coxiteAll.lm <- lm(porosity ~ A+B+C+D+E+depth, data=coxite)
#  coxite.hat <- predict(coxiteAll.lm, interval="confidence")
#  hat <- coxite.hat[,"fit"]
#  plot(porosity ~ hat, data=coxite, fg="gray", type="n", xlab="Fitted values",
#  ylab="Fitted values, with 95% CIs\n(Points are observed porosities)",
#  tcl=-0.35)
#  with(coxite, points(porosity ~ hat, cex=0.75, col="gray45"))
#  lines(hat, hat, lwd=0.75)
#  ord <- order(hat)
#  sebar <- function(x, y1, y2, eps=0.15, lwd=0.75){
#  lines(rep(x,2), c(y1,y2), lwd=lwd)
#  lines(c(x-eps,x+eps), rep(y1,2), lwd=lwd)
#  lines(c(x-eps,x+eps), rep(y2,2), lwd=lwd)
#  }
#  q <- ord[round(quantile(1:length(hat), (1:9)/10))]
#  for(i in q)sebar(hat[i], coxite.hat[i,"lwr"], coxite.hat[i,"upr"])
#  coxiteAll.lm <- lm(porosity ~ A+B+C+D+E+depth, data=coxite)
#  coxite.hat <- predict(coxiteAll.lm, interval="confidence")
#  hat <- coxite.hat[,"fit"]

## ----C6_2f----------------------------------------------------------------------------
#  ## Pointwise confidence bounds can be obtained thus:
#  hat <- predict(coxiteAll.lm, interval="confidence", level=0.95)

## ----C6_3a----------------------------------------------------------------------------
#  print(DAAG::vif(lm(porosity ~ A+B+C+D+depth, data=coxite)), digits=2)

## ----C6_3b----------------------------------------------------------------------------
#  b <- leaps::regsubsets(porosity ~ ., data=coxite, nvmax=4, method='exhaustive')
#  ## The calculation fails for nvmax=5
#  inOut <- summary(b)[["which"]]
#  ## Extract and print the coefficents for the four regressions
#  dimnam <- list(rep("",4),c("Intercept", colnames(coxite)[-7]))
#  cmat <- matrix(nrow=4, ncol=7, dimnames=dimnam)
#  for(i in 1:4)cmat[i,inOut[i,]] <- signif(coef(b,id=1:4)[[i]],3)
#  outMat <- cbind(cmat,"  "=rep(NA,4),
#  as.matrix(as.data.frame(summary(b)[c("adjr2", "cp", "bic")])))
#  print(signif(outMat,3),na.print="")

## ----C6_3c----------------------------------------------------------------------------
#  BC.lm <- lm(porosity ~ B+C, data=coxite)
#  print(signif(coef(summary(BC.lm)), digits=3))
#  car::vif(BC.lm)

## ----C6_3d, mfrow=c(1,4), w=7.25, h=1.65, bot=1, top=1.5, rt=1.5, ps=9, mgp=c(2.15, 0.5,0), mar=c(3.6,3.1,4.1,3.1), out.width="100%"----
#  ## Diagnostic plots can be checked thus:
#  plot(BC.lm, eval=xtras)

## ----C6_3e----------------------------------------------------------------------------
#  coxiteR <- coxite
#  coxiteR[, 1:5] <- round(coxiteR[, 1:5])
#  coxiteR.lm <- lm(porosity ~ ., data=coxiteR)
#  print(coef(summary(coxiteR.lm)), digits=2)
#  print(DAAG::vif(lm(porosity ~ .-E, data=coxiteR)), digits=2)

## ----3_22, echo=FALSE, w=6.5, h=2.5, out.width="100%"---------------------------------
#  gph <- DAAG::errorsINx(gpdiff=0, plotit=FALSE, timesSDx=(1:4)/2,
#                         layout=c(5,1), print.summary=FALSE)[["gph"]]
#  parset <- DAAG::DAAGtheme(color=FALSE, alpha=0.6, lwd=2,
#                            col.points=c("gray50","black"),
#                            col.line=c("gray50","black"), lty=1:2)
#  update(gph, par.settings=parset)

## ----3_22, eval=F---------------------------------------------------------------------
#  gph <- DAAG::errorsINx(gpdiff=0, plotit=FALSE, timesSDx=(1:4)/2,
#                         layout=c(5,1), print.summary=FALSE)[["gph"]]
#  parset <- DAAG::DAAGtheme(color=FALSE, alpha=0.6, lwd=2,
#                            col.points=c("gray50","black"),
#                            col.line=c("gray50","black"), lty=1:2)
#  update(gph, par.settings=parset)

## ----3_23, echo=FALSE, w=5, h=2.7, out.width="80%"------------------------------------
#  gph <- DAAG::errorsINx(gpdiff=1.5, timesSDx=(1:2)*0.8, layout=c(3,1),
#  print.summary=FALSE, plotit=FALSE)[["gph"]]
#  parset <- DAAG::DAAGtheme(color=FALSE, alpha=0.6, lwd=2,
#                            col.points=c("gray50","black"),
#                            col.line=c("gray50","black"), lty=1:2)
#  update(gph, par.settings=parset)

## ----3_23, eval=F---------------------------------------------------------------------
#  gph <- DAAG::errorsINx(gpdiff=1.5, timesSDx=(1:2)*0.8, layout=c(3,1),
#  print.summary=FALSE, plotit=FALSE)[["gph"]]
#  parset <- DAAG::DAAGtheme(color=FALSE, alpha=0.6, lwd=2,
#                            col.points=c("gray50","black"),
#                            col.line=c("gray50","black"), lty=1:2)
#  update(gph, par.settings=parset)

## ----C8_1a----------------------------------------------------------------------------
#  coef(lm(area ~ volume + weight, data=allbacks))
#  b <- as.vector(coef(lm(weight ~ volume + area, data=allbacks)))
#  c("_Intercept_"=-b[1]/b[3], volume=-b[2]/b[3], weight=1/b[3])

## ----3_24, echo=FALSE, w=5, h=1.6, out.width="90%"------------------------------------
#  gaba <- DAAG::gaba
#  gabalong <- stack(gaba["30", -match('min', colnames(gaba))])
#  gabalong$sex <- factor(rep(c("male", "female","all"), rep(2,3)),
#  levels=c("female","male","all"))
#  gabalong$treatment <- factor(rep(c("Baclofen","No baclofen"), 3),
#  levels=c("No baclofen","Baclofen"))
#  gph <- lattice::stripplot(sex~values, groups=treatment, data=gabalong,
#  panel=function(x,y,...){
#  lattice::panel.stripplot(x,y,...)
#  lattice::ltext(x,y,paste(c(3,9,15,7,22,12)), pos=1, cex=0.8)
#  }, auto.key=list(space="right", points=TRUE, cex=0.8))
#  bw9 <- list(fontsize=list(text=9, points=5),
#  cex=c(1.5,1.5), pch=c(1,16))
#  update(gph, par.settings=parset,
#  xlab=list("Average reduction: 30 min vs 0 min", cex=1.0),
#  scales=list(cex=1.0, tck=0.35))

## ----3_24, eval=F---------------------------------------------------------------------
#  gaba <- DAAG::gaba
#  gabalong <- stack(gaba["30", -match('min', colnames(gaba))])
#  gabalong$sex <- factor(rep(c("male", "female","all"), rep(2,3)),
#  levels=c("female","male","all"))
#  gabalong$treatment <- factor(rep(c("Baclofen","No baclofen"), 3),
#  levels=c("No baclofen","Baclofen"))
#  gph <- lattice::stripplot(sex~values, groups=treatment, data=gabalong,
#  panel=function(x,y,...){
#  lattice::panel.stripplot(x,y,...)
#  lattice::ltext(x,y,paste(c(3,9,15,7,22,12)), pos=1, cex=0.8)
#  }, auto.key=list(space="right", points=TRUE, cex=0.8))
#  bw9 <- list(fontsize=list(text=9, points=5),
#  cex=c(1.5,1.5), pch=c(1,16))
#  update(gph, par.settings=parset,
#  xlab=list("Average reduction: 30 min vs 0 min", cex=1.0),
#  scales=list(cex=1.0, tck=0.35))

## ----C8_3a----------------------------------------------------------------------------
#  yONx.lm <- lm(logtime ~ logclimb, data=lognihr)
#  e_yONx <- resid(yONx.lm)
#  print(coef(yONx.lm), digits=4)

## ----C8_3b----------------------------------------------------------------------------
#  zONx.lm <- lm(logdist ~ logclimb, data=lognihr)
#  e_zONx <- resid(zONx.lm)
#  print(coef(yONx.lm), digits=4)

## ----C8_3c----------------------------------------------------------------------------
#  ey_xONez_x.lm <- lm(e_yONx ~ 0+e_zONx)
#  e_yONxz <- resid(ey_xONez_x.lm)
#  print(coef(ey_xONez_x.lm), digits=4)

## ----3_25, message=FALSE, warning=FALSE, w=6, h=2.7, top=1, bot=1, ps=10, mfrow=c(1,2), mgp=c(2.15, 0.5,0), cex.lab=0.9, echo=FALSE, out.width="85%"----
#  oldpar <- par(fg='gray')
#  ## Code for added variable plots
#  logtime.lm <- lm(logtime ~ logclimb+logdist, data=lognihr)
#  car::avPlots(logtime.lm, lwd=1, terms="logdist", fg="gray")
#  mtext(side=3, line=0.5, "A: Added var: 'logdist'", col="black", adj=0, cex=1.15)
#  car::avPlots(logtime.lm, lwd=1, terms="logclimb", fg="gray")
#  mtext(side=3, line=0.5, "B: Added var: 'logclimb'", col="black", adj=0, cex=1.15)
#  par(oldpar)

## ----3_25, eval=F---------------------------------------------------------------------
#  oldpar <- par(fg='gray')
#  ## Code for added variable plots
#  logtime.lm <- lm(logtime ~ logclimb+logdist, data=lognihr)
#  car::avPlots(logtime.lm, lwd=1, terms="logdist", fg="gray")
#  mtext(side=3, line=0.5, "A: Added var: 'logdist'", col="black", adj=0, cex=1.15)
#  car::avPlots(logtime.lm, lwd=1, terms="logclimb", fg="gray")
#  mtext(side=3, line=0.5, "B: Added var: 'logclimb'", col="black", adj=0, cex=1.15)
#  par(oldpar)

## ----C8_3e, eval=xtras, w=6, h=2.7, mfrow=c(1,2), out.width="95%"---------------------
#  ## One call to show both plots
#  car::avPlots(timeClimb.lm, terms=~.)

## ----C8_3f, eval=xtras, w=4, h=4, out.width="40%"-------------------------------------
#  ## Alternative code for first plot
#  plot(e_yONx ~ e_zONx)

## ----3_26, echo=FALSE, w=6, h=1.9, left=-1, top=1, cex.lab=0.9, ps=10, mgp=c(2,0.5,0), mfrow=c(1,3), out.width="100%"----
#  plot(yONx.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "A: From 'logtime' on 'logclimb'", adj=0, cex=0.85)
#  plot(zONx.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "B: From 'logdist' on 'logclimb'", adj=0, cex=0.85)
#  plot(ey_xONez_x.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "C: From AVP", adj=-0, cex=0.85)

## ----3_26, eval=F---------------------------------------------------------------------
#  plot(yONx.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "A: From 'logtime' on 'logclimb'", adj=0, cex=0.85)
#  plot(zONx.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "B: From 'logdist' on 'logclimb'", adj=0, cex=0.85)
#  plot(ey_xONez_x.lm, which=1, caption="", fg="gray")
#  mtext(side=3, line=0.5, "C: From AVP", adj=-0, cex=0.85)

## ----C8_3i----------------------------------------------------------------------------
#  ab1 <- coef(yONx.lm)
#  ab2 <- coef(zONx.lm)
#  b2 <- coef(ey_xONez_x.lm)
#  b1 <- ab1[2] - b2*ab2[2]
#  a <- ab1[1] - b2*ab2[1]

## ----C8_3j----------------------------------------------------------------------------
#  coef(lm(logtime ~ logclimb + logdist, data=lognihr))

## ----C8_4a----------------------------------------------------------------------------
#  nihr$climb.mi <- nihr$climb/5280
#  nihr.nls0 <- nls(time ~ (dist^alpha)*(climb.mi^beta), start =
#                      c(alpha = 0.68, beta = 0.465), data = nihr)
#  ## plot(residuals(nihr.nls0) ~ log(predict(nihr.nls0)))

## ----C8_4b----------------------------------------------------------------------------
#  signif(coef(summary(nihr.nls0)),3)

## ----C8_4c----------------------------------------------------------------------------
#  nihr.nls <- nls(time ~ gamma + delta1*dist^alpha + delta2*climb.mi^beta,
#  start=c(gamma = .045, delta1 = .09, alpha = 1,
#  delta2=.9, beta = 1.65), data=nihr)
#  ## plot(residuals(nihr.nls) ~ log(predict(nihr.nls)))

## ----C8_4d----------------------------------------------------------------------------
#  signif(coef(summary(nihr.nls)),3)

## ----C11a-----------------------------------------------------------------------------
#  ## ## Set up factor that identifies the `have' cities
#  cities <- DAAG::cities
#  cities$have <- with(cities, factor(REGION %in% c("ON","WEST"),
#                                     labels=c("Have-not","Have")))

## ----C11b, eval=xtras, w=6, h=2.7, out.width="95%"------------------------------------
#  gphA <- lattice::xyplot(POP1996~POP1992, groups=have, data=cities,
#                  auto.key=list(columns=2))
#  gphB<-lattice::xyplot(log(POP1996)~log(POP1992), groups=have, data=cities,
#                  auto.key=list(columns=2))
#  print(gphA, split=c(1,1,2,1), more=TRUE)
#  print(gphB, split=c(2,1,2,1))

## ----C11c-----------------------------------------------------------------------------
#  cities.lm1 <- lm(POP1996 ~ have+POP1992, data=cities)
#  cities.lm2 <- lm(log(POP1996) ~ have+log(POP1992), data=cities)

## ----C11d-----------------------------------------------------------------------------
#  nihills.lm <- lm(time ~ dist+climb, data=DAAG::nihills)
#  nihillsX.lm <- lm(time ~ dist+climb+dist:climb, data=DAAG::nihills)
#  anova(nihills.lm, nihillsX.lm)   # Use `anova()` to make the comparison
#  coef(summary(nihillsX.lm))       # Check coefficient for interaction term
#  drop1(nihillsX.lm)

## ----C11e-----------------------------------------------------------------------------
#  log(time) ~ log(dist) + log(climb)    ## lm model
#  time ~ alpha*dist + beta*I(climb^2)   ## nls model

## ----C11f-----------------------------------------------------------------------------
#  x1 <- runif(10)            # predictor which will be missing
#  x2 <- rbinom(10, 1, 1-x1)
#    ## observed predictor, depends on missing predictor
#  y <- 5*x1 + x2 + rnorm(10,sd=.1)  # simulated model; coef of x2 is positive
#  y.lm <- lm(y ~ factor(x2)) # model fitted to observed data
#  coef(y.lm)
#  y.lm2 <- lm(y ~ x1 + factor(x2))   # correct model
#  coef(y.lm2)

## ----C11g, eval=xtras, w=6, h=2.7, mfrow=c(1,2), out.width="95%"----------------------
#  bomData <- DAAG::bomregions2021
#  nraw.lqs <- MASS::lqs(northRain ~ SOI + CO2, data=bomData)
#  north.lqs <- MASS::lqs(I(northRain^(1/3)) ~ SOI + CO2, data=bomData)
#  plot(residuals(nraw.lqs) ~ Year, data=bomData)
#  plot(residuals(north.lqs) ~ Year, data=bomData)

## ----C11l, w=5, h=5, out.width="40%"--------------------------------------------------
#  socpsych <- subset(DAAG::repPsych, Discipline=='Social')
#  with(socpsych, scatter.smooth(T_r.R~T_r.O))
#  abline(v=.5)

## ----C11m, eval=xtras, w=4.5, h=4.5, out.width="40%"----------------------------------
#  soc.rlm <- MASS::rlm(T_r.R~T_r.O, data=subset(socpsych, T_r.O<=0.5))
#  ## Look at summary statistics
#  termplot(soc.rlm, partial.resid=T, se=T)

## ----C11n, eval=xtras, w=7.2, h=1.65, mfrow=c(1,4), out.width="100%"------------------
#  plot(soc.rlm)

