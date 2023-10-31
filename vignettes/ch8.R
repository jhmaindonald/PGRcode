## ----CodeControl, echo=FALSE---------------------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
xtras <- F
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)

## ----setup, cache=FALSE--------------------------------------------------------------------------
#  Hmisc::knitrSet(basename="treebased", lang='markdown', fig.path="figs/g", w=7, h=7)
#  oldopt <- options(digits=4, formatR.arrow=FALSE, width=70, scipen=999)
#  library(knitr)
#  ## knitr::render_listings()
#  opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.align="center",
#                      fig.show='hold', size="small", ps=10, strip.white = TRUE,
#                      comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## ----latticePlus---------------------------------------------------------------------------------
#  suppressPackageStartupMessages(library(latticeExtra))

## ----8_1, w=8, h=4.0, bot=2, left=-1, las=0, echo=FALSE, mfrow=c(2,6), mgp=c(1,.5,0), fig.show='h', out.width="100%"----
#  nam <- c("crl.tot", "dollar", "bang", "money", "n000", "make")
#  nr <- sample(1:dim(DAAG::spam7)[1],500)
#  yesno<-DAAG::spam7$yesno[nr]
#  spam7a <- DAAG::spam7[nr,c(nam,"yesno")]
#  formab <- as.formula(paste(paste(nam, collapse='+'), '~ yesno'))
#  spamtheme <- DAAG::DAAGtheme(color = TRUE, pch=3)
#  lattice::bwplot(formab, data=spam7a, outer=T, horizontal=F, layout=c(7,1),
#    scales=list(relation='free'), ylab="", par.settings=spamtheme,
#    between=list(x=0.5),
#    main=list("A: Raw data values", y=1.0, font=1, cex=1.25))
#  spam7b <- cbind(log(spam7a[,-7]+0.001), yesno=spam7a[,7])
#  yval <-c(0.001, 0.001,0.01,0.1,1,10,100,1000,10000)
#  lattice::bwplot(formab, data=spam7b, outer=T, horizontal=F, layout=c(7,1),
#                  scales=list(relation='free',
#                  y=list(at=log(yval+0.001), labels=yval, rot=90)),
#                  ylab="", par.settings=spamtheme, between=list(x=0.5),
#  main=list(expression("B: Boxplots, using "*log(x+001)*" scale"),
#            y=1.0, font=1, cex=1.25))

## ----8_1, eval=F---------------------------------------------------------------------------------
#  nam <- c("crl.tot", "dollar", "bang", "money", "n000", "make")
#  nr <- sample(1:dim(DAAG::spam7)[1],500)
#  yesno<-DAAG::spam7$yesno[nr]
#  spam7a <- DAAG::spam7[nr,c(nam,"yesno")]
#  formab <- as.formula(paste(paste(nam, collapse='+'), '~ yesno'))
#  spamtheme <- DAAG::DAAGtheme(color = TRUE, pch=3)
#  lattice::bwplot(formab, data=spam7a, outer=T, horizontal=F, layout=c(7,1),
#    scales=list(relation='free'), ylab="", par.settings=spamtheme,
#    between=list(x=0.5),
#    main=list("A: Raw data values", y=1.0, font=1, cex=1.25))
#  spam7b <- cbind(log(spam7a[,-7]+0.001), yesno=spam7a[,7])
#  yval <-c(0.001, 0.001,0.01,0.1,1,10,100,1000,10000)
#  lattice::bwplot(formab, data=spam7b, outer=T, horizontal=F, layout=c(7,1),
#                  scales=list(relation='free',
#                  y=list(at=log(yval+0.001), labels=yval, rot=90)),
#                  ylab="", par.settings=spamtheme, between=list(x=0.5),
#  main=list(expression("B: Boxplots, using "*log(x+001)*" scale"),
#            y=1.0, font=1, cex=1.25))

## ----H1_2a, eval=FALSE, size='normalsize'--------------------------------------------------------
#  ## Obtain 500-row sample; repeat the first plot (of crl.tot)
#  spam.sample <- spam7[sample(seq(1,4601), 500, replace=FALSE), ]
#  boxplot(split(spam.sample$crl.tot, spam.sample$yesno))

## ----8_2, w=4.5, h=2.85, left=-3, ps=9, cache=FALSE, echo=FALSE, out.width="65%"-----------------
#  suppressMessages(library(rpart))
#  set.seed(31)      ## Reproduce tree shown in text
#  spam.rpart <- rpart(formula = yesno ~ crl.tot + dollar + bang + money + n000 +
#                      make,  method="class", model=TRUE, data=DAAG::spam7)
#  rpart.plot::rpart.plot(spam.rpart, type=0, under=TRUE, branch.lwd=0.4,
#                         nn.lwd=0.4, box.palette="auto", tweak=1.25)

## ----8_2, eval=F---------------------------------------------------------------------------------
#  suppressMessages(library(rpart))
#  set.seed(31)      ## Reproduce tree shown in text
#  spam.rpart <- rpart(formula = yesno ~ crl.tot + dollar + bang + money + n000 +
#                      make,  method="class", model=TRUE, data=DAAG::spam7)
#  rpart.plot::rpart.plot(spam.rpart, type=0, under=TRUE, branch.lwd=0.4,
#                         nn.lwd=0.4, box.palette="auto", tweak=1.25)

## ----H1_2b---------------------------------------------------------------------------------------
#  printcp(spam.rpart, digits=3)

## ----8_3, w=6, h=3.75, left=-3, lwd=0.75, ps=9, echo=FALSE, fig.show="hold", out.width="80%"-----
#  tree.df <- data.frame(fac = factor(rep(c('f1','f2'), 3)),
#  x = rep(1:3, rep(2, 3)), Node = 1:6)
#  u.tree <- rpart(Node ~ fac + x, data = tree.df,
#                  control = list(minsplit = 2, minbucket = 1, cp = 1e-009))
#  rpart.plot::rpart.plot(u.tree, type=0, under=TRUE, branch.lwd=0.25,
#                         nn.lwd=0.25, box.palette="Grays", tweak=1.6)

## ----8_3, eval=FALSE-----------------------------------------------------------------------------
#  tree.df <- data.frame(fac = factor(rep(c('f1','f2'), 3)),
#  x = rep(1:3, rep(2, 3)), Node = 1:6)
#  u.tree <- rpart(Node ~ fac + x, data = tree.df,
#                  control = list(minsplit = 2, minbucket = 1, cp = 1e-009))
#  rpart.plot::rpart.plot(u.tree, type=0, under=TRUE, branch.lwd=0.25,
#                         nn.lwd=0.25, box.palette="Grays", tweak=1.6)

## ----8_4, w=3.0, h=2.75, left=-1, ps=10, mgp=c(1.75,0.4,0), lwd=0.75, echo=FALSE, out.width="40%"----
#  u.lo <- loess(Mileage~Weight, data = car.test.frame, span = 2/3)
#  plot(Mileage~Weight, data=car.test.frame, xlab = "Weight",
#       ylab = "Miles per gallon", sub = "", fg="gray")
#  xy <- with(car.test.frame, loess.smooth(Weight, Mileage))
#  ord<-order(xy$x)
#  lines(xy$x[ord],xy$y[ord])

## ----8_4, eval=F---------------------------------------------------------------------------------
#  u.lo <- loess(Mileage~Weight, data = car.test.frame, span = 2/3)
#  plot(Mileage~Weight, data=car.test.frame, xlab = "Weight",
#       ylab = "Miles per gallon", sub = "", fg="gray")
#  xy <- with(car.test.frame, loess.smooth(Weight, Mileage))
#  ord<-order(xy$x)
#  lines(xy$x[ord],xy$y[ord])

## ----H2_4b, eval=FALSE---------------------------------------------------------------------------
#  ## loess fit to Mileage vs Weight: data frame car.test.frame (rpart)
#  with(rpart::car.test.frame, scatter.smooth(Mileage ~ Weight))

## ----8_5, w=4.8, h=1.9, bot=-1, left=-1, top=1, ps=9, mgp=c(2,0.5,0), lwd=0.75, echo=FALSE, out.width="100%"----
#  par(fig=c(0, 0.32, 0,1))
#  set.seed(37)
#  car.tree <- rpart(Mileage ~ Weight, data = car.test.frame)
#  rpart.plot::rpart.plot(car.tree, type=0, under=TRUE,
#                         box.palette="Grays", tweak=1.05)
#  par(fig=c(0.3,1, 0,1), new=TRUE)
#  set.seed(37)
#  car2.tree <- rpart(Mileage~Weight, data=car.test.frame, control =
#                     list(minsplit = 10, minbucket = 5, cp = 0.0001))
#  rpart.plot::rpart.plot(car2.tree, type=0, under=TRUE,
#  box.palette="auto", tweak=1.05)

## ----8_5, eval=F---------------------------------------------------------------------------------
#  par(fig=c(0, 0.32, 0,1))
#  set.seed(37)
#  car.tree <- rpart(Mileage ~ Weight, data = car.test.frame)
#  rpart.plot::rpart.plot(car.tree, type=0, under=TRUE,
#                         box.palette="Grays", tweak=1.05)
#  par(fig=c(0.3,1, 0,1), new=TRUE)
#  set.seed(37)
#  car2.tree <- rpart(Mileage~Weight, data=car.test.frame, control =
#                     list(minsplit = 10, minbucket = 5, cp = 0.0001))
#  rpart.plot::rpart.plot(car2.tree, type=0, under=TRUE,
#  box.palette="auto", tweak=1.05)

## ----H2_4c, eval=FALSE---------------------------------------------------------------------------
#  ## Panel A: Split criteria were left a their defaults
#  car.tree <- rpart(Mileage ~ Weight, data = car.test.frame)
#  rpart.plot::rpart.plot(car.tree, type=0, under=TRUE)
#  ## Panel B: Finer grained splits
#  car2.tree <- rpart(Mileage ~ Weight, data=car.test.frame, method="anova",
#                     control = list(minsplit = 10, minbucket = 5, cp = 0.0001))
#  ## See `?rpart::rpart.control` for details of control options.

## ----H2_4e---------------------------------------------------------------------------------------
#  dat <- data.frame(Weight=seq(from=min(car.test.frame$Weight),
#  to=max(car.test.frame$Weight)))
#  pred <- predict(car.tree, newdata=dat)
#  pred2 <- predict(car2.tree, newdata=dat)
#  lwr <- dat$Weight[c(1,diff(pred)) != 0]
#  upr <- dat$Weight[c(diff(pred),1) != 0]
#  xy2 <- with(car.test.frame, loess.smooth(Weight, Mileage, evaluation=2011))
#  lwrLO <- xy2$y[c(1,diff(pred)) != 0]
#  uprLO <- xy2$y[c(diff(pred),1) != 0]
#  round(rbind(lwr,upr,lwrLO,uprLO,
#  pred[c(diff(pred),1)!=0],pred2[c(diff(pred),1)!=0]),1)

## ----H2_5a, eval=FALSE---------------------------------------------------------------------------
#  vignette("longintro", package="rpart")

## ----8_6, w=6, h=2.75, left=1, top=2.5, cex.lab=0.9, echo=FALSE, ps=10, mfrow=c(1,2), results='hide', out.width="90%"----
#  car.rpart1 <- rpart(Price~., data=car.test.frame, cp=0.0001)
#  car.rpart2 <- rpart(Price~., data=car.test.frame, cp=0.0001)
#  car.rpart3 <- rpart(Price~., data=car.test.frame, cp=0.0001)
#  pr1 <- printcp(car.rpart1)
#  pr2 <- printcp(car.rpart2)
#  pr3 <- printcp(car.rpart3)
#  cp <- pr1[,"CP"]
#  cp0 <- sqrt(cp*c(Inf,cp[-length(cp)]))
#  nsplit <- pr1[,"nsplit"]
#  plot(nsplit,pr1[,"rel error"], xlab="No. of splits",
#  ylab="Relative error", type="b", fg="gray")
#  axis(3,at=nsplit, labels=paste(round(cp0,3)))
#  mtext(side=3, line=1.5, "Complexity parameter")
#  mtext(side =3, line=2,"A", adj=-0.2)
#  plot(nsplit,pr1[,"xerror"], xlab="No. of splits",
#  ylab="Xval relative error", type="b", fg="gray")
#  lines(nsplit,pr2[,"xerror"],lty=2, type="b")
#  lines(nsplit,pr2[,"xerror"],lty=3, type="b")
#  lines(nsplit,pr3[,"xerror"],lty=3, type="b")
#  axis(3,at=nsplit,labels=paste(round(cp0, 3)))
#  mtext(side=3,line=1.5, "Complexity parameter")
#  mtext(side =3, line=2,"B", adj=-0.2)

## ----H3_1a---------------------------------------------------------------------------------------
#  mifem <- DAAG::mifem
#  summary(mifem)     # data frame mifem (DAAG)

## ----H3_1b---------------------------------------------------------------------------------------
#  set.seed(29)      # Make results reproducible
#  mifem.rpart <- rpart(outcome ~ ., method="class", data = mifem, cp = 0.0025)

## ----H3_1c---------------------------------------------------------------------------------------
#  ## Tabular equivalent of Panel A from `plotcp(mifem.rpart)`
#  printcp(mifem.rpart, digits=3)

## ----H3_1d---------------------------------------------------------------------------------------
#  cat(c(". . .", capture.output(printcp(mifem.rpart, digits=3))[-(1:9)]),
#      sep="\n")

## ----8_7, w=7.0, h=2.75, bot=1, top=1, left=1.5, top=1.5, rt=1.5, mfrow=c(1,2), mgp=c(2.5,0.5,0), lwd=0.75, echo=FALSE, out.width="75%"----
#  plotcp(mifem.rpart, fg="gray", tcl=-0.25)
#  mifemb.rpart <- prune(mifem.rpart, cp=0.01)  ## Prune tree back to 2 leaves
#  rpart.plot::rpart.plot(mifemb.rpart, under=TRUE, type=4,
#                         box.palette=0, tweak=1.0)

## ----8_7, eval=FALSE-----------------------------------------------------------------------------
#  plotcp(mifem.rpart, fg="gray", tcl=-0.25)
#  mifemb.rpart <- prune(mifem.rpart, cp=0.01)  ## Prune tree back to 2 leaves
#  rpart.plot::rpart.plot(mifemb.rpart, under=TRUE, type=4,
#                         box.palette=0, tweak=1.0)

## ----H3_2a---------------------------------------------------------------------------------------
#  print(mifemb.rpart)

## ----H3_4a---------------------------------------------------------------------------------------
#  set.seed(59)
#  spam7a.rpart <- rpart(formula = yesno ~ crl.tot + dollar + bang +
#                        money + n000 + make, method="class", cp = 0.002,
#                        model=TRUE, data = DAAG::spam7)

## ----H3_4b---------------------------------------------------------------------------------------
#  printcp(spam7a.rpart, digits=3)

## ----H3_4c---------------------------------------------------------------------------------------
#  cpdf <- signif(as.data.frame(spam7a.rpart$cptable),3)
#  minRow <- which.min(cpdf[,"xerror"])
#  upr <- sum(cpdf[minRow, c("xerror","xstd")])
#  takeRow <- min((1:minRow)[cpdf[1:minRow,"xerror"]<upr])
#  newNsplit <- cpdf[takeRow, 'nsplit']
#  cpval <- mean(cpdf[c(takeRow-1,takeRow),"CP"])

## ----8_8, w=4.25, h=2.25, bot=-1, left=-1, top=1, right=-1, ps=10, mgp=c(2,0.5,0), lwd=0.75, echo=FALSE, out.width="100%"----
#  spam7b.rpart <- prune(spam7a.rpart, cp=cpval)
#  rpart.plot::rpart.plot(spam7b.rpart, under=TRUE, box.palette="Grays", tweak=1.65)

## ----8_8, eval=F---------------------------------------------------------------------------------
#  spam7b.rpart <- prune(spam7a.rpart, cp=cpval)
#  rpart.plot::rpart.plot(spam7b.rpart, under=TRUE, box.palette="Grays", tweak=1.65)

## ----H3_4d---------------------------------------------------------------------------------------
#  requireNamespace('randomForest', quietly=TRUE)
#  DAAG::compareTreecalcs(data=DAAG::spam7, fun="rpart")

## ----H3_4e, results='hide'-----------------------------------------------------------------------
#  acctree.mat <- matrix(0, nrow=100, ncol=6)
#  spam7 <- DAAG::spam7
#  for(i in 1:100)
#  acctree.mat[i,] <- DAAG::compareTreecalcs(data=spam7, fun="rpart")

## ----H4_1a---------------------------------------------------------------------------------------
#  suppressPackageStartupMessages(library(randomForest))
#  spam7.rf <- randomForest(yesno ~ ., data=spam7, importance=TRUE)
#  spam7.rf

## ----H4_1b---------------------------------------------------------------------------------------
#  z <- tuneRF(x=spam7[, -7], y=spam7$yesno, plot=FALSE)

## ----H4_1c---------------------------------------------------------------------------------------
#  zdash <- t(z[,2,drop=F])
#  colnames(zdash) <- paste0(c("mtry=",rep("",2)), z[,1])
#  round(zdash,3)

## ----H4_1d---------------------------------------------------------------------------------------
#  importance(spam7.rf)

## ----H4_2a---------------------------------------------------------------------------------------
#  Pima.tr <- MASS::Pima.tr
#  table(Pima.tr$type)

## ----H4_2b---------------------------------------------------------------------------------------
#  set.seed(41)     # This seed should reproduce the result given here
#  Pima.rf <- randomForest(type ~ ., data=Pima.tr)
#  ## The above is equivalent to:
#  ## Pima.rf <- randomForest(type ~ ., data=Pima.tr, sampsize=200)
#  round(Pima.rf$confusion,3)

## ----H4_2c---------------------------------------------------------------------------------------
#  tab <- prop.table(table(Pima.tr$type))

## ----H4_2d, eval=xtras---------------------------------------------------------------------------
#  Pima.rf <- randomForest(type ~ ., data=Pima.tr, sampsize=c(68,68))

## ----H4_2e, eval=xtras---------------------------------------------------------------------------
#  Pima.rf <- randomForest(type ~ ., data=Pima.tr, sampsize=c(132,68))

## ----8_9, w=6.5, h=3.0, bot=0.5, left=-0.5, top=1, cex.lab=0.9, mgp=c(2.0,.25,0),echo=FALSE, ps=10, mfrow=c(1,2), results='hide', cache=TRUE, out.width="80%"----
#  ## Accuracy comparisons
#  acctree.mat <- matrix(0, nrow=100, ncol=8)
#  colnames(acctree.mat) <- c("rpSEcvI", "rpcvI", "rpSEtest", "rptest",
#                            "n.SErule", "nre.min.12", "rfOOBI", "rftest")
#  for(i in 1:100)acctree.mat[i,] <- DAAG::compareTreecalcs(data=spam7, cp=0.0004,
#                                            fun=c("rpart", "randomForest"))
#  acctree.df <- data.frame(acctree.mat)
#  lims <- range(acctree.mat[, c(4,7,8)], na.rm=TRUE)
#  cthrublack <- adjustcolor("black", alpha.f=0.75)
#  # Panel A
#  plot(rfOOBI ~ rftest, data=acctree.df, xlab="Error rate - subset II", xlim=lims,
#       ylim=lims, ylab="OOB Error - fit to subset I", col=cthrublack, fg="gray")
#  abline(0,1)
#  mtext(side=3, line=0.5, "A", adj=0)
#  # Panel B
#  plot(rptest ~ rftest, data=acctree.df, xlab="Error rate - subset II",
#       ylab="rpart Error rate, subset II", xlim=lims, ylim=lims,
#       col=cthrublack, fg="gray")
#  abline(0,1)
#  mtext(side=3, line=0.5, "B", adj=0)

## ----8_9, eval=F---------------------------------------------------------------------------------
#  ## Accuracy comparisons
#  acctree.mat <- matrix(0, nrow=100, ncol=8)
#  colnames(acctree.mat) <- c("rpSEcvI", "rpcvI", "rpSEtest", "rptest",
#                            "n.SErule", "nre.min.12", "rfOOBI", "rftest")
#  for(i in 1:100)acctree.mat[i,] <- DAAG::compareTreecalcs(data=spam7, cp=0.0004,
#                                            fun=c("rpart", "randomForest"))
#  acctree.df <- data.frame(acctree.mat)
#  lims <- range(acctree.mat[, c(4,7,8)], na.rm=TRUE)
#  cthrublack <- adjustcolor("black", alpha.f=0.75)
#  # Panel A
#  plot(rfOOBI ~ rftest, data=acctree.df, xlab="Error rate - subset II", xlim=lims,
#       ylim=lims, ylab="OOB Error - fit to subset I", col=cthrublack, fg="gray")
#  abline(0,1)
#  mtext(side=3, line=0.5, "A", adj=0)
#  # Panel B
#  plot(rptest ~ rftest, data=acctree.df, xlab="Error rate - subset II",
#       ylab="rpart Error rate, subset II", xlim=lims, ylim=lims,
#       col=cthrublack, fg="gray")
#  abline(0,1)
#  mtext(side=3, line=0.5, "B", adj=0)

## ----H5_1a, eval=xtras---------------------------------------------------------------------------
#  acctree.mat <- matrix(0, nrow=100, ncol=8)
#  colnames(acctree.mat) <- c("rpSEcvI", "rpcvI", "rpSEtest", "rptest",
#                            "n.SErule", "nre.min.12", "rfcvI", "rftest")
#  for(i in 1:100)acctree.mat[i,] <- DAAG::compareTreecalcs(data=spam7,
#                                            fun=c("rpart", "randomForest"))
#  ## Panel A: Plot `rfOOBI` against `rftest`
#  ## Panel B: Plot `rptest` against `rftest`

## ----H7a-----------------------------------------------------------------------------------------
#  sapply(MASS::biopsy, function(x)sum(is.na(x)))   ## Will omit rows with NAs
#  biops <- na.omit(MASS::biopsy)[,-1]               ## Omit also column 1 (IDs)
#  ## Examine list element names in randomForest object
#  names(randomForest(class ~ ., data=biops))

## ----H7b-----------------------------------------------------------------------------------------
#  ## Repeated runs, note variation in OOB accuracy.
#  for(i in 1:10) {
#    biops.rf <- randomForest(class ~ ., data=biops)
#    OOBerr <- mean(biops.rf$err.rate[,"OOB"])
#    print(paste(i, ": ", round(OOBerr, 4), sep=""))
#    print(round(biops.rf$confusion,4))
#  }

## ----H7c-----------------------------------------------------------------------------------------
#  ## Repeated train/test splits: OOB accuracy vs test set accuracy.
#  for(i in 1:10){
#    trRows <- sample(1:dim(biops)[1], size=round(dim(biops)[1]/2))
#    biops.rf <- randomForest(class ~ ., data=biops[trRows, ],
#      xtest=biops[-trRows,-10], ytest=biops[-trRows,10])
#    oobErr <- mean(biops.rf$err.rate[,"OOB"])
#    testErr <- mean(biops.rf$test$err.rate[,"Test"])
#  print(round(c(oobErr,testErr),4))
#  }

## ----H7d-----------------------------------------------------------------------------------------
#  randomForest(class ~ ., data=biops, xtest=biops[,-10], ytest=biops[,10])

## ----H7e-----------------------------------------------------------------------------------------
#  ## Run model on total data
#  randomForest(as.factor(type) ~ ., data=Pima.tr)
#  rowsamp <- sample(dim(Pima.tr)[1], replace=TRUE)
#  randomForest(as.factor(type) ~ ., data=Pima.tr[rowsamp, ])

## ----H7f-----------------------------------------------------------------------------------------
#  d500 <- ggplot2::diamonds[sample(1:nrow(ggplot2::diamonds), 500),]
#  unlist(sapply(d500, class))  # Check the class of the 10 columns
#  car::spm(d500)       # If screen space is limited do two plots, thus:
#    # 1) variables 1 to 5 and 7 (`price`); 2) variables 6 to 10
#  plot(density(d500[, "price", drop = T]))         # Distribution is highly skew
#  MASS::boxcox(price~., data=ggplot2::diamonds)  # Suggests log transformation

## ----H7g-----------------------------------------------------------------------------------------
#  diamonds <- ggplot2::diamonds; Y <- diamonds[,"price", drop=T]
#  library(rpart)
#  d7.rpart <- rpart(log(Y) ~ ., data=diamonds[,-7], cp=5e-7) # Complex tree
#  d.rpart <- prune(d7.rpart, cp=0.0025)
#  printcp(d.rpart)   # Relative to `d7.rpart`, simpler and less accurate
#  nmin <- which.min(d7.rpart$cptable[,'xerror'])
#  dOpt.rpart <- prune(d7.rpart, cp=d7.rpart$cptable[nmin,'CP'])
#  print(dOpt.rpart$cptable[nmin])
#  (xerror12 <- dOpt.rpart$cptable[c(nrow(d.rpart$cptable),nmin), "xerror"])
#   ## Subtract from 1.0 to obtain R-squared statistics

## ----H7h-----------------------------------------------------------------------------------------
#  rbind("d.rpart"=d.rpart[['variable.importance']],
#        "dOpt.rpart"=dOpt.rpart[['variable.importance']]) |>
#    (\(x)100*apply(x,1,function(x)x/sum(x)))() |> round(1) |> t()

## ----H7i-----------------------------------------------------------------------------------------
#  Y <- ggplot2::diamonds[,"price", drop=T]
#  samp5K <- sample(1:nrow(diamonds), size=5000)
#  (diamond5K.rf <- randomForest(x=diamonds[samp5K,-7], y=log(Y[samp5K]),
#                     xtest=diamonds[-samp5K,-7], ytest=log(Y[-samp5K])))
#  ## Omit arguments `xtest` and `ytest` if calculations take too long

## ----H7j-----------------------------------------------------------------------------------------
#  sort(importance(diamond5K.rf)[,1], decreasing=T) |>
#    (\(x)100*x/sum(x))() |> round(1) |> t()

## ----H7k-----------------------------------------------------------------------------------------
#  (diamond5KU.rf <- randomForest(x=diamonds[samp5K,-7], y=Y[samp5K],
#                     xtest=diamonds[-samp5K,-7], ytest=Y[-samp5K]))

