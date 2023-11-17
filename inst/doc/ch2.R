
## unnamed-chunk-1
options(rmarkdown.html_vignette.check_title = FALSE)

## CodeControl
options(rmarkdown.html_vignette.check_title = FALSE)
xtras <- F
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)

## setup
Hmisc::knitrSet(basename="models", lang='markdown', fig.path="figs/g", w=7, h=7)
oldopt <- options(digits=4, formatR.arrow=FALSE, width=70, scipen=999)
library(knitr)
## knitr::render_listings()
opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.align="center", 
                    fig.show='hold', size="small", ps=10, strip.white = TRUE,
                    comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## B1_2a
## Tabulate by Admit and Gender
byGender <- 100*prop.table(margin.table(UCBAdmissions, margin=1:2), margin=2)
round(byGender,1)

## B1_2b
## Admission rates, by department
pcAdmit <- 100*prop.table(UCBAdmissions, margin=2:3)["Admitted", , ]
round(pcAdmit,1)

## 2_1
applied <- margin.table(UCBAdmissions, margin=2:3)
pcAdmit <- 100*prop.table(UCBAdmissions, margin=2:3)["Admitted", , ]
      byGender <- 100*prop.table(margin.table(UCBAdmissions,
      margin=1:2), margin=2)
dimnam <- dimnames(UCBAdmissions)
mfStats <- data.frame(Admit=c(pcAdmit[1,],pcAdmit[2,]),
  Applicants=c(applied[1,], applied[2,]),
  mf=factor(rep(dimnam[['Gender']],c(6,6)),
  levels=dimnam[['Gender']]), Department=rep(dimnam[["Dept"]],2))
xlim <- c(0, max(mfStats$Admit)*1.025)
ylim <- c(0, max(mfStats$Applicants)*1.075)
plot(Applicants~Admit, data=mfStats, type="h",lwd=2, xlim=xlim, ylim=ylim,
     fg="gray", cex.lab=1.2, col=rep(c("blue","red"),rep(6,2)),
     xlab="UCB Admission rates (%), 1973", ylab="Number of applicants")
pcA <- rbind(pcAdmit[1,], apply(pcAdmit,2, mean)+2, pcAdmit[2,], rep(NA,6))
pcA[2,3] <- pcA[2,3]+1
appA <- rbind(applied[1,], apply(applied,2, mean)+80,
              applied[2,], rep(NA,6))
deptNam <- dimnam[[3]]
for(j in 1: ncol(appA)) lines(pcA[,j], appA[,j], col="gray", lwd=0.8)
points(pcA[2,],appA[2,], pch=16, cex=1.1, col="white")
text(pcA[2,],appA[2,],deptNam, cex=0.85)
##
par(xpd=TRUE)
text(byGender[1,1:2], rep(par()$usr[4],2)+0.5*strheight("^"),
     labels=c("^","^"), col=c("blue","red"),cex=1.2,srt=180)
text(byGender[1,], par()$usr[4]+1.4*strheight("A"),
     labels=paste(round(byGender[1,],1)),cex=0.85)
text(byGender[1,1:2]+c(-3.5,3.5), rep(par()$usr[4],2)+2.65*strheight("A"),
     labels=c("All males","All females"), pos=c(4,2), cex=1.2)
par(xpd=FALSE)
abline(h=200*(0:4),col="lightgray",lty="dotted")
abline(v=20*(0:4),col="lightgray",lty="dotted")
legend("topleft", col=c('blue','red'),lty=c(1,1), lwd=0.75, cex=0.9,
       y.intersp=0.65, legend=c("Males","Females"),bty="n")

## B1_2d
## Calculate totals, by department, of males & females applying
margin.table(UCBAdmissions, margin=2:3)

## B2_2a
stats2 <- sapply(DAAG::two65,
                 function(x) c(av=mean(x), sd=sd(x), n=length(x)))
pooledsd <- sqrt( sum(stats2['n',]*stats2['sd',]^2)/sum(stats2['n',]-1) )
stats2 <- setNames(c(as.vector(stats2), pooledsd),
                   c('av1','sd1','n1','av2','sd2','n2','pooledsd'))
print(stats2, digits=4)

## B2_2b
with(DAAG::two65, t.test(heated, ambient, var.equal=TRUE))

## 2_2
titl <- paste("Second versus first member, for each pair.  The first",
"\npanel is for the elastic band data. The second (from",
"\nDarwin) is for plants of the species Reseda lutea")
oldpar <- par(pty="s")
on.exit(par(oldpar))
DAAG::onesamp(dset = DAAG::pair65, x = "ambient", y = "heated",
  xlab = "Amount of stretch (ambient)",
  ylab = "Amount of stretch (heated)", fg='gray')
## Data set mignonette holds the Darwin (1877) data on Reseda lutea.
## Data were in 5 pots, holding 5,5,5,5,4 pairs of plants respectively.
DAAG::onesamp(dset = DAAG::mignonette, x = "self", y = "cross",
  xlab = "Height of self-fertilised plant", ylab =
  "Height of cross-fertilised plant", dubious = 0, cex=0.7, fg='gray')

## B2_4a
## Pearson correlation between `body` and `brain`: Animals
Animals <- MASS::Animals
rho <- with(Animals, cor(body, brain))
## Pearson correlation, after log transformation
rhoLogged <- with(log(Animals), cor(body, brain))
## Spearman rank correlation
rhoSpearman <- with(Animals, cor(body, brain, method="spearman"))
c(Pearson=round(rho,2), " Pearson:log values"=round(rhoLogged,2),
  Spearman=round(rhoSpearman,2))

## B3_1a
maleDF <- data.frame(number=0:12, freq=unname(qra::malesINfirst12[["freq"]]))
N <- sum(maleDF$freq)
pihat <- with(maleDF, weighted.mean(number, freq))/12
probBin <- dbinom(0:12, size=12, prob=pihat)
rbind(Frequency=setNames(maleDF$freq, nm=0:12),
      binomialFit=setNames(probBin*N, nm=0:12),
      rawResiduals = maleDF$freq-probBin*N,
      SDbinomial=sqrt(probBin*(1-probBin)*N)) |>
  formatC(digits=2, format="fg") |> print(digits=2, quote=F, right=T)

## B3_1b
## Fit binomial and betabinomial distributions.
suppressPackageStartupMessages(library(gamlss))
doBI <- gamlss(cbind(number, 12-number)~1, weights=freq,
               family=BI, data=maleDF, trace=FALSE)
doBB <- gamlss(cbind(number, 12-number)~1, weights=freq,
                     family=BB, data=maleDF, trace=FALSE)

## 2_3
set.seed(29)
rqres.plot(doBI, plot.type='all', type="QQ", main=""); box(col='white')
mtext(side=3, line=0.5, "A: Binomial model, Q-Q", adj=0, cex=1.25)
rqres.plot(doBI, plot.type='all', type="wp", main=""); box(col='white')
## Plots C, D, E, F: Set object name; set`type="wp" (C, E, F), or`"QQ"` (D)
mtext(side=3, line=0.5, "B: Binomial, worm plot 1", adj=-0.05, cex=1.25)
rqres.plot(doBI, plot.type='all', type="wp", main=""); box(col='white')
mtext(side=3, line=0.5, "C: Binomial, worm plot 2", adj=-0.05, cex=1.25)
rqres.plot(doBB, plot.type='all', type="QQ", main="", ylab=''); box(col='white')
mtext(side=3, line=0.5, "D: BB model, Q-Q", adj=0, cex=1.25)
rqres.plot(doBB, plot.type='all', type="wp", main="", ylab=''); box(col='white')
mtext(side=3, line=0.5, "E: BB, worm plot 1", adj=0, cex=1.25)
rqres.plot(doBB, plot.type='all', type="wp", main="", ylab=''); box(col='white')
mtext(side=3, line=0.5, "F: BB, worm plot 2", adj=0, cex=1.25)

## B3_1d
aicStat <- AIC(doBI, doBB)
rownames(aicStat) <-
  c(doBI="Binomial", doBB="Betabinomial")[rownames(aicStat)]
aicStat$dAIC <- with(aicStat, round(AIC-AIC[1],1))
aicStat

## B3_1e
## Numbers of accidents in three months, with Poisson fit
machinists <- data.frame(number=0:8, freq=c(296, 74, 26, 8, 4, 4, 1, 0, 1))
N <- sum(machinists[['freq']])
lambda <- with(machinists, weighted.mean(number, freq))
fitPoisson <- dpois(0:8, lambda)*sum(machinists[['freq']])
rbind(Frequency=with(machinists, setNames(freq, number)),
      poissonFit=fitPoisson) |>
  formatC(digits=2, format="fg") |> print(quote=F, digits=2, right=T)

## B3_1f
doPO <- gamlss(number~1, weights=freq,
                family=PO, data=machinists, trace=FALSE)
doNBI <- gamlss(number~1, weights=freq,
                  family=NBI, data=machinists, trace=FALSE)

## 2_4
set.seed(23)
rqres.plot(doPO, plot.type='all', type="QQ", main=""); box(col='white')
## Repeat, changing the argument, for remaining plots
mtext(side=3, line=0.5, "A: Poisson, Q-Q plot", adj=0, cex=1.25)
rqres.plot(doPO, plot.type='all', type="wp", main="", ylab=''); box(col='white')
mtext(side=3, line=0.5, "B: Poisson, worm plot", adj=0, cex=1.25)
rqres.plot(doNBI, plot.type='all', type="wp", main="", ylab='')
mtext(side=3, line=0.5, "C: NBI, worm plot", adj=0, cex=1.25); box(col='white')

## B3_1i
sigma <- exp(coef(doBB, "sigma"))
cat("Phi =", (1+12*sigma)/(1+sigma))

## B3_1j
mu <- exp(coef(doNBI, "mu"))
sigma <- exp(coef(doNBI, "sigma"))
cat("Phi =", (1+sigma*mu))

## B4a
## 'Untreated' rows (no training) from psid3, 'treated' rows from nswdemo
nswpsid3 <- rbind(DAAG::psid3, subset(DAAG::nswdemo, trt==1))
degTAB <- with(nswpsid3, table(trt,nodeg))
# Code 'Yes' if completed high school; 'No' if dropout
dimnames(degTAB) <- list(trt=c("PSID3_males","NSW_male_trainees"),
                         deg =c("Yes","No"))
degTAB

## B4b
# To agree with hand calculation below, specify correct=FALSE
chisq.test(degTAB, correct=FALSE)

## B4c
## Engine man data
engineman <- matrix(c(5,3,17,85), 2,2)
chisq.test(engineman)

## B4d
fisher.test(engineman)

## B4e
## Enter the data thus:
rareplants <- matrix(c(37,190,94,23, 59,23,10,141, 28,15,58,16), ncol=3,
  byrow=TRUE, dimnames=list(c("CC","CR","RC","RR"), c("D","W","WD")))

## B4f
(x2 <- chisq.test(rareplants))

## B4h
options(digits=3)
## Expected values
x2$expected

## B4i
options(digits=2)
## Standardized residuals
residuals(x2)

## 2_5
leg <- c("A: Fitted line", "B: Residuals from line", "C: Variance check")
ord <- order(DAAG::ironslag[["magnetic"]])
ironslag <- DAAG::ironslag[ord,]
slagAlpha.lm <- lm(chemical~magnetic, data=ironslag)
resval <- residuals(slagAlpha.lm)
fitchem <- fitted(slagAlpha.lm)
sqrtabs2 <- sqrt(abs(resval))
plot(chemical~magnetic, xlab = "Magnetic", ylab = "Chemical",
     pch = 1, data=ironslag, fg="gray")
lines(fitchem~ironslag[["magnetic"]])
mtext(side = 3, line = 0.25, leg[1], adj=-0.1, cex=0.925)
scatter.smooth(resval~ironslag[["magnetic"]], lpars=list(col="red"), span=0.8,
               xlab = "Magnetic", ylab = "Residual", fg="gray")
mtext(side = 3, line = 0.25, leg[2], adj = -0.1, cex=0.925)
scatter.smooth(sqrtabs2 ~ fitchem, lpars=list(col="red"), span=0.8,
xlab = "Predicted chemical", fg="gray",
ylab = expression(sqrt(abs(residual))))
mtext(side = 3, line = 0.25, leg[3], adj = -0.1, cex=0.8)
## Diagnostics from fit using loess()
leg2 <- c("D: Smooth, using loess()",
          "E: Residuals from smooth",
          "F: Variance check")
slag.loess <- loess(chemical~magnetic, data=ironslag, span=0.8)
resval2 <- slag.loess[["residuals"]]
fitchem2 <- slag.loess[["fitted"]]
sqrtabs2 <- sqrt(abs(resval2))
plot(chemical~magnetic, xlab = "Magnetic", ylab = "Chemical",
pch = 1, data=ironslag, fg="gray")
lines(fitchem2 ~ ironslag[["magnetic"]], col="red")
mtext(side = 3, line = 0.25, leg2[1], adj=-0.1, cex=0.925)
scatter.smooth(resval2~ironslag[["magnetic"]], span=0.8,
lpars=list(col="red"),
xlab = "Magnetic", ylab = "Residual", fg="gray")
mtext(side = 3, line = 0.25, leg2[2], adj = -0.1, cex=0.925)
scatter.smooth(sqrtabs2 ~ fitchem2, lpars=list(col="red"),
span=0.8, xlab = "Predicted chemical", fg="gray",
ylab = expression(sqrt(abs(residual))))
mtext(side = 3, line = 0.25, leg2[3], adj = -0.1, cex=0.925)

## B5_2a
roller.lm <- lm(depression ~ weight, data=DAAG::roller)
anova(roller.lm)

## 2_6
softbacks <- DAAG::softbacks
x <- softbacks[,"volume"]
y <- softbacks[,"weight"]
u <- lm(y ~ x)
yhat <- predict(u)
res <- resid(u)
r <- with(softbacks, cor(x, y))
xlim <- with(softbacks, range(volume))
xlim[2] <- xlim[2]+diff(xlim)*0.08
plot(y ~ x, xlab = "Volume (cc)", xlim=xlim,
data=softbacks, ylab = "Weight (g)", pch = 4,
ylim = range(c(y, yhat)), cex.lab=0.9, fg="gray")
abline(u$coef[1], u$coef[2], lty = 1)
bottomright <- par()$usr[c(2, 3)]
chw <- par()$cxy[1]
chh <- par()$cxy[2]
z <- summary(u)$coef
btxt <- c(paste("a =", format(round(z[1, 1], 1)),
"  SE =", format(round(z[1, 2], 1))),
paste("b =", format(round(z[2, 1], 2)),
"  SE =", format(round(z[2, 2], 2))))
legend(bottomright[1],  bottomright[2],
legend=btxt, xjust=1, yjust=0, cex=0.8, bty="n")

## B5_3a
softbacks.lm <- lm(weight ~ volume, data=DAAG::softbacks)
print(coef(summary(softbacks.lm)), digits=3)

## 2_7
plot(softbacks.lm, fg="gray",
caption = c("A: Residuals vs Fitted", "B: Normal Q-Q",
"C: Scale-Location", "", "D: Resids vs Leverage"))

## B5_4a
SEb <- coef(summary(roller.lm))[2, 2]
coef(roller.lm)[2] + qt(c(0.025,.975), 8)*SEb

## B5_4b
## Code to obtain fitted values and standard errors (SE, then SE.OBS)
fit.with.se <- predict(roller.lm, se.fit=TRUE)
fit.with.se$se.fit                                            # SE
sqrt(fit.with.se[["se.fit"]]^2+fit.with.se$residual.scale^2)  # SE.OBS

## B5_4c
predict(roller.lm, interval="confidence", level=0.95)
predict(roller.lm, interval="prediction", level=0.95)  # CI for a new observation

## 2_8
## Depression vs weight, with 95\% pointwise bounds for both
## the fitted line and predicted values
investr::plotFit(roller.lm, interval="both", col.conf="red", fg="gray")
mtext(side=3,line=0.75, "A: Lawn roller data", cex=1.2, adj=-0.25)
## Male child vs father height, Galton's data
galtonMales <- subset(HistData::GaltonFamilies, gender=="male")
galton.lm <- lm(childHeight~father, data=galtonMales)
investr::plotFit(galton.lm, interval="both", col.conf="red", hide=FALSE,
                 col=adjustcolor('black',alpha=0.5), fg="gray")
mtext(side=3,line=0.75, "B: Son vs father heights", cex=1.2, adj=-0.25)

## B5_4e
round(coef(summary(galton.lm))[,-4],2)

## 2_9
panelci<-function(data,...)
{
nrows<-list(...)$nrows
ncols<-list(...)$ncols
if(ncols==1)axis(2, lwd=0, lwd.ticks=1)
if(ncols==1)axis(1, lwd=0, lwd.ticks=1) else
axis(3, lwd=0, lwd.ticks=1)
x<-data$stretch; y<-data$distance
u <- lm(y ~ x)
upred <- predict(u, interval="confidence")
ci <- data.frame(fit=upred[,"fit"],lower=upred[,"lwr"], upper=upred[,"upr"])
ord<-order(x)
lines(x[ord], ci[["fit"]][ord], lty=1, lwd=2)
lines(lowess(x[ord], ci[["upper"]][ord]), lty=2, lwd=2, col="grey")
lines(lowess(x[ord], ci[["lower"]][ord]), lty=2, lwd=2, col="grey")
}
elastic1 <- DAAG::elastic1
elastic2 <- DAAG::elastic2
xy<-rbind(elastic2,elastic1)
nam <- c("Range of stretch 30-65 mm","Range of stretch 42-54 mm")
trial<-rep(nam, c(dim(elastic2)[1],dim(elastic1)[1]))
xlim<-range(elastic2$stretch)
ylim<-range(elastic2$distance)
xy<-split(xy,trial)
xy<-lapply(1:length(xy),function(i){c(as.list(xy[[i]]), list(xlim=xlim,
ylim=ylim))})
names(xy) <- nam
DAAG::panelplot(xy,panel=panelci,totrows=1,totcols=2,
                par.strip.text=list(cex=.9), oma=c(4,4,2.5,2), fg='gray')
mtext(side = 2, line = 3.35, "Distance moved (cm)", cex=1.1, las=0)
mtext(side=1,line=3,"Amount of stretch (mm)", cex=1.1)

## 2_10
## There are two regression lines!
pair65 <- DAAG::pair65
bothregs <- function(x=pair65[, "ambient"], y=pair65[, "heated"],
  xlab="Stretch (band at ambient)", ylab = "Stretch (heated band)", pch=16){
    plot(y ~ x, xlab = xlab, ylab = ylab, pch = pch, fg="gray")
    topleft <- par()$usr[c(1, 4)] + c(0.5, -0.5) * par()$cxy
    text(topleft[1], topleft[2], paste("r =", round(cor(x, y), 2)), adj = 0)
    u1 <- lm(y ~ x)
    abline(u1$coef[1], u1$coef[2])
    u2 <- lm(x ~ y)
    abline( - coef(u2)[1]/coef(u2)[2], 1/coef(u2)[2], lty = 2)
}
bothregs()
mtext(side = 3, line = 0.5, "A", adj = 0)
bothregs(x=trees[, "Girth"], y=trees[, "Height"],
         xlab="Girth (in)", ylab <- "Height (ft)", pch=16)
mtext(side = 3, line = 0.5, "B", adj = 0)

## 2_11
## Logarithmic and Power Transformations
DAAG::powerplot(expr="sqrt(x)", xlab="")
DAAG::powerplot(expr="x^0.25", xlab="", ylab="")
DAAG::powerplot(expr="log(x)", xlab="", ylab="")
DAAG::powerplot(expr="x^2")
DAAG::powerplot(expr="x^4", ylab="")
DAAG::powerplot(expr="exp(x)", ylab="")

## 2_12
## Heart weight versus body weight, for 30 Cape fur seals.
g2.12 <- function()
{
cfseal <- DAAG::cfseal
x <- log(cfseal[,"weight"])
y <- log(cfseal[, "heart"])
ylim <- log(c(82.5,1100))
xlim <- log(c(17,180))
ylab <- "Heart weight (g, log scale)"
xlab <- "Body weight (kg, log scale)"
xtik <- c(20,40,80,160)
ytik <- c(100,200,400,800)
plot(x, y, xlab = xlab, ylab = ylab, axes = F, xlim =
xlim, ylim = ylim, pch = 16, cex=0.85, fg="gray", cex.lab=1.1)
axis(1, at = log(xtik), labels = paste(xtik), lwd=0, lwd.ticks=1)
axis(2, at = log(ytik), labels = paste(ytik), lwd=0, lwd.ticks=1)
box(col="gray")
form1 <- formula(y ~ x)
u <- lm(form1, data = cfseal)
abline(u$coef[1], u$coef[2])
usum <- summary(u)$coef
options(digits=3)
print(usum)
cwh <- par()$cxy
eqn <- paste("log y =", round(usum[1, 1], 2), " [",
round(usum[1, 2], 2), "] +", round(usum[2, 1], 3),
" [", round(usum[2, 2], 3), "] log x")
mtext(side=3, line=1.15, eqn, adj = 0.4, cex = 0.8)
mtext(side=3, line=0.25, "(Values in square brackets are SEs)", adj = 0.4, cex = 0.8)
}
g2.12()

## B5_4f
options(scipen=4)
cfseal.lm <- lm(log(heart) ~ log(weight), data=DAAG::cfseal)
print(coef(summary(cfseal.lm)), digits=4)

## 2_13
houseprices <- DAAG::houseprices
df <- DAAG::CVlm(houseprices, form.lm = formula(sale.price ~ area),m=3,printit=F,plotit=FALSE)
panelfun <- function(x,y,subscripts,groups, ...){
  lattice::panel.superpose(x,y,subscripts,groups, ...)
  lattice::panel.superpose(x,df[["cvpred"]],subscripts,groups,type="b", cex=0.5, ...)
}
gph <- lattice::xyplot(sale.price ~ area, groups=fold, data=df, pch=1:3, panel=panelfun)
parset <- DAAG::DAAGtheme(color=T, lty=1:3, pch=1:3, lwd=2)
keylist <- list(lines=TRUE, columns=3, between.columns=1.5, between=1, cex=0.85)
update(gph, par.settings=parset, auto.key=keylist)

## B6_1b
set.seed(29)        # Generate results shown
rand <- sample(rep(1:3, length=15))
## sample() randomly permutes the vector of values 1:3
for(i in 1:3) cat(paste0(i,":"), (1:15)[rand == i],"\n")

## B6_1c
houseprices <- DAAG::houseprices
row.names(houseprices) <- (1:nrow(houseprices))
DAAG::CVlm(houseprices, form.lm = formula(sale.price ~ area), plotit=FALSE)

## B6_1d
## Estimate of sigma^2 from regression output
houseprices <- DAAG::houseprices
houseprices.lm <- lm(sale.price ~ area, houseprices)
summary(houseprices.lm)[["sigma"]]^2

## B6_2a
houseprices <- DAAG::houseprices
houseprices.lm <- lm(sale.price ~ area, houseprices)
print(coef(summary(houseprices.lm)),digits=2)

## B6_2b
houseprices.fn <-
  function (houseprices, index,
            statfun=function(obj)coef(obj)[2]){
            house.resample <- houseprices[index, ]
            house.lm <- lm(sale.price ~ area, data=house.resample)
            statfun(house.lm)    # slope estimate for resampled data
            }

## B6_2c
set.seed(1028)     # use to replicate the exact results below
library(boot)      # ensure that the boot package is loaded
## requires the data frame houseprices (DAAG)
(houseprices.boot <- boot(houseprices, R=999, statistic=houseprices.fn))

## B6_2d
statfun1200 <- function(obj)predict(obj, newdata=data.frame(area=1200))
price1200.boot <- boot(houseprices, R=999, statistic=houseprices.fn,
statfun=statfun1200)
boot.ci(price1200.boot, type="perc") # "basic" is an alternative to "perc"

## 2_14
set.seed(1111)
library(boot)
par(las=0)
houseprices2.fn<-function (houseprices,index){
house.resample<-houseprices[index,]
house.lm<-lm(sale.price~area,data=house.resample)
houseprices$sale.price-predict(house.lm,houseprices)
# resampled prediction errors
}
houseprices <- DAAG::houseprices
n<-nrow(houseprices)
R <- 199    ## Will obtain 199 estimates of prediction error
houseprices.lm<-lm(sale.price~area,data=houseprices)
houseprices2.boot<-boot(houseprices, R=R, statistic=houseprices2.fn)
house.fac<-factor(rep(1:n,rep(R,n)))
plot(house.fac,as.vector(houseprices2.boot$t),
     ylab="", xlab="House", fg="gray")
mtext(side=2, line=2, "Prediction Errors")
mtext(side = 3, line = 0.5, "A", adj = 0)
boot.se <- apply(houseprices2.boot$t,2,sd)
model.se <- predict.lm(houseprices.lm,se.fit=T)$se.fit
plot(boot.se/model.se, ylab="", xlab="House",pch=16, fg="gray")
mtext(side=2, line=2.0, "Ratio of SEs\nBootstrap to Model-Based", cex=0.9)
mtext(side = 3, line = 0.5, "B", adj = 0)
abline(1,0)

## B7_1a
tomato <- data.frame(Weight = c(1.5, 1.9, 1.3, 1.5, 2.4, 1.5,   # Water
                                1.5, 1.2, 1.2, 2.1, 2.9, 1.6,   # Nutrient
                                1.9, 1.6, 0.8, 1.15, 0.9, 1.6), # Nutrient+24D
  trt = factor(rep(c("Water", "Nutrient", "Nutrient+24D"), c(6, 6, 6))))
## Make `Water` the first level of trt.  In aov or lm calculations, it is
## then taken as the baseline or reference level.
tomato$trt <- relevel(tomato$trt, ref="Water")

## 2_15a
## A: Weights of tomato plants (g)
library(lattice, quietly=TRUE)
gph <- stripplot(trt~Weight, aspect=0.35, scale=list(tck=0.6), data=tomato)
update(gph, scales=list(tck=0.4), cex=0.9, col="black", xlab="",
       main=list('A: Weights of tomato plants (g)', y=0, cex=1.1))

## 2_15b
## B: Summarize comparison between LSD and Tukey's HSD graphically
tomato.aov <- aov(Weight ~ trt, data=tomato)
DAAG::onewayPlot(obj=tomato.aov)
title(main="B: LSD, compared with Tukey HSD", adj=0.1, outer=T,
      line=-1.0, font.main=1, cex.main=1.25)

## B7_1d
BHH2::anovaPlot(tomato.aov)

## B7_1e
## Do analysis of variance calculations
anova(tomato.aov)

## 2_16
gph <- DAAG::simulateLinear(alpha=0.6, seed=17, aspect='iso')
update(gph, par.settings=DAAG::DAAGtheme(color=FALSE, alpha=0.4))

## B7_3a
coralPval <- DAAG::coralPval
pcrit <- c(0.05, 0.02, 0.01, 0.001)
under <- sapply(pcrit, function(x)sum(coralPval<=x))

## B7_3b
expected <- pcrit*length(coralPval)

## B7_3c
fdrtab <- data.frame(Threshold=pcrit, Expected=expected,
Discoveries=under, FDR=round(expected/under, 4))
print(xtable::xtable(fdrtab), include.rownames=FALSE, hline.after=FALSE)

## B7_3d
fdr <- p.adjust(coralPval, method="BH")

## B7_3e
fdrcrit <- c(0.05, 0.04, 0.02, 0.01)
under <- sapply(fdrcrit, function(x)sum(coralPval<=x))
setNames(under, paste(fdrcrit))

## B7_3f
p45 <- (fdrcrit[1]*under[1]-fdrcrit[2]*under[2])/(under[1]-under[2])
p12 <- (fdrcrit[3]*under[3]-fdrcrit[4]*under[4])/(under[3]-under[4])

## 2_18
par(fig=c(0.525,1,0,1), mgp=c(1.5,0.4,0))
lev <- c("F10", "NH4Cl", "NH4NO3", "F10 +ANU843",
         "NH4Cl +ANU843", "NH4NO3 +ANU843")
rice <- within(DAAG::rice, trt <- factor(trt, levels=lev))
with(rice, interaction.plot(fert, variety, ShootDryMass, fg="gray",
     legend = FALSE, xlab="Fertiliser", cex.lab=0.95, mex=0.65))
xleg <- par()$usr[2]
yleg <- par()$usr[4] - 0.72 * diff(par()$usr[3:4])
leginfo <- legend(xleg, yleg, bty = "n", legend = levels(rice$variety),
                  col = 1, lty = 2:1, lwd=1, xjust = 1, cex = 0.8,
                  y.intersp=0.8)$rect
text(leginfo$left + 0.5 * leginfo$w, leginfo$top, "  variety",
      adj = 0.5, cex = 0.8)
mtext(side=3, line=0.65, cex=0.9, adj=-0.15, "B")
gph <- dotplot(trt ~ ShootDryMass, pch=1, cex=0.9, las=2,
               xlab="Shoot dry mass (g)", data=rice,
               panel=function(x,y,...){panel.dotplot(x,y,...)
                 av <- sapply(split(x,y),mean);
                 ypos <- unique(y)
                 lpoints(ypos~av, pch=3, col="gray40", cex=1.25)},
               main=list("A", cex=0.88, just="left", x=0.1, y=-0.7, font=1))
pars <-  DAAG::DAAGtheme(fontsize=list(text=9, points=6), color=FALSE)
print(update(gph, scales=list(tck=0.5), par.settings=pars, aspect=0.9),
      position=c(-0.065,0.0,0.6,1), newpage=FALSE)

## B9_2a
pval <- c(.05,.01,.001); np <- length(pval)
Nval <- c(4,6,10,20,40,80,160); nlen <- length(Nval)
## Difference in BIC statistics, interpreted as Bayes factor
t2BFbic <- function(p,N){t <- qt(p/2, df=N-1, lower.tail=FALSE)
                         exp((N*log(1+t^2/(N-1))-log(N))/2)}
bicVal <- outer(pval, Nval, t2BFbic)
## Bayes factor, calculated using BayesFactor::ttest.tstat()
t2BF <- function(p, N){t <- qt(p/2, df=N-1, lower.tail=FALSE)
          BayesFactor::ttest.tstat(t=t, n1=N, simple=TRUE, rscale = "medium")}
BFval <- matrix(nrow=np, ncol=nlen)
for(i in 1:np)for(j in 1:nlen) BFval[i,j] <- t2BF(pval[i], Nval[j])
cfVal <- rbind(BFval, bicVal)[c(1,4,2,5,3,6),]
dimnames(cfVal) <- list(
  paste(rep(pval,rep(2,np)), rep(c("- from ttest.tstat", "- from BIC"),np)),
        paste0(c("n=",rep("",nlen-1)),Nval))
round(cfVal,1)

## B9_3a
suppressPackageStartupMessages(library(MCMCpack))
roller.mcmc <- MCMCregress(depression ~ weight, data=DAAG::roller)
summary(roller.mcmc)

## 2_19
mat <- matrix(c(1:6), byrow=TRUE, ncol=2)
layout(mat, widths=rep(c(2,1.1),3), heights=rep(0.9,8))
  # NB: widths & heights are relative
plot(roller.mcmc, auto.layout=FALSE, ask=FALSE, col="gray", fg="gray")

## B12_22
## UCBAdmissions is in the datasets package
## For each combination of margins 1 and 2, calculate the sum
UCBtotal <- apply(UCBAdmissions, c(1,2), sum)

## B12_2b
apply(UCBAdmissions, 3, function(x)(x[1,1]*x[2,2])/(x[1,2]*x[2,1]))

## B12_3AB
tabA <- array(c(30,30,10,10,15,5,30,10), dim=c(2,2,2))
tabB <- array(c(30,30,20,10,10,5,20,25), dim=c(2,2,2))

## B12_5
z.transform <- function(r) .5*log((1+r)/(1-r))
z.inverse <- function(z) (exp(2*z)-1)/(exp(2*z)+1)
  possum.fun <- function(data, indices) {
    chest <- data$chest[indices]
    belly <- data$belly[indices]
    z.transform(cor(belly, chest))}
possum.boot <- boot::boot(DAAG::possum, possum.fun, R=999)
z.inverse(boot.ci(possum.boot, type="perc")$percent[4:5])
 # The 4th and 5th elements of the percent list element
 # hold the interval endpoints. See ?boot.ci

## B12_11
with(pressure, MASS::boxcox(pressure ~ I(1/(temperature+273))))

## B12_14
"funRel" <-
function(x=leafshape$logpet, y=leafshape$loglen, scale=c(1,1)){
  ## Find principal components rotation; see Subsection 9.1.2
  ## Here (unlike 9.1.2) the interest is in the final component
  xy.prc <- prcomp(cbind(x,y), scale=scale)
  b <- xy.prc$rotation[,2]/scale
  c(bxy = -b[1]/b[2])     # slope of functional equation line
}
## Try the following:
leafshape <- DAAG::leafshape
funRel(scale=c(1,1))    # Take x and y errors as equally important
  # Note that all lines pass through (mean(x), mean(y))

## B12_15
P <- rbind(
    c(1 , 0 , 0 , 0 , 0 , 0),
    c(.5, 0 , .5, 0 , 0 , 0),
    c(0 , .5, 0 , .5, 0 , 0),
    c(0 , 0 , .5, 0 , .5, 0),
    c(0 , 0 , 0 , .5, 0 , .5),
    c(0 , 0 , 0 , 0 , 0 , 1))
dimnames(P) <- list(0:5,0:5)
P

## B12_15x
Markov <- function(N=15, initial.value=1, transition=P, stopval=NULL)
  {X <- numeric(N)
   X[1] <- initial.value + 1  # States 0:(n-1); subscripts 1:n
   n <- nrow(transition)
   for (i in 2:N){
    X[i] <- sample(1:n, size=1, prob=transition[X[i-1], ])
    if(length(stopval)>0)if(X[i] %in% (stopval+1)){X <- X[1:i]; break}}
  X - 1
}
 # Set `stopval=c(0,5)` to stop when  the player's fortune is $0 or $5

## B12_16
Pb <- rbind(
  Sun = c(Sun=0.6, Cloud=0.2, Rain=0.2),
  Cloud= c(0.2, 0.4, 0.4),
  Rain= c(0.4, 0.3, 0.3))
Pb

## B12_16b
plotmarkov <-
  function(n=1000, width=101, start=0, transition=Pb, npanels=5){
    xc2 <- Markov(n, initial.value=start, transition)
    mav0 <- zoo::rollmean(as.integer(xc2==0), k=width)
    mav1 <- zoo::rollmean(as.integer(xc2==1), k=width)
    npanel <- cut(1:length(mav0), breaks=seq(from=1, to=length(mav0),
                  length=npanels+1), include.lowest=TRUE)
    df <- data.frame(av0=mav0, av1=mav1, x=1:length(mav0), gp=npanel)
    print(xyplot(av0+av1 ~ x | gp, data=df, layout=c(1,npanels), type="l",
          par.strip.text=list(cex=0.65), auto.key=list(columns=2),
          scales=list(x=list(relation="free"))))
}

## unnamed-chunk-2
code <- knitr::knit_code$get()
txt <- paste0("\n## ", names(code),"\n", sapply(code, paste, collapse='\n'))
writeLines(txt, con="../inst/doc/ch2.R")
