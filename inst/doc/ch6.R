
## CodeControl
options(rmarkdown.html_vignette.check_title = FALSE)
## xtras=TRUE
xtras <- FALSE
library(knitr)
## opts_chunk[['set']](results="asis")
## opts_chunk[['set']](eval=T)
opts_chunk[['set']](eval=F)

## r0-1
Hmisc::knitrSet(basename="ts", lang='markdown', fig.path="figs/g", w=6, h=6, width=70)
opts_chunk[['set']](out.width="80%", fig.align="center", 
                    width=78, size="small", comment=NA, rmLeadingLF=TRUE,
                    tidy.opts = list(replace.assign=FALSE))

## F1_1a
class("lakeHuron")
## Use `time()` to extract the `time` attribute
range(time(LakeHuron))
## Use `window()` to subset a time series
LHto1925 <- window(LakeHuron, from=1875, to=1925)

## F1_1b
jobs <- DAAG::jobs
names(jobs)
allRegions <- ts(jobs[, -7])   # Create multivariate time series
time(allRegions)               # Times run from 1 to 24
allRegions <- ts(jobs[, -7], start=c(1995,1), frequency=12)
allRegions[,"BC"]              # Extract jobs data for British Columbia
jobsBC <- ts(jobs[, "BC"], start=c(1995,1), frequency=12)
  # Obtain equivalent of `allRegions[,"BC"]` directly from `jobs` dataset

## 6_1
## Plot depth measurements: ts object LakeHuron (datasets)
plot(LakeHuron, ylab="depth (in feet)", xlab = "Time (in years)", fg="gray")

## F1_1c
lag.plot(LakeHuron, lags=3, do.lines=FALSE)

## 6_2A
par(oma=c(0,0,1.5,0))
par(pty="s")
lag.plot(LakeHuron, set.lags=1:4,do.lines=F, oma=c(0,1.5,1.5,1.5),
fg="gray", layout=c(1,4), cex.lab=1.15, asp=1)
mtext(side=3, line=0.5, "A: Lag plots", adj=0, cex=0.85, outer=TRUE)

## 6_2B
library(lattice)
col3 <- c("gray80",rev(ggsci::pal_npg()(2)))
lag.max <- 15
offset <- 0.18
ci95 <- 2/sqrt(length(LakeHuron))
ar2 <- ar(LakeHuron)
gph.key <- list(x=0.975, y=0.965, corner=c(1,1), columns=1, cex=0.85,
                 text=list(c("Lake Huron data","AR1 process","AR2 process")),
                 lines=list(lwd=c(3,1.5,1.5), col=col3,lend=2),
                 padding.text=1)
parsetBC <- list(fontsize=list(text=8, points=5), 
                 superpose.line=list(col=col3, lty=rep(1,3),
                 lwd=c(3,1.5,1.5)))
parsetBC <- modifyList(parsetBC,list(grid.pars = list(lineend = "butt")))
lev3 <- factor(c("acfData","acfAR1","acfAR2"),
               levels=c("acfData","acfAR1","acfAR2"))
acfData <- acf(LakeHuron, main="", plot=FALSE, lag.max=lag.max)$acf
pacfData <- pacf(LakeHuron, main="", plot=FALSE, lag.max=lag.max)$acf
acfAR1 <- ARMAacf(ar=0.8, lag.max=lag.max)
acfAR2 <- ARMAacf(ar=ar2$ar, ma=0, lag.max=lag.max)
pacfAR1 <- ARMAacf(ar=0.8, lag.max=lag.max, pacf=TRUE)
pacfAR2 <- ARMAacf(ar=ar2$ar, ma=0, lag.max=lag.max, pacf=TRUE)
xy <- data.frame(acf=c(acfData,acfAR1,acfAR2),
Lag=c(rep(0:lag.max,3))+rep(c(0,-offset,offset),
rep(lag.max+1,3)),
gp=rep(lev3, rep(lag.max+1,3)))
gphB <- xyplot(acf ~ Lag, data = xy, groups=gp, type=c("h"),
              par.strip.text = list(cex = 0.85), lend=2,origin=0, 
              ylim=c(-0.325, 1.04),key=gph.key, par.settings=parsetBC, 
          panel=function(x,y,...){
            panel.xyplot(x,y,...)
            panel.abline(h=0, lwd=0.8)
            panel.abline(h=ci95, lwd=0.8, lty=2)
            panel.abline(h=-ci95, lwd=0.8, lty=2) } )
xyp <- data.frame(pacf=c(pacfData,pacfAR1,pacfAR2),
                  Lag=c(rep(1:lag.max,3))+c(rep(c(0,-offset,offset),
                  rep(lag.max,3))), gp=rep(lev3, rep(lag.max,3)))
gphC <- xyplot(pacf ~ Lag, data = xyp, groups=gp, type=c("h"),
               par.strip.text = list(cex = 0.85), lend=2,
               ylab = "Partial correlation", origin=0, ylim=c(-0.325, 1.04),
               key=gph.key, par.settings=parsetBC, 
               panel=function(x,y,...){
                 panel.xyplot(x,y,...)
                 panel.abline(h=0, lwd=0.8)
                 panel.abline(h=ci95, lwd=0.8, lty=2)
                 panel.abline(h=-ci95, lwd=0.8, lty=2) } )
print(update(gphB, scales=list(alternating=FALSE, tck=0.5),
             ylab = "Autocorrelation",
             main=list("B: Autocorelation -- Data vs AR processes", 
                       font=1, x=0, y=0.25, just="left", cex=1)), 
                       pos=c(0,0,0.5,0.9))
print(update(gphC, 
        scales=list(x=list(at=c(1,5,10,15)), alternating=FALSE, tck=0.5),
        ylab = "Partial autocorrelation",
        main=list("C: Partial autocorrelation -- Data vs AR processes", 
                  font=1, x=0, y=0.25, just="left", cex=1)),
        pos=c(0.5,0,1,0.9),newpage=FALSE)

## F1_2a
acf(LakeHuron)
## pacf(LakeHuron) gives the plot of partial autocorrelations

## F1_3a
## Yule-Walker autocorrelation estimate
LH.yw <- ar(LakeHuron, order.max = 1, method = "yw")  # autocorrelation estimate
# order.max = 1 for AR(1) model
LH.yw$ar                  # autocorrelation estimate of alpha
## Maximum likelihood estimate
LH.mle <- ar(LakeHuron, order.max = 1, method = "mle")
LH.mle$ar                 # maximum likelihood estimate of alpha
LH.mle$x.mean             # estimated series mean
LH.mle$var.pred           # estimated innovation variance

## F1_3b
ar(LakeHuron, method="mle")

## 6_3
lag.max <- 11
offset <- 0.09
four <- c(ARMAacf(ma=c(0.5),lag.max=lag.max),
ARMAacf(ma=c(0,0,0.5), lag.max=lag.max),
ARMAacf(ma=c(0,0,0.5,0,0.5),lag.max=lag.max),
ARMAacf(ma=rep(0.5,6),lag.max=lag.max))
pfour <- c(ARMAacf(ma=c(0.5),lag.max=lag.max, pacf=T),
ARMAacf(ma=c(0,0,0.5), lag.max=lag.max, pacf=T),
ARMAacf(ma=c(0,0,0.5,0,0.5),lag.max=lag.max, pacf=T),
ARMAacf(ma=rep(0.5,6),lag.max=lag.max, pacf=T))
xy <- data.frame(acf = c(four,pfour), Lag = c(rep(0:lag.max, 4)-offset,
                 rep(1:lag.max,4)+offset),
                 gp=rep(c("acf", "pacf"), c((lag.max+1)*4, lag.max*4)),
                 series = c(rep(c("ma = 0.5", "ma = c(0, 0, 0.5)",
                            "ma = c(0, 0, 0.5, 0, 0.5)",
                            "ma = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5)"),
                            rep(lag.max+1.5,4)),
                            rep(c("ma = 0.5", "ma = c(0, 0, 0.5)",
                            "ma = c(0, 0, 0.5, 0, 0.5)",
                            "ma = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5)"),
                            rep(lag.max,4))))
gph <- xyplot(acf ~ Lag|series, data = xy, layout = c(2,2), groups=gp,
              par.strip.text = list(cex = 1.0), type=c("h"),
              ylab = "Autocorrelation", origin=0, as.table=TRUE, 
              between=list(x=0.5, y=0.5),
              panel=function(x,y,...){
                      panel.xyplot(x,y,...)
                      panel.abline(h=0, lwd=0.8)}
)
parset <- DAAG::DAAGtheme(color=FALSE, 
                          col.line=c('black','gray'), lwd=2.5, lty=1)
update(gph, par.settings=parset,
       scales=list(alternating=FALSE, tck=0.5), 
       auto.key=list(c("Autocorrelation","Partial autocorrelation"), 
                     columns=2, lines=T, points=F))

## F1_5a
library(forecast, quietly=TRUE)
(aaLH <- auto.arima(LakeHuron, approximation=F, stepwise=F))

## F1_5b
## Check that model removes most of the correlation structure
acf(resid(aaLH, type="innovation"))   # `type="innovation"` is the default

## F1_5c
auto.arima(LakeHuron)

## F1_5d
(aaLH0 <- auto.arima(LakeHuron, d=0, approximation=F, stepwise=F))

## 6_4
opar <- par(mar=c(3.1,4.1,2.1,0.6))
fcARMA <- forecast(aaLH0,  h=12, level=80)
fcETS <- forecast(LakeHuron, h=12, level=80)
datall <- cbind(d0=fcARMA[['mean']], ets=fcETS[['mean']],
            "ui0"=fcARMA[['upper']], etsUI=fcETS[['upper']],
            "li0"=fcARMA[['lower']], etsLI=fcETS[['lower']])
ylim <- range(c(range(datall), range(LakeHuron)))+c(-0.1,0)
dat <- datall[,1:2]
datui <- datall[,3:4]
datli <- datall[,5:6]
library(latticeExtra)
txt <- c("ARMA (d=0)","ETS")
xlim <- range(c(time(LakeHuron), time(datall)))
gph <- xyplot.ts(LakeHuron, type='p', xlim=xlim, ylim=ylim, col='gray20')+
  latticeExtra::layer(panel.grid(h=-1,v=-1))
gph.pred <- xyplot.ts(dat, superpose=T, ylim=ylim, lwd=1, xlab="")
gph.ui <- xyplot.ts(datui, superpose=T, lwd=2)
gph.li <- xyplot.ts(datli, superpose=T, lwd=2)
update(gph+as.layer(gph.pred)+as.layer(gph.li)+as.layer(gph.ui), xlab="", 
  scales=list(cex=1.0, rot=c(0,90), y=list(tick.number=7)), 
  par.settings=simpleTheme(lty=2:1, lwd=2), theme=DAAG::DAAGtheme(color=TRUE),
  auto.key=list(columns=2, text=txt, points=F, lines=T, y=1.15),
  main=list("A: ARMA and ETS forecasts with 80% limits", font=1, x=0, y=0.4,
                 just="left", cex=1.25))
plot(forecast(aaLH, h=12), main="", fg="gray", ylim=ylim)
title("B: ARIMA forecast with 80% and 95% limits",
               font.main=1, line=-1.1, outer=T, adj=0.25, cex.main=1.25)
grid()
par(opar)

## F1_5f
plot(forecast(aaLH0,  h=12))  ## `level=c(80,95)` is the default
fcETS <- forecast(LakeHuron, h=12)
plot(fcETS)
plot(forecast(aaLH,  h=12, level=c(80,95)))  # Panel B; ARIMA(2,1,1)

## F1_5g
auto.arima(LakeHuron, d=0, max.Q=0, approximation=F, stepwise=F)

## 6_5
col3 <- c('gray50','black','gray80')
bw9 <- list(fontsize=list(text=9, points=6),
            superpose.line=list(col=rep(col3,c(1,1,1)),
            lty=rep(1,3), lwd=c(2.5,2.5,2.5)), pch=20)
lag.max <- 8
ma3 <- c(.25, .5)
offset <- 0.182
n <- 98
simfun <- function(ma, n, lag.max){
  z1 <- acf(arima.sim(model=list(ma=ma), n=n), lag.max=lag.max, plot=FALSE)$acf
  z4 <- ARMAacf(ma=ma,lag.max=lag.max)
  z6 <- acf(arima.sim(model=list(ma=ma), n=n), lag.max=lag.max, plot=FALSE)$acf
  c(z1,z4,z6)
}
set.seed(17)
five1 <- simfun(ma=c(0,0,ma3[1]), n=n, lag.max=lag.max)
five2 <- simfun(ma=c(0,0,ma3[2]), n=n, lag.max=lag.max)
xy <- data.frame(acf = c(five1,five2),
        Lag=rep(c(0:lag.max, 0:lag.max, 0:lag.max),2),
        ma3 = rep(paste("ma = c(0, 0, ", ma3,")",sep=""), 
                  rep(lag.max*3+3,2)),
        gp=rep(rep(1:3, c(lag.max+1, lag.max+1, lag.max+1)), 2))
xy$Lag <- xy$Lag+(xy$gp-2)*offset
gph <- xyplot(acf~Lag|ma3, groups=gp, data = xy, layout = c(2,1), 
              type=c("h"), par.strip.text = list(cex = 0.85),
              ylab = "Autocorrelation", origin=0, as.table=TRUE,
              between=list(x=0.5, y=0.5),
              key=list(space="top", columns=3, text=list(c("Simulation1",
              "Theoretical","Simulation2")), 
              lines=list(lwd=c(1.75,1.5,1.75), col=col3)),
              panel=function(x,y,...){
                panel.xyplot(x,y,...)
                panel.abline(h=0, lwd=0.75)}
              )
update(gph, scales=list(x=list(at=0:8), alternating=FALSE, tck=0.5),
       par.settings=bw9)

## F1_6c
oldpar <- par(mfrow=c(2,2), mar=c(3.1,4.6,2.6, 1.1))
for(i in 1:2){
  simts <- arima.sim(model=list(order=c(0,0,3), ma=c(0,0,0.25*i)), n=98)
  acf(simts, main="", xlab="")
  mtext(side=3, line=0.5, paste("ma3 =", 0.25*i), adj=0)
}
par(oldpar)

## F1_6d
set.seed(29)         # Ensure that results are reproducible
estMAord <- matrix(0, nrow=4, ncol=20)
for(i in 1:4){
  for(j in 1:20){
    simts <- arima.sim(n=98, model=list(ma=c(0,0,0.125*i)))
    estMAord[i,j] <- auto.arima(simts, start.q=3)$arma[2] }
}
detectedAs <- table(row(estMAord), estMAord)
dimnames(detectedAs) <- list(ma3=paste(0.125*(1:4)),
Order=paste(0:(dim(detectedAs)[2]-1)))

## F1_6e
print(detectedAs)

## 6_6
suppressPackageStartupMessages(library(ggplot2))
mdb12AVt1980on <- window(DAAG::mdbAVtJtoD, c(1980,1))
AVt.ets <- ets(mdb12AVt1980on)
autoplot(AVt.ets, main="", fg="gray") + 
  ggplot2::ggtitle("A: Components of ETS fit") +
    theme(plot.title = element_text(hjust=0, vjust=0.5, size=11))
monthplot(mdb12AVt1980on, col.base=2,  fg="gray")
title("B: Seasonal component, SI ratio", 
      font.main=1, line=1, adj=0, cex=1.25)

## 6_7
bomreg <- DAAG::bomregions2021
## Plot time series mdbRain, SOI, and IOD: ts object bomregions2021 (DAAG)
gph <- xyplot(ts(bomreg[, c("mdbRain", "mdbAVt", "SOI", "IOD")], start=1900), 
              xlab="", type=c('p','smooth'), scales=list(alternating=rep(1,3)))
update(gph, layout=c(4,1), par.settings=DAAG::DAAGtheme(color=F))

## F2b
suppressPackageStartupMessages(library(mgcv))
bomreg <- within(DAAG::bomregions2021, mdbrtRain <- mdbRain^0.5)
## Check first for a sequential correlation structure, after
## fitting smooth terms s(CO2), s(SOI), and s(IOD)
library(mgcv)
mdbrtRain.gam <- gam(mdbrtRain~s(CO2) + s(SOI) + s(IOD), data=bomreg)
auto.arima(resid(mdbrtRain.gam))

## 6_8
plot(mdbrtRain.gam, residuals=T, cex=2, fg="gray")
## Do also `gam.check(mdbrtRain.gam)` (Output looks fine)

## F2c
anova(mdbrtRain.gam)

## F2d
Box.test(resid(mdbrtRain.gam), lag=10, type="Ljung")

## F2e
## Examine normality of estimates of "residuals" 
qqnorm(resid(mdbrtRain.gam))

## F2f
mdbAVt.gam <- gam(mdbAVt ~ s(CO2)+s(SOI)+s(IOD), data=bomreg)
auto.arima(resid(mdbAVt.gam))
anova(mdbAVt.gam)

## F2g
mdbAVt1.gam <- gam(mdbAVt ~ s(CO2)+s(SOI), data=bomreg)

## F2h
plot(mdbAVt1.gam, residuals=TRUE)

## 6_9
plot(mdbAVt1.gam, residuals=T, cex=2, fg="gray")

## 6_10
faclevs <- c("A: Rainfall", expression("B: Average Temp ("^o*"C)"))
fitrain <- fitted(mdbrtRain.gam) 
fitAVt <- c(rep(NA,10), fitted(mdbAVt1.gam))
gph <- xyplot(mdbrtRain+mdbAVt~Year,data=bomreg, outer=T, xlab="", ylab="",
  scales=list(y=list(relation='free', 
              at=list(sqrt((3:8)*100),(33:39)/2), 
              labels=list((3:8)*100,(33:39)/2)), x=list(alternating=rep(1,2))),
  strip=strip.custom(factor.levels=faclevs))
gph + latticeExtra::as.layer(xyplot(fitrain+fitAVt~Year, outer=T,
                                    scales=list(y=list(relation='free')), 
                                    data=bomreg, pch=3, col=2))

## F2i
## Use `auto.arima()` to choose the ARIMA order:
aaFitCO2 <- with(bomreg[-(1:10),], auto.arima(mdbAVt, xreg=cbind(CO2,SOI)))
## Try including a degree 2 polynomial term
aaFitpol2CO2 <- with(bomreg[-(1:10),], 
                     auto.arima(mdbAVt, xreg=cbind(poly(CO2,2),SOI)))
cbind(AIC(aaFitCO2, aaFitpol2CO2), BIC=BIC(aaFitCO2, aaFitpol2CO2))

## F3a
SOI.gam <- gam(SOI~s(Year), data=bomreg)
auto.arima(resid(SOI.gam))             # sigma^2 = 43.4
## The following breaks the model into two parts -- gam and lme
SOI.gamm <- gamm(SOI~s(Year), data=bomreg)       
res <- resid(SOI.gamm$lme, type="normalized")
auto.arima(res)                        # sigma^2 = 0.945
## Extract scale estimate for `gam` component of SOI.gamm
summary(SOI.gamm$gam)[['scale']]       # 45.98
  # Note that 45.98 x .945 ~= 43.4

## F3b
SOIma2.gamm <- gamm(SOI~s(Year), data=bomreg, correlation=corARMA(q=2))
coef(SOIma2.gamm$lme$modelStruct$corStruct, unconstrained = FALSE)  # MA2 ests
SOIar2.gamm <- gamm(SOI~s(Year), data=bomreg, correlation=corARMA(p=2))
coef(SOIar2.gamm$lme$modelStruct$corStruct, unconstrained = FALSE)  # AR2 ests
cbind(AIC(SOI.gam, SOIma2.gamm$lme, SOIar2.gamm$lme), 
      BIC=BIC(SOI.gam, SOIma2.gamm$lme, SOIar2.gamm$lme)[,2])

## F3c
## Add time in days from May 1 to data. 
airq <- cbind(airquality[, 1:4], day=1:nrow(airquality))
  # Column 5 ('day' starting May 1) replaces columns 'Month' & 'Day')
## Check numbers of missing values   # Solar.R:7; Ozone:37
mice::md.pattern(airq, plot=FALSE)   # Final row has totals missing.

## 6_11
smoothPars <- list(col.smooth='red', lty.smooth=2, spread=0)
car::spm(airq, cex.labels=1.2, regLine=FALSE, oma=c(1.95,3,4,3), gap=.15,
         col=adjustcolor('blue', alpha.f=0.3), smooth=smoothPars, fg="gray")

## F3d
car::powerTransform(gam(Ozone ~ s(Solar.R)+s(Wind)+s(Temp)+s(day), data=airq))
airq$rt4Ozone <- airq$Ozone^0.25

## F3e
Ozone.gam <- gam(rt4Ozone ~ s(Solar.R)+s(Wind)+s(Temp)+s(day), data=airq)
auto.arima(resid(Ozone.gam))  # Independent errors model appears OK
## Check model terms
anova(Ozone.gam)   # For GAM models, this leaves out terms one at a time
## The term in `day` has no explanatory, and will be removed
Ozone1.gam <- update(Ozone.gam, formula=rt4Ozone ~ s(Solar.R)+s(Wind)+s(Temp))

## F4a
flakes <- DAAG::frostedflakes
calib.arima <- with(flakes, auto.arima(IA400, xreg=Lab))
calib.arima

## F4b
with(flakes, coef(auto.arima(IA400/Lab, approximation=F, stepwise=F)))
with(flakes, coef(auto.arima(IA400-Lab, approximation=F, stepwise=F)))

## 6_12
calib.arima <- with(flakes, auto.arima(IA400/Lab))
fcast1 <- forecast(calib.arima, h=100)
plot(fcast1, fg='gray', main="A: Forecast from ARIMA(0,0,1)", adj=0, font.main=1)
## Alternative, ETS forecast
fcast2 <- with(flakes, forecast(IA400/Lab, h=100))
plot(fcast2, fg='gray', main="B: Forecast from ETS(M,N,N)", adj=0, font.main=1)

## F5a
x <- numeric(999)  # x will contain the ARCH(1) errors
x0 <- rnorm(1)
for (i in 1:999){
x0 <- rnorm(1, sd=sqrt(.25 + .95*x0^2))
x[i] <- x0
}

## F5b
suppressPackageStartupMessages(library(tseries))
garch(x, order = c(0, 1), trace=FALSE)

## F7b
xx <- matrix(x, ncol=1000)

## F7c
library(tseries)
data(ice.river)
river1 <- diff(log(ice.river[, 1]))

## F7d
library(forecast)
Eu1 <- window(EuStockMarkets[,1], end = c(1996, 260))
Eu1nn <- nnetar(Eu1)
Eu1f <- forecast(Eu1nn, end=end(EuStockMarkets[,1]))
plot(Eu1f, ylim=c(1400, 7000))
lines(EuStockMarkets[,1])

## F7e
airq <- cbind(airquality[, 1:4], day=1:nrow(airquality))
  # Column 5 ('day' starting May 1) replaces columns 'Month' & 'Day')
library(mgcv)
temp.gam <- gam(Temp~s(day), data=airq)
tempAR1.gamm <- gamm(Temp~s(day), data=airq, correlation=corAR1())
plot(temp.gam, res=T, cex=2)
plot(tempAR1.gamm$gam, res=T, cex=2)

## F7f
(Phi <- coef(tempAR1.gamm$lme$modelStruct$corStruct, unconstrained = FALSE) )
Sigma <- sqrt(tempAR1.gamm$gam$sig2)
## Simulate an AR1 process with this parameter
AR1.sim <- arima.sim(model=list(ar=Phi), n=nrow(airq), sd=Sigma)
simSeries <- AR1.sim+fitted(tempAR1.gamm$gam)
plot(I(1:nrow(airq)), simSeries)
## Compare with initial series
plot(I(1:nrow(airq)), airq$Temp)

## unnamed-chunk-1
if(file.exists("/Users/johnm1/pkgs/PGRcode/inst/doc/")){
code <- knitr::knit_code$get()
txt <- paste0("\n## ", names(code),"\n", sapply(code, paste, collapse='\n'))
writeLines(txt, con="/Users/johnm1/pkgs/PGRcode/inst/doc/ch6.R")
}
