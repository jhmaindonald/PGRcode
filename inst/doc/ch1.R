
## comment
library(knitr)
opts_chunk[['set']](fig.width=6, fig.height=6, comment=" ",
                    out.width="80%", fig.align="center", fig.show='hold',
                    size="small", ps=10, strip.white = TRUE, 
                    tidy.opts = list(replace.assign=FALSE))

## CodeControl
## xtras=TRUE    ## Set to TRUE to execute code 'extras'
xtras <- FALSE
library(knitr)
## opts_chunk[['set']](results="asis")
## opts_chunk[['set']](eval=FALSE)   ## Set to TRUE to execute main part of code
opts_chunk[['set']](eval=FALSE) 

## setup
## The following extends available code chunk options, and simplifies 
## figure width and height arguments to `w` and `h`.
Hmisc::knitrSet(basename="intro", fig.path="figs/g", lang="markdown")
oldopt <- options(digits=4, formatR.arrow=FALSE, width=70, scipen=999)

## A1_1a
## For the sequence below, precede with set.seed(3676)
set.seed(3696)
sample(1:9384, 12, replace=FALSE)  # NB: `replace=FALSE` is the default

## A1_1b
chosen1200 <- sample(1:19384, 1200, replace=FALSE)  

## A1_1c
## For the sequence below, precede with set.seed(366)
set.seed(366)
split(sample(seq(1:10)), rep(c("Control","Treatment"), 5))
# sample(1:10) gives a random re-arrangement (permutation) of 1, 2, ..., 10

## A1_1d
sample(1:10, replace=TRUE)
## sample(1:10, replace=FALSE) returns a random permutation of 1,2,...10

## 1_1
## Code
suppressPackageStartupMessages(library(latticeExtra, quietly=TRUE))
cuckoos <- DAAG::cuckoos
## For tidier labels replace ".", in several of the names, by a space
specnam <- with(cuckoos, sub(pattern=".", replacement=" ", 
                             levels(species), fixed=TRUE))
# fixed=TRUE: "interpret "." as ".", not as a 'any single character'"
cuckoos <- within(cuckoos, levels(species) <- specnam)
## Panel A: Dotplot: data frame cuckoos (DAAG)
av <- with(cuckoos, aggregate(length, list(species=species), FUN=mean))
gphA <- dotplot(species ~ length, data=cuckoos, alpha=0.4) +
  as.layer(dotplot(species ~ x, pch=3, cex=1.4, col="black", data=av))
# alpha sets opacity. With alpha=0.4, 60% of the background shows through
# Enter `print(plt1)` or `plot(plt1)` or simply `plt1` to display the graph
## Panel B: Box plot
gphB <- bwplot(species ~ length, data=cuckoos)
update(c("A: Dotplot"=gphA, "B: Boxplot"=gphB), between=list(x=0.4),
       xlab="Length of egg (mm)") 
## latticeExtra::c() joins compatible plots together. 
##   See `?latticeExtra::c`

## 1_1strip
library(latticeExtra)   # Lattice package will be loaded and attached also
cuckoos <- DAAG::cuckoos
## Panel A: Dotplot without species means added
dotplot(species ~ length, data=cuckoos)   ## `species ~ length` is a 'formula'
## Panel B: Box and whisker plot
bwplot(species ~ length, data=cuckoos)
## The following shows Panel A, including species means & other tweaks
av <- with(cuckoos, aggregate(length, list(species=species), FUN=mean))
dotplot(species ~ length, data=cuckoos, alpha=0.4, xlab="Length of egg (mm)") +
  as.layer(dotplot(species ~ x, pch=3, cex=1.4, col="black", data=av))
  # Use `+` to indicate that more (another 'layer') is to be added.
  # With `alpha=0.4`, 40% is the point color with 60% background color
  # `pch=3`: Plot character 3 is '+'; `cex=1.4`: Default char size X 1.4

## A1_3b
options(width=70)
cuckoos <- DAAG::cuckoos
av <- with(cuckoos, aggregate(length, list(species=species), FUN=mean))
setNames(round(av[["x"]],2), abbreviate(av[["species"]],10))

## A1_3c
with(cuckoos, scale(length[species=="wren"], scale=FALSE))[,1] 

## 1_2
library(latticeExtra, quietly=TRUE)
fossum <- subset(DAAG::possum, sex=="f")
femlen <- DAAG::bounce(fossum[["totlngth"]], d=0.1)
## Panel A
yaxpos <- c(0,5,10,15,20)/(5*nrow(fossum))
z <- boxplot(list(val = femlen), plot = FALSE)
gph1 <- bwplot(~femlen, ylim=c(0.55,2.75), xlim=c(70,100), 
               scales=list(y=list(draw=FALSE)))+
        latticeExtra::layer(panel.rug(x,pch="|"))
legstat <- data.frame(x=c(z$out,z$stats), y=c(1.08, rep(1.3,5)),
  tx=c("Outlier?", "Smallest value", "lower quartile", "median", 
       "upper quartile",  "Largest value"), 
  tx2= c("", "(outliers excepted)",rep("",3), "(no outliers)"))
gphA <- gph1+latticeExtra::layer(data=legstat,
  panel.text(x=x,y=y,labels=tx,adj=c(0,0.4),srt=90, cex=0.85),
  panel.text(x=x[c(2,6)]+0.75,y=c(1.125,1.38),labels=tx2[c(2,6)],
             adj=c(0,0.4),srt=90, cex=0.85))
## Panel B
gph2 <- densityplot(~femlen, ylim=c(0,0.108), xlim=c(70,100), 
          plot.points=TRUE, pch="|",cex=1.75, ylab=c("","      Density"))
gph3 <- histogram(~femlen, ylim=c(0,0.108), type="density", 
  scales=list(y=list(at=yaxpos, labels=c(0,5,10,15,20), col="gray40")), 
  alpha=0.5, ylab="", breaks=c(75,80,85,90,95,100), 
  col='transparent',border='gray40')
gph4 <- doubleYScale(gph2, gph3, use.style=FALSE, add.ylab2=FALSE)
gphB <- update(gph4, par.settings=list(fontsize = list(text=10, points=5)),
  scales=list(tck=c(0.5,0.5)))
update(c("B: Density curve, with histogram overlaid"=gphB, 
         "A: Boxplot, with annotation added"=gphA, layout=c(1,2), y.same=F), 
       as.table=TRUE, between=list(y=1.4), 
       xlab="Total length of female possums (cm)")

## A2_la
fossum <- subset(DAAG::possum, sex=="f")
densityplot(~totlngth, plot.points=TRUE, pch="|", data=fossum) +
  layer_(panel.histogram(x, type="density", breaks=c(75,80,85,90,95,100)))

## 1_3
## Code
possum <- DAAG::possum
gph <- bwplot(Pop~totlngth|sex, data=possum) +
  latticeExtra::layer(panel.dotplot(x, unclass(y)-0.4, pch=1))
parset <- list(fontsize=list(text=10.0, points=5), pch=16,cex=1)
update(gph, par.settings=parset, xlab="Total length (cm)",
       between=list(x=0.4), scales=list(tck=c(0.5,0.5)))

## A2_1b
## Create boxplot graph object --- Simplified code
gph <- bwplot(Pop~totlngth | sex, data=possum) 
## plot graph, with dotplot distribution of points below boxplots
gph + latticeExtra::layer(panel.dotplot(x, unclass(y)-0.4)) 

## 1_4
layout(matrix(c(1,2)), heights=c(2.6,1.75))
measles <- DAAG::measles
## Panel A:
par(mgp=c(2.0,0.5,0))
plot(log10(measles), xlab="", ylim=log10 (c(1,5000*540)),
     ylab=" Deaths", yaxt="n", fg="gray", adj=0.16)
londonpop <-ts(c(1088, 1258, 1504, 1778, 2073, 2491, 2921, 3336, 3881,
  4266, 4563, 4541, 4498, 4408), start=1801, end=1931, deltat=10)
points(log10(londonpop*500), pch=16, cex=.5)
ytiks1 <- c(1, 10, 100, 1000)
axis(2, at=log10(ytiks1), labels=paste(ytiks1), lwd=0, lwd.ticks=1)
abline(h=log10(ytiks1), col = "lightgray", lwd=2)
par(mgp=c(-2,-0.5,0))
ytiks2 <- c(1000000, 5000000)  ## London population in thousands
abline(h=log10(ytiks2*0.5), col = "lightgray", lwd=1.5)
abline(v=seq(from=1650,to=1950,by=50), col = "lightgray", lwd = 1.5)
mtext(side=2, line=0.5, "Population", adj=1, cex=1.15, las=3)
axis(2, at=log10(ytiks2*0.6), labels=paste(ytiks2), tcl=0.3,
     hadj=0, lwd=0, lwd.ticks=1)
mtext(side=3, line=0.3, "A (1629-1939)", adj=0, cex=1.15)
##
## Panel B: window from 1840 to 1882
par(mgp=c(2.0,0.5,0))
plot(window(measles, start=1840, end=1882), xlab="",
ylab="Deaths    Pop (1000s)", ylim=c(0, 4200), fg="gray")
points(window(londonpop, start=1840, end=1882), pch=16, cex=0.5)
mtext(side=3, line=0.5, "B (1841-1881)", adj=0, cex=1.15)

## 1_5
## Untransformed vs log transformed scales
Animals <- MASS::Animals
asp <- with(Animals, sapply(list(log(brain/100), log(body/100)), 
                            function(x)diff(range(x)))) |> (\(d)d[1]/d[2])()
xlab <- "Body weight (unit=100kg)"; ylab <- "Brain (unit=100g)"
gphA <- xyplot(I(brain/100) ~ I(body/100), data=Animals, aspect=asp,
               xlab=xlab, ylab=ylab)
gphB <- xyplot(log(brain/100) ~ log(body/100), data=MASS::Animals,  # Panel B
               aspect='iso', xlab=xlab, ylab=ylab)
labx <- 10^c((-3):3); laby <- 10^c((-2):2)
gphB <- update(gphB, scales=list(x=list(at=log(labx), labels=labx, rot=20),
                                 y=list(at=log(laby), labels=laby)))
plot(update(gphA, strip = strip.custom(factor.levels='A: Linear scales')),
     position=c(0,0,.55,1), more=TRUE)
plot(update(gphB, strip = strip.custom(factor.levels='B: Logarithmic scales')), 
     position=c(0.45,0,1,1))

## 1_6
par(pty="s")
plot(distance.traveled ~ starting.point, data=DAAG::modelcars, fg="gray",
xlim=c(0,12.5), xaxs="i", xlab = "Distance up ramp (cm)",
ylab="Distance traveled (cm)")

## A2_4a
## Apply function range to columns of data frame jobs (DAAG)
sapply(DAAG::jobs, range)  ## NB: `BC` = British Columbia

## 1_7
## Panel A: Basic plot; all series in a single panel; use log y-scale
formRegions <- Ontario+Quebec+BC+Alberta+Prairies+Atlantic ~ Date
basicGphA <-
  xyplot(formRegions, outer=FALSE, data=DAAG::jobs, type="l", xlab="", 
         ylab="Number of workers", scales=list(y=list(log="e")),
         auto.key=list(space="right", lines=TRUE, points=FALSE))
  ## `outer=FALSE`: plot all columns in one panel
## Panel B: Separate panels (`outer=TRUE`); sliced log scale
basicGphB <-
  xyplot(formRegions, data=DAAG::jobs, outer=TRUE, type="l", layout=c(3,2), 
         xlab="", ylab="Number of workers",
         scales=list(y=list(relation="sliced", log=TRUE)))
# Provinces are in order of number of workers in Dec96
## Create improved x- and y-axis tick labels; will update to use
datelabpos <- seq(from=95, by=0.5, length=5)
datelabs <- format(seq(from=as.Date("1Jan1995", format="%d%b%Y"),
                   by="6 month", length=5), "%b%y")
## Now create $y$-labels that have numbers, with log values underneath
ylabposA <- exp(pretty(log(unlist(DAAG::jobs[,-7])), 5))
ylabelsA <- paste(round(ylabposA),"\n(", log(ylabposA), ")", sep="")
## Repeat, now with 100 ticks, to cover all 6 slices of the scale
ylabposB <- exp(pretty(log(unlist(DAAG::jobs[,-7])), 100))
ylabelsB <- paste(round(ylabposB),"\n(", log(ylabposB), ")", sep="")
gphA <- update(basicGphA, scales=list(x=list(at=datelabpos, labels=datelabs),
              y=list(at=ylabposA, labels=ylabelsA)))
gphB <- update(basicGphB, xlab="", between=list(x=0.25, y=0.25),
               scales=list(x=list(at=datelabpos, labels=datelabs),
               y=list(at=ylabposB, labels=ylabelsB)))
layout.list <- list(layout.heights=list(top.padding=0,
                    bottom.padding=0, sub=0, xlab=0), 
                    fontsize=list(text=8, points=5))
jobstheme <- modifyList(ggplot2like(pch=1, lty=c(4:6,1:3),
                                    col.line='black', cex=0.75),layout.list)
print(update(gphA, par.settings=jobstheme, axis=axis.grid,
      main=list("A: Same vertical log scale",y=0)),
      position=c(0.1,0.615,0.9,1), newpage=TRUE)
print(update(gphB, par.settings=jobstheme, axis=axis.grid,
      main=list("B: Sliced vertical log scale",y=0)),
      position=c(0,0,1,0.625), newpage=FALSE)

## 1_8
plot(c(1230,1860), c(0, 10.5), axes=FALSE, bty="n",
     xlab="", ylab="", type="n", log="x")
xpoints <- c(1366, 1436, 1752, 1840)
axis(1, at=xpoints, labels=FALSE, tck=0.01, lty=1, lwd=0, lwd.ticks=1)
for(i in 1:4){
  axis(1, at=xpoints[i],
       labels=substitute(italic(a), list(a=paste(xpoints[i]))),
  line=-2.25, lty=0, cex=0.8, lwd=0, lwd.ticks=1)
  lines(rep(xpoints[i],2), c(0, 0.15*par()[["cxy"]][2]), lty=1)
}
axpos <- 1250*cumprod(c(1, rep(1.2,2)))
axis(1, at=c(axpos,1840), labels=F, lwd.ticks=0)
lab <- round(axpos)
axis(1, at=axpos, labels=lab)
lab2 <- lapply(round(log2(xpoints),3), function(x)substitute(2^a, list(a=x)))
axis(1, at=xpoints, labels=as.expression(lab2), line=-3.5, lwd=0)
labe <- lapply(format(round(log(xpoints),3)), function(x)substitute(e^a, list(a=x)))
axis(1, at=xpoints, labels=as.expression(labe), line=-5, lwd=0)
lab10 <- lapply(round(log10(xpoints),3), function(x)substitute(10^a, list(a=x)))
axis(1, at=xpoints, labels=as.expression(lab10), line=-6.5, lwd=0)
par(family="mono", xpd=TRUE)
axis(1, at=1220, labels="log=2", line=-3.5, hadj=0, lwd=0)
axis(1, at=1220, labels='log="e"', line=-5, hadj=0, lwd=0)
axis(1, at=1220, labels="log=10", line=-6.5, hadj=0, lwd=0)  
wid2 <- strwidth("log=2")
par(family="sans")

## A2_5a
stones <- array(c(81,6,234,36,192,71,55,25), dim=c(2,2,2),
                dimnames=list(Success=c("yes","no"),
                Method=c("open","ultrasound"), Size=c("<2cm", ">=2cm")))
margin12 <- margin.table(stones, margin=1:2)

## 1_9
byMethod <- 100*prop.table(margin12, margin=2)
pcGood <- 100*prop.table(stones, margin=2:3)["yes", , ]
dimnam <- dimnames(stones)
numOps <- margin.table(stones, margin=2:3)
opStats <- data.frame(Good=c(pcGood[1,],pcGood[2,]),
                      numOps=c(numOps[1,], numOps[2,]),
                      opType=factor(rep(dimnam[["Method"]],c(2,2))),
                      Size=rep(dimnam[["Size"]],2))
xlim <- range(opStats$Good)*c(0.65,1.015)
ylim <- c(0, max(opStats$numOps)*1.15)
plot(numOps~Good, data=opStats, type="h", lwd=4, xlim=xlim, ylim=ylim,
     fg="gray",col=rep(c("blue","red"),rep(2,2)),
     xlab="Success rate (%)", ylab="Number of operations")
# with(opStats, text(numOps~Good, labels=Size,
#                    col=rep(c('blue','red'),rep(2,2)),
#                    offset=0.25,pos=3, cex=0.75))
labpos <- lapply(split(opStats, opStats$Size), 
  function(x)apply(x[,1:2],2,function(z)c(z[1],mean(z),z[2])))
sizeNam <- names(labpos)
lapply(labpos, function(x)lines(x[,'Good'],x[,'numOps']+c(0,35,0),
  type="c",col="gray"))
txtmid <- sapply(labpos, function(x)c(x[2,'Good'],x[2,'numOps']+35))
text(txtmid[1,]+c(-1.4,0.85),txtmid[2,],labels=sizeNam,col="gray40",
     pos=c(4,2), offset=0)
par(xpd=TRUE)
text(byMethod[1,1:2],rep(par()$usr[4],2)+0.5*strheight("^"), labels=c("^","^"),
     col=c("blue","red"),cex=1.2,srt=180)
text(byMethod[1,], par()$usr[4]+1.4*strheight("A"),
     labels=paste(round(byMethod[1,],1)),cex=0.85)
text(byMethod[1,1:2]+c(3.5,-3.5), rep(par()$usr[4],2)+2.65*strheight("A"),
labels=c("All open","All ultrasound"), pos=c(2,4))
par(xpd=FALSE)
abline(h=100*(0:2),col="lightgray",lwd=0.5)
abline(v=10*(5:9),col="lightgray",lwd=0.5)
legend("topleft", col=c('blue','red'),lty=c(1,1), lwd=1, cex=0.9,
       y.intersp=0.75, legend=c("Open","Ultrasound"),bty="n",
       inset=c(-0.01,-0.01))

## A3_1a
## Table of counts example: data frame nswpsid1 (DAAG)
## Specify `useNA="ifany"` to ensure that any NAs are tabulated
tab <- with(DAAG::nswpsid1, table(trt, nodeg, useNA="ifany"))
dimnames(tab) <- list(trt=c("none", "training"), educ = c("completed", "dropout"))
tab

## A3_1b
nassCDS <- DAAG::nassCDS
NIFrange <- range(nassCDS$weight, na.rm=T)

## 1_10
gph <- lattice::bwplot(log(nassCDS$weight+1), xlab="Inverse sampling weights",
  scales=list(x=list(at=c(0,log(c(10^(0:5)+1))), labels=c(0,10^(0:5)))))
update(gph, par.settings=DAAG::DAAGtheme(color=F, col.points='gray50'))

## A3_1d
sampNum <- table(nassCDS$dead)
popNum <- as.vector(xtabs(weight ~ dead, data=nassCDS))
rbind(Sample=sampNum, "Total number"=round(popNum,1))

## A3_1e
nassCDS <- DAAG::nassCDS
Atab <- xtabs(weight ~ airbag + dead, data=nassCDS)/1000
## Define a function that calculates Deaths per 1000
DeadPer1000 <- function(x)1000*x[2]/sum(x)
Atabm <- ftable(addmargins(Atab, margin=2, FUN=DeadPer1000))
print(Atabm, digits=2, method="compact", big.mark=",")

## A3_1f
SAtab <- xtabs(weight ~ seatbelt + airbag + dead, data=nassCDS)
## SAtab <- addmargins(SAtab, margin=3, FUN=list(Total=sum))  ## Gdet Totals
SAtabf <- ftable(addmargins(SAtab, margin=3, FUN=DeadPer1000), col.vars=3)
print(SAtabf, digits=2, method="compact", big.mark=",")

## A3_1g
FSAtab <- xtabs(weight ~ dvcat + seatbelt + airbag + dead, data=nassCDS)
FSAtabf <- ftable(addmargins(FSAtab, margin=4, FUN=DeadPer1000), col.vars=3:4)
print(FSAtabf, digits=1)

## 1_11
## Individual vine yields, with means by block and treatment overlaid
kiwishade <- DAAG::kiwishade
kiwishade$block <- factor(kiwishade$block, levels=c("west","north","east"))
keyset <- list(space="top", columns=2,
text=list(c("Individual vine yields", "Plot means (4 vines)")),
points=list(pch=c(1,3), cex=c(1,1.35), col=c("gray40","black")))
panelfun <- function(x,y,...){panel.dotplot(x,y, pch=1, ...)
av <- sapply(split(x,y),mean); ypos <- unique(y)
lpoints(ypos~av, pch=3, col="black")}
dotplot(shade~yield | block, data=kiwishade, col="gray40", aspect=0.65,
        panel=panelfun, key=keyset, layout=c(3,1))
## Note that parameter settings were given both in the calls
## to the panel functions and in the list supplied to key.

## A3_2b
## mean yield by block by shade: data frame kiwishade (DAAG)
kiwimeans <- with(DAAG::kiwishade, 
                  aggregate(yield, by=list(block, shade), mean))
names(kiwimeans) <- c("block","shade","meanyield")
head(kiwimeans, 4)  # First 4 rows

## A3_3a
options(width=72)
## SD of length, by species: data frame cuckoos (DAAG)
z <- with(cuckoos, sapply(split(length,species), function(x)c(sd(x),length(x))))
print(setNames(paste0(round(z[1,],2)," (",z[2,],")"),
               abbreviate(colnames(z),11)), quote=FALSE)

## A3_6a
setNames(diff(c(ambient=244.1, heated=253.5))/c(sd=10.91), "Effect size")

## A3_6b
vignette('effectsize', package='effectsize')

## 1_12
set.seed(17)
x1 <- x2 <- x3 <- (11:30)/5
y1 <- x1 + rnorm(20, sd=0.5)
y2 <- 2 - 0.05 * x1 + 0.1 * ((x1 - 1.75))^4 + rnorm(20, sd=1.5)
y3 <- (x1 - 3.85)^2 + 0.015 + rnorm(20)
theta <- ((2 * pi) * (1:20))/20
x4 <- 10 + 4 * cos(theta)
y4 <- 10 + 4 * sin(theta) + rnorm(20, sd=0.6)
xy <- data.frame(x = c(rep(x1, 3), x4), y = c(y1, y2, y3, y4),
                gp = factor(rep(1:4, rep(20, 4))))
xysplit <- split(xy, xy$gp)
rho <- sapply(xysplit, function(z)with(z,cor(x,y, method=c("pearson"))))
rhoS <- sapply(xysplit, function(z)with(z,cor(x,y, method=c("spearman"))))
rnam <- as.list(setNames(round(c(rho,rhoS),2), paste0("r",1:8)))
striplabs <- bquote(expression(paste(r==.(r1), "    ",r[s]==.(r5)), 
                               paste(r==.(r2), "    ",r[s]==.(r6)),
                               paste(r==.(r3), "    ",r[s]==.(r7)), 
                               paste(r==.(r4), "    ",r[s]==.(r8))), rnam)
xyplot(y ~ x | gp, data=xy, layout=c(4,1), xlab="", ylab="", 
  strip=strip.custom(factor.levels=striplabs), aspect=1,
  scales=list(relation='free', draw=FALSE), between=list(x=0.5,y=0)
)

## A4_2a
## dbinom(0:10, size=10, prob=0.15)
setNames(round(dbinom(0:10, size=10, prob=0.15), 3), 0:10)

## A4_2b
pbinom(q=4, size=10, prob=0.15)

## A4_2c
qbinom(p = 0.70, size = 10, prob = 0.15)
## Check that this lies between the two cumulative probabilities:
## pbinom(q = 1:2, size=10, prob=0.15)

## A4_2d
rbinom(15, size=4, p=0.5)

## A4_2e
## dpois(x = 0:8, lambda = 3)
setNames(round(dpois(x = 0:8, lambda = 3),4), 0:8)
## Probability of > 8 raisins
## 1-ppois(q = 8, lambda = 3)     ## Or, ppois(q=8, lambda=3, lower.tail=FALSE)

## A4_2f
1 - ppois(q = 8, lambda = 3)
ppois(q=8, lambda=3, lower.tail=FALSE)  ## Alternative
1-sum(dpois(x = 0:8, lambda = 3))       ## Another alternative

## A4_2g
raisins <- rpois(20, 3)
raisins

## A4_2h
set.seed(23286)  # Use to reproduce the sample below
rbinom(15, size=1, p=0.5)

## 1_13
z <- seq(-3,3,length=101)
plot(z, dnorm(z), type="l", ylab="Normal density",
     yaxs="i", bty="L",  tcl=-0.3, fg="gray",
    xlab="Distance, in SDs, from mean", cex.lab=0.9)
polygon(c(z[z <= 1.0],1.0),c(dnorm(z[z <= 1.0]), dnorm(-3)), col="grey")
chh <- par()$cxy[2]
arrows(-1.8, 0.32, -0.25, 0.2, length=0.07, xpd=T)
cump <- round(pnorm(1), 3)
text(-1.8, 0.32+0.75*chh, paste("pnorm(1)\n", "=", cump), xpd=T, cex=0.8)

## A4_3b
pnormExs <- c('pnorm(0)', 'pnorm(1)', 'pnorm(-1.96)', 'pnorm(1.96)',
'pnorm(1.96, mean=2)', 'pnorm(1.96, sd=2)')
Prob <- sapply(pnormExs, function(x)eval(parse(text=x)))
df <- as.data.frame(Prob)
df$Prob <- round(df$Prob,3)
print(df)

## A4_3c
## Plot the normal density, in the range -3 to 3
z <- pretty(c(-3,3), 30)   # Find ~30 equally spaced points
ht <- dnorm(z)             # Equivalent to dnorm(z, mean=0, sd=1)
plot(z, ht, type="l", xlab="Normal variate", ylab="Density", yaxs="i")
# yaxs="i" locates the axes at the limits of the data

## A4_3e
qnorm(.9)          # 90th percentile; mean=0 and SD=1

## A4_3f
## Additional examples:
setNames(qnorm(c(.5,.841,.975)), nm=c(.5,.841,.975))
qnorm(c(.1,.2,.3))   # -1.282 -0.842 -0.524  (10th, 20th and 30th percentiles)
qnorm(.1, mean=100, sd=10)  # 87.2 (10th percentile, mean=100, SD=10)

## A4_3g
options(digits=2)  # Suggest number of digits to display
rnorm(10)          # 10 random values from the normal distribution

## 1_14
mu <- 10
sigma <- 1
n <- 1
m <- 50
four <- 4
nrep <- 5
seed <- 21
totrows <- 1
if(is.null(totrows))
totrows <- floor(sqrt(nrep))
totcols <- ceiling(nrep/totrows)
z <- range(pretty(mu + (c(-3.4, 3.4) * sigma), 50))
xy <- data.frame(x=rep(0,nrep),y=rep(0,nrep),n=rep(n,nrep),
                 mm=rep(m,nrep),four=rep(four,nrep))
fac <- factor(paste("Simulation", 1:nrep),
              lev <- paste("Simulation", 1:nrep))
xlim<-z
## ylim<-c(0,dnorm(0)*sqrt(n))
ylim <- c(0,1)
xy <- split(xy,fac)
xy<-lapply(1:length(xy),function(i){c(as.list(xy[[i]]), list(xlim=xlim,
           ylim=ylim))})
panel.mean <- function(data, mu = 10, sigma = 1, n2 = 1,
                       mm = 100, nrows, ncols, ...)
{
  vline <- function(x, y, lty = 1, col = 1)
  lines(c(x, x), c(0, y), lty = lty, col = col)
  n2<-data$n[1]
  mm<-data$mm[1]
  our<-data$four[1]  ## Four characters in each unit interval of x
  nmid <- round(four * 4)
  nn <- array(0, 2 * nmid + 1)
  #########################################
  z <- mu+seq(from=-3.4*sigma, to=3.4*sigma, length=mm)
  atx<-pretty(z)
  qz <- pnorm((z - mu)/sigma)
  dz <- dnorm((z - mu)/sigma)
  chw <- sigma/four
  chh <- strheight("O")*0.75
  htfac <- (mm * chh)/four
  if(nrows==1&&ncols==1)
  lines(z, dz * htfac)
  if(nrows==1)axis(1,at=atx, lwd=0, lwd.ticks=1)
  y <- rnorm(mm, mu, sigma/sqrt(n2))
  pos <- round((y - mu)/sigma * four)
  for(i in 1:mm) {
    nn[nmid + pos[i]] <- nn[nmid + pos[i]] + 1
    xpos <- chw * pos[i]
    text(mu + xpos, nn[nmid + pos[i]] * chh - chh/4, "x")
  }
}
DAAG::panelplot(xy,panel=panel.mean,totrows=totrows,totcols=totcols,
  oma=c(1.5, 0, rep(0.5,2)), fg='gray')

## A4_3h
## The following gives a conventional histogram representations:
set.seed (21)        # Use to reproduce the data in the figure
df <- data.frame(x=rnorm(250), gp=rep(1:5, rep(50,5)))
lattice::histogram(~x|gp, data=df, layout=c(5,1))

## A4_3i
runif(n = 20, min=0, max=1) # 20 numbers, uniform distn on (0, 1)
rexp(n=10, rate=3)          # 10 numbers, exponential, mean 1/3.

## A4_4a
tab <- t(as.matrix(DAAG::pair65))
rbind(tab,"heated-ambient"=tab[1,]-tab[2,])

## 1_15
## Normal quantile-quantile plot for heated-ambient differences,
## compared with plots for random normal samples of the same size
plt <- with(DAAG::pair65, DAAG::qreference(heated-ambient, nrep=10, nrows=2))
update(plt, scales=list(tck=0.4), xlab="")

## 1_16
library(lattice)
## Generate n sample values; skew population
sampfun = function(n) exp(rnorm(n, mean = 0.5, sd = 0.3))
gph <- DAAG::sampdist(sampsize = c(3, 9, 30), seed = 23, nsamp = 1000,
  FUN = mean, sampvals=sampfun, plot.type = "density")
samptheme <- DAAG::DAAGtheme(color=FALSE)
print(update(gph, scales=list(tck=0.4),  layout = c(3,1),
             par.settings=samptheme, main=list("A: Density curves", cex=1.25)),
      position=c(0,0.5,1,1), more=TRUE)
sampfun = function(n) exp(rnorm(n, mean = 0.5, sd = 0.3))
gph <- DAAG::sampdist(sampsize = c(3, 9, 30), seed = 23, nsamp = 1000, 
                      FUN = mean, sampvals=sampfun, plot.type = "qq")
print(update(gph, scales=list(tck=0.4), layout = c(3,1),
             par.settings=samptheme, 
             main=list("B: Normal quantile-quantile plots", cex=1.25)),
      position=c(0,0,1,0.5))

## 1_17
x <- seq(from=-4.2, to = 4.2, length.out = 50)
ylim <- c(0, dnorm(0))
ylim[2] <- ylim[2]+0.1*diff(ylim)
h1 <- dnorm(x)
h3 <- dt(x, 3)
h8 <- dt(x,8)
plot(x, h1, type="l", xlab = "", xaxs="i", ylab = "", yaxs="i",
bty="L", ylim=ylim, fg="gray")
mtext(side=3,line=0.5, "A: Normal (t8 overlaid)", adj=-0.2)
lines(x, h8, col="grey60")
mtext(side=1, line=1.75, "No. of SEMs from mean")
mtext(side=2, line=2.0, "Probability density")
chh <- par()$cxy[2]
topleft <- par()$usr[c(1,4)] + c(0, 0.6*chh)
legend(topleft[1], topleft[2], col=c("black","grey60"),
lty=c(1,1), legend=c("Normal","t (8 d.f.)"), bty="n", cex=0.8)
plot(x, h1, type="l", xlab = "", xaxs="i",
ylab = "", yaxs="i", bty="L", ylim=ylim, fg="gray")
mtext(side=3,line=0.5, "B: Normal (t3 overlaid)", adj=-0.2)
lines(x, h3, col="grey60")
mtext(side=1, line=1.75, "No. of SEMs from mean")
## mtext(side=2, line=2.0, "Probability density")
legend(topleft[1], topleft[2], col=c("black","grey60"),
lty=c(1,1), legend=c("Normal","t (3 d.f.)"), bty="n", cex=0.8)
## Panels C and D
cump <- 0.975
x <- seq(from=-3.9, to = 3.9, length.out = 50)
ylim <- c(0, dnorm(0))
plotfun <- function(cump, dfun = dnorm, qfun=qnorm,
ytxt = "Probability density",
txt1="qnorm", txt2="", ...)
{
h <- dfun(x)
plot(x, h, type="l", xlab = "", xaxs="i", xaxt="n",
ylab = ytxt, yaxs="i", bty="L", ylim=ylim, fg="gray",
...)
axis(1, at=c(-2, 0), cex=0.8, lwd=0, lwd.ticks=1)
axis(1, at=c((-3):3), labels=F, lwd=0, lwd.ticks=1)
tailp <- 1-cump
z <- qfun(cump)
ztail <- pretty(c(z,4),20)
htail <- dfun(ztail)
polygon(c(z,z,ztail,max(ztail)), c(0,dfun(z),htail,0), col="gray")
text(0, 0.5*dfun(z)+0.08*dfun(0),
paste(round(tailp, 3), " + ", round(1-2*tailp,3),
"\n= ", round(cump, 3), sep=""), cex=0.8)
lines(rep(z, 2), c(0, dfun(z)))
lines(rep(-z, 2), c(0, dfun(z)), col="gray60")
chh <- par()$cxy[2]
arrows(z, -1.5*chh,z,-0.1*chh, length=0.1, xpd=T)
text(z, -2.5*chh, paste(txt1, "(", cump, txt2, ")", "\n= ",
round(z,2), sep=""), xpd=T)
x1 <- z + .3
y1 <- dfun(x1)*0.35
y0 <- dfun(0)*0.2
arrows(-2.75, y0, -x1, y1, length=0.1, col="gray60")
arrows(2.75, y0, x1, y1, length=0.1)
text(-2.75, y0+0.5*chh, tailp, col="gray60")
text(2.75, y0+0.5*chh, tailp)
}
## ytxt <- "t probability density (8 d.f.)"
plotfun(cump=cump, cex.lab=1.05)
mtext(side=3, line=1.25, "C: Normal distribution", adj=-0.2)
ytxt <- "t probability density (8 d.f.)"
plotfun(cump=cump, dfun=function(x)dt(x, 8),
        qfun=function(x)qt(x, 8),
        ytxt="", txt1="qt", txt2=", 8", cex.lab=1.05)
mtext(side=3, line=1.25, "D: t distribution (8 df)", adj=-0.2)

## A4_5a
qnorm(c(0.975,0.995), mean=0)    # normal distribution
qt(c(0.975, 0.995), df=8)        # t-distribution with 8 d.f.

## A5_1a
roller <- DAAG::roller
t(cbind(roller, "depression/weight ratio"=round(roller[,2]/roller[,1],2)))

## 1_18
y <- DAAG::roller$depression
x <- DAAG::roller$weight
pretext <- c(reg = "A", lo = "B")
for(curve in c("reg", "lo")) {
  plot(x, y, xlab = "Roller weight (t)", xlim=c(0,12.75), fg="gray",
       ylab = "Depression in lawn (mm)", type="n")
  points(x, y, cex=0.8, pch = 4)
  mtext(side = 3, line = 0.25, pretext[curve], adj = 0)
  topleft <- par()$usr[c(1, 4)]
  chw <- strwidth("O"); chh <- strheight("O")
  points(topleft[1]+rep(0.75,2)*chw,topleft[2]-c(0.75,1.8)*chh,
         pch=c(4,1), col=c("black","gray40"), cex=0.8)
  text(topleft[1]+rep(1.2,2)*chw, topleft[2]-c(0.75,1.8)*chh,
       c("Data values", "Fitted values"),adj=0, cex=0.8)
  if(curve=="lo")
    text(topleft[1]+1.2*chw, topleft[2]-2.85*chh,"(smooth)", adj=0, cex=0.8)
  if(curve[1] == "reg") {
    u <- lm(y ~ -1 + x)
  abline(0, u$coef[1])
  yhat <- predict(u)
}
else {
  lawn.lm<-lm(y~x+I(x^2))
  yhat<-predict(lawn.lm)
  xnew<-pretty(x,20)
  b<-lawn.lm$coef
  ynew<-b[1]+b[2]*xnew+b[3]*xnew^2
  lines(xnew,ynew)
}
here <- y < yhat
yyhat <- as.vector(rbind(y[here], yhat[here], rep(NA, sum(here))))
xx <- as.vector(rbind(x[here], x[here], rep(NA, sum(here))))
lines(xx, yyhat, lty = 2, col="gray")
here <- y > yhat
yyhat <- as.vector(rbind(y[here], yhat[here], rep(NA, sum(here))))
xx <- as.vector(rbind(x[here], x[here], rep(NA, sum(here))))
lines(xx, yyhat, lty = 1, col="gray")
n <- length(y)
ns <- min((1:n)[y - yhat >= 0.75*max(y - yhat)])
ypos <- 0.5 * (y[ns] + yhat[ns])
chw <- par()$cxy[1]
text(x[ns] - 0.25*chw, ypos, "+ve residual", adj = 1,cex=0.75, col="gray30")
points(x, yhat, pch = 1, col="gray40")
ns <- (1:n)[y - yhat == min(y - yhat)][1]
ypos <- 0.5 * (y[ns] + yhat[ns])
text(x[ns] + 0.4*chw, ypos, "-ve residual", adj = 0,cex=0.75,col="gray30")
}

## A5_2a
## Fit line - by default, this fits intercept & slope.
roller.lm <- lm(depression ~ weight, data=DAAG::roller)
## Compare with the code used to plot the data
plot(depression ~ weight, data=DAAG::roller)
## Add the fitted line to the plot
abline(roller.lm)

## A5_2b
## For a model that omits the intercept term, specify
lm(depression ~ 0 + weight, data=roller)  # Or, if preferred, replace `0` by `-1`

## A5_2c
roller.lm <- lm(depression ~ weight, data=DAAG::roller)
names(roller.lm)     # Get names of list elements

## A5_2d
coef(roller.lm)           # Extract coefficients
summary(roller.lm)        # Extract model summary information
coef(summary(roller.lm))  # Extract coefficients and SEs
fitted(roller.lm)         # Extract fitted values
predict(roller.lm)        # Predictions for existing or new data, with SE
                          # or confidence interval information if required.
resid(roller.lm)          # Extract residuals

## A5_2e
roller.lm$coef            # An alternative is roller.lm[["coef"]]

## A5_2f
print(summary(roller.lm), digits=3)

## 1_19
## Normal quantile-quantile plot, plus 7 reference plots
DAAG::qreference(residuals(roller.lm), nrep=8, nrows=2, xlab="")

## A5_2i
roller.lm <- lm(depression ~ weight, data=DAAG::roller)
roller.sim <- simulate(roller.lm, nsim=20)  # 20 simulations

## A5_2j
with(DAAG::roller, matplot(weight, roller.sim, pch=1, ylim=range(depression)))
points(DAAG::roller, pch=16)

## A5_3a
model.matrix(roller.lm)
## Specify coef(roller.lm) to obtain the column multipliers.

## A5_3b
mouse.lm <- lm(brainwt ~ lsize+bodywt, data=DAAG::litters)
coef(summary(mouse.lm))

## A6_1a
## `before` is the `prevalence` or `prior`. 
after <- function(prevalence, sens, spec){
  prPos <- sens*prevalence + (1-spec)*(1-prevalence)
  sens*prevalence/prPos}
## Compare posterior for a prior of 0.002 with those for 0.02 and 0.2
setNames(round(after(prevalence=c(0.002, 0.02, 0.2), sens=.8, spec=.95), 3),
         c("Prevalence=0.002", "Prevalence=0.02", "Prevalence=0.2"))

## A6_2a
## Use pipe syntax, introduced in R 4.1.0
sleep <- with(datasets::sleep, extra[group==2] - extra[group==1])
sleep |> (function(x)c(mean = mean(x), SD = sd(x), n=length(x)))() |> 
     (function(x)c(x, SEM=x['SD']/sqrt(x['n'])))() |>
     setNames(c("mean","SD","n","SEM")) -> stats
     print(stats, digits=3)

## A6_2b
## Sum of tail probabilities
2*pt(1.580/0.389, 9, lower.tail=FALSE)  

## A6_2c
## 95% CI for mean of heated-ambient: data frame DAAG::pair65
t.test(sleep, conf.level=0.95)

## A6_2d
pt(4.06, 9, lower.tail=F)

## A6_2e
eff2stat <- function(eff=c(.2,.4,.8,1.2), n=c(10,40), numreps=100,
                     FUN=function(x,N)pt(sqrt(N)*mean(x)/sd(x), df=N-1, 
                                         lower.tail=FALSE)){
  simStat <- function(eff=c(.2,.4,.8,1.2), N=10, nrep=100, FUN){
    num <- N*nrep*length(eff)
    array(rnorm(num, mean=eff), dim=c(length(eff),nrep,N)) |>
      apply(2:1, FUN, N=N) 
  }
  mat <- matrix(nrow=numreps*length(eff),ncol=length(n))
  for(j in 1:length(n)) mat[,j] <- 
    as.vector(simStat(eff, N=n[j], numreps, FUN=FUN))  ## length(eff)*numep
  data.frame(effsize=rep(rep(eff, each=numreps), length(n)),
             N=rep(n, each=numreps*length(eff)), stat=as.vector(mat))
}

## 1_20
set.seed(31)
df200 <- eff2stat(eff=c(.2,.4,.8,1.2), n=c(10, 40), numreps=200)
labx <- c(0.001,0.01,0.05,0.2,0.4,0.8)
gph <- bwplot(factor(effsize) ~ I(stat^0.25) | factor(N), data=df200, 
              layout=c(2,1), xlab="P-value", ylab="Effect size", 
              scales=list(x=list(at=labx^0.25, labels =labx)))
update(gph+latticeExtra::layer(panel.abline(v=labx[1:3]^0.25, col='lightgray')),
       strip=strip.custom(factor.levels=paste0("n=",c(10,40))),
       par.settings=DAAG::DAAGtheme(color=F, col.points="gray50"))

## A6_2f
eff10 <- with(subset(df200, N==10&effsize==0.2), c(gt5pc=sum(stat>0.05), lohi=fivenum(stat)[c(2,4)]))
eff40 <- with(subset(df200, N==40&effsize==0.2), c(gt5pc=sum(stat>0.05), lohi=fivenum(stat)[c(2,4)]))

## A6_3a
tf1 <- rbind('R=0.2'=c(0.8*50, 0.05*250),
'R=1'=c(0.8*150, 0.05*150),
'R=5'=c(0.8*200, 0.05*50))
tf2 <- rbind(c('0.8 x50', '0.05x250'),
c('0.8x150', '0.05x150'),
c('0.8x250', '0.05 x50'))
tf <- cbind("True positives"=paste(tf2[,2],tf1[,2],sep="="),
"False positives"=paste(tf2[,1],tf1[,1],sep="="))
rownames(tf) <- rownames(tf1)
print(tf, quote=FALSE)

## A6_3b
power.t.test(d=0.5, sig.level=0.05, type="one.sample", power=0.8)
pwr1 <- power.t.test(d=0.5, sig.level=0.005, type="one.sample", power=0.8)
pwr2 <- power.t.test(d=0.5, sig.level=0.005, type="two.sample", power=0.8)
## d=0.5, sig.level=0.005, One- and two-sample numbers 
c("One sample"=pwr1$n, "Two sample"=pwr2$n)

## A6_3c
effsize <- c(.05,.2,.4,.8,1.2); npairs <- c(10,20,40)
pwr0.05 <- matrix(nrow=length(effsize), ncol=length(npairs),
               dimnames=list(paste0('ES=',effsize), paste0('n=',npairs)))
pwr0.005 <- matrix(nrow=length(effsize), ncol=length(npairs),
               dimnames=list(paste0(effsize), paste0('n=',npairs)))
for(i in 1:length(effsize)) for(j in 1:length(npairs)){
    pwr0.05[i,j] <- power.t.test(n=npairs[j],d=effsize[i],sig.level=0.05,
                                 type='one.sample')$power
    pwr0.005[i,j] <- power.t.test(n=npairs[j],d=effsize[i],sig.level=0.005,
                                  type='one.sample')$power}
tab <- cbind(round(pwr0.05,4), round(pwr0.005,4))
tab[1:3,] <- round(tab[1:3,],3)
tab[5,3] <- '~1.0000'
tab[5,6] <- '~1.0000'

## A6_3d
print(tab[,1:3], quote=F)

## A6_3e
print(tab[,4:6], quote=F)

## 1_21
R <- pretty(0:3, 40)
postOdds <- outer(R/0.05,c(.8,.3,.08))
PPV <- as.data.frame(cbind(R,postOdds/(1+postOdds)))
names(PPV) <- c("R","p80","p30","p8")
key <- list(text = list(text=c("80% power","30% power", "8% power"), cex = 1.0),
            x = .6, y = .25, color=F)
gph <- lattice::xyplot(p80+p30+p8~R, data=PPV, lwd=2, type=c("l","g"), 
  xlab="Pre-study odds R", ylab="Post-study probability (PPV)")
update(gph, scales=list(tck=0.5), key=key) 

## A7_3a
## Calculations using mouse brain weight data
mouse.lm <- lm(brainwt ~ lsize+bodywt, data=DAAG::litters)
n <- nrow(DAAG::litters)
RSSlogLik <- with(mouse.lm, n*(log(sum(residuals^2)/n)+1+log(2*pi)))
p <- length(coef(mouse.lm))+1  # NB: p=4 (3 coefficients + 1 scale parameter)
k <- 2*n/(n-p-1)
c("AICc" = AICcmodavg::AICc(mouse.lm), fromlogL=k*p-2*logLik(mouse.lm)[1], 
  fromFit=k*p + RSSlogLik) |> print(digits=4)

## 1_22
sim0vs1 <- function(mu=0, n=15, ntimes=200){
a0 <- a1 <- numeric(ntimes)
for(i in 1:ntimes){
  y <- rnorm(n, mean=mu, sd=1)
  m0 <- lm(y ~ 0); m1 <- lm(y ~ 1) 
  a0[i] <- AIC(m0); a1[i] <- AIC(m1)
}
data.frame(a0=a0, a1=a1, diff01=a0-a1, mu=rep(paste0("mu=",mu)))
}
library(latticeExtra)
sim0 <- sim0vs1(mu=0)
sim0.5 <- sim0vs1(mu=0.5)
simboth <- rbind(sim0, sim0.5)
cdiff <- with(list(n=15, p=2), 2*(p+1)*p/(n-(p+1)-1))
xyplot(diff01 ~ a0 | mu, data=simboth, xlab="AIC(m0)", ylab="AIC(m0) - AIC(m1)") + 
  latticeExtra::layer({panel.abline(h=0, col='red'); 
         panel.abline(h=cdiff, lwd=1.5, lty=3, col='red', alpha=0.5);
         panel.abline(h=-2, lty=2, col='red')})

## A7_3b
tab <- rbind(c(with(sim0, sum(diff01>0))/200, with(sim0.5, sum(diff01>0))/200),
  c(with(sim0,sum(diff01>-cdiff))/200, with(sim0.5, sum(diff01>-cdiff))/200))
dimnames(tab) <- list(c("AIC: Proportion choosing m1",
                        "AICc: Proportion choosing m1"),
                      c("True model is m0", "True model is m1"))
tab

## A7_4a
## Setting `scale=1/sqrt(2)` gives a mildly narrower distribution
print(c("pcauchy(1, scale=1)"=pcauchy(1, scale=1), 
        "   pcauchy(1, scale=1/sqrt(2))"=pcauchy(1, scale=1/sqrt(2))),
      quote=FALSE)

## 1_23
x <- seq(from=-4.5, to=4.5, by=0.1)
densMed <- dcauchy(x,scale=sqrt(2)/2)
densUltra <- dcauchy(x, scale=sqrt(2))
denn <- dnorm(x, sd=1)
plot(x,densMed, type='l', mgp=c(2,0.5,0), xlab="",
     ylab="Prior density", col="red", fg='gray')
mtext(side=1, line=2, expression("Effect size "==phantom(0)*delta), cex=1.1)
lines(x, denn, col="blue", lty=2)
lines(x, densUltra,col=2, lty=2)
legend("topleft", title="Normal prior",
       y.intersp=0.8, lty=2, col="blue", bty='n', cex=0.8,
       legend=expression(bold('sd=1')))
legend("topright", title="Cauchy priors", y.intersp=0.8,
       col=c('red', 'red'),lty=c(1,2), cex=0.8,
         legend=c(expression(bold('medium')),
         expression(bold('ultrawide'))),bty="n")
mtext(side=3, line=0.25, adj=0, cex=1.15,
      expression("A: Alternative priors for "*delta==frac(mu,sigma)))
## Panel B
pairedDiffs <- with(datasets::sleep, extra[group==2] - extra[group==1])
ttBF0 <- BayesFactor::ttestBF(pairedDiffs)
simpost <- BayesFactor::posterior(ttBF0, iterations=10000)
plot(density(simpost[,'mu']), main="", xlab="", col="red",
     mgp=c(2,0.5,0), ylab="Posterior density", fg='gray')
mtext(side=1, line=2, expression(mu), cex=1.1)
abline(v=mean(pairedDiffs), col="gray")
mtext(side=3, line=0.5, expression("B: Posterior density for "*mu), adj=0, cex=1.15)

## A7_4b
## Calculate and plot density for default prior - Selected lines of code
x <- seq(from=-4.5, to=4.5, by=0.1)
densMed <- dcauchy(x, scale=sqrt(2)/2)
plot(x, densMed, type='l')
## Panel B
pairedDiffs <- with(datasets::sleep, extra[group==2] - extra[group==1])
ttBF0 <- BayesFactor::ttestBF(pairedDiffs)
## Sample from posterior, and show density plot for mu
simpost <- BayesFactor::posterior(ttBF0, iterations=10000)
plot(density(simpost[,'mu']))

## A7_4c
tval <- setNames(qt(1-c(.05,.01,.005)/2, df=19), paste(c(.05,.01,.005)))
bf01 <- setNames(numeric(3), paste(c(.05,.01,.005)))
for(i in 1:3)bf01[i] <- BayesFactor::ttest.tstat(tval[i],n1=20, simple=T)

## A7_4d
pairedDiffs <- with(datasets::sleep, extra[group==2] - extra[group==1])
ttBF0 <- BayesFactor::ttestBF(pairedDiffs)
ttBFwide <- BayesFactor::ttestBF(pairedDiffs, rscale=1)
ttBFultra <- BayesFactor::ttestBF(pairedDiffs, rscale=sqrt(2))
rscales <- c("medium"=sqrt(2)/2, "wide"=1, ultrawide=sqrt(2))
BF3 <- c(as.data.frame(ttBF0)[['bf']], as.data.frame(ttBFwide)[['bf']],
         as.data.frame(ttBFultra)[['bf']])
setNames(round(BF3,2), c("medium", "wide", "ultrawide"))

## A7_4e
pval <- t.test(pairedDiffs)[['p.value']]
1/(-exp(1)*pval*log(pval))

## A7_4f
min45 <- round(0.75/sd(pairedDiffs),2)   ## Use standardized units
ttBFint <- BayesFactor::ttestBF(pairedDiffs, nullInterval=c(-min45,min45))
round(as.data.frame(ttBFint)['bf'],3)

## A7_4g
bf01 <- as.data.frame(ttBFint)[['bf']]

## 1_24a
t2bfInterval <- function(t, n=10, rscale="medium", mu=c(-.1,.1)){
     null0 <- BayesFactor::ttest.tstat(t=t, n1=n, nullInterval=mu,
                                       rscale=rscale,simple=TRUE)
alt0 <- BayesFactor::ttest.tstat(t=t, n1=n, nullInterval=mu, rscale=rscale, 
                                 complement=TRUE, simple=TRUE)
alt0/null0
}
##
## Calculate Bayes factors
pval <- c(0.05,0.01,0.001); nval <- c(4,6,10,20,40,80,160)
bfDF <- expand.grid(p=pval, n=nval)
pcol <- 1; ncol <- 2; tcol <- 3
bfDF[,'t'] <- apply(bfDF,1,function(x){qt(x[pcol]/2, df=x[ncol]-1,                                  lower.tail=FALSE)})
other <- apply(bfDF,1,function(x)
    c(BayesFactor::ttest.tstat(t=x[tcol], n1=x[ncol], rscale="medium",
                               simple=TRUE),
## Now specify a null interval
    t2bfInterval(t=x[tcol], n=x[ncol], mu=c(-0.1,0.1),rscale="medium")
  ))
bfDF <- setNames(cbind(bfDF, t(other)),
    c('p','n','t','bf','bfInterval'))

## 1_24
plabpos <- with(subset(bfDF, n==max(bfDF$n)), log((bf+bfInterval)/2))
gphA1 <- lattice::xyplot(log(bf)~log(n), groups=factor(p), data=bfDF,
                        panel=function(x,y,...){
                        lattice::panel.xyplot(x,y,type='b',...)})
ylabA <- 10^((-3):6/2)
scalesA <- list(x=list(at=log(nval), labels=nval),
                y=list(at=log(ylabA), labels=signif(ylabA,2)))
keyA <- list(corner=c(0.99,0.98), lines=list(col=c(1,1), lty=1:2),
             text=list(c('Point null at 0', "null=(-0.1,0.1)")))
ylim2 <- log(c(min(bfDF[['bfInterval']])-0.05,150)) 
gphA2 <- lattice::xyplot(log(bfInterval)~log(n), groups=factor(p), lty=2,
  xlim=c(log(3.5),log(max(nval)*3.25)), ylim=ylim2, data=bfDF,
  panel=function(x,y,...){
    panel.xyplot(x,y,type='b',...)
    panel.grid(h=-1,v=-1)
    panel.text(rep(log(max(nval*0.975)),3), plabpos, 
      labels=c('p=0.05','0.01','0.001'), pos=4)
  },
  par.settings=DAAG::DAAGtheme(color=T),
  main="A: Bayes factor vs sample size", 
  xlab="Sample size", ylab="Bayes factor", scales=scalesA, key=keyA)
## Panel B
bfDF[['eff']] = bfDF[["t"]]/sqrt(bfDF[['n']])
ylabB <- 10^((-3):2/3)
scalesB= list(x=list(at=log(nval), labels=nval),
              y=list(at=log(ylabB), labels=signif(ylabB,2)))
keyB <- list(corner=c(0.98,0.975), lines=list(lty=1:3), 
             points=list(pch=1:3), text=list(c('p=0.001','p=0.01','p=0.05')))
gphB <- xyplot(log(eff)~log(n), groups=log(p), data=bfDF, pch=1:3, lty=1:3, 
               type='b', xlab="Sample size", ylab="Effect  size",
               par.settings=DAAG::DAAGtheme(color=T),
  main="B: Effect size vs sample size", key=keyB, scales=scalesB) +
  latticeExtra::layer(panel.grid(h=-1,v=-1))
plot(gphA2+latticeExtra::as.layer(gphA1), position=c(0, 0, 0.525, 1), more=T)
plot(gphB, position=c(0.52, 0, 1, 1), par.settings=DAAG::DAAGtheme(color=T))

## A7_h
n1 <- BayesFactor::ttest.tstat(qt(0.00001, df=40), n1=40, simple=T)
n2 <- BayesFactor::ttest.tstat(qt(0.000001, df=40), n1=40, simple=T)

## A7_i
bf1 <- BayesFactor::ttest.tstat(qt(0.00001, df=40), n1=40, simple=T)
bf2 <- BayesFactor::ttest.tstat(qt(0.000001, df=40), n1=40, simple=T)
rbind("Bayes Factors"=setNames(c(bf1,bf2), c("p=0.00001","p=0.000001")),
  "t-statistics"=c(qt(0.00001, df=40), qt(0.000001, df=40))) 

## A7_j
knitr::kable(matrix(c("A bare mention","Positive","Strong","Very strong"), nrow=1),
       col.names=c("1 -- 3", "3 -- 20", "20 -- 150", ">150"), align='c',
      midrule='', vline="")

## A8_1a
tab <- t(as.matrix(DAAG::pair65))
rbind(tab,"heated-ambient"=tab[1,]-tab[2,])

## 1_25
## First of 3 curves; permutation distribution of difference in means
two65 <- DAAG::two65
set.seed(47)        # Repeat curves shown here
nsim <- 2000; dsims <- numeric(nsim)
x <- with(two65, c(ambient, heated))
n <- length(x); n2 <- length(two65$heated)
dbar <- with(two65, mean(heated)-mean(ambient))
for(i in 1:nsim){
  mn <- sample(n,n2,replace=FALSE); dsims[i] <- mean(x[mn]) - mean(x[-mn]) }
plot(density(dsims), xlab="", main="", lwd=0.5, yaxs="i", ylim=c(0,0.08), bty="n")
abline(v=c(dbar, -dbar), lty=3)
pval1 <- (sum(dsims >= abs(dbar)) + sum (dsims <= -abs(dbar)))/nsim
mtext(side=3,line=0.25,
  text=expression(bar(italic(x))[2]-bar(italic(x))[1]), at=dbar)
mtext(side=3,line=0.25,
  text=expression(-(bar(italic(x))[2] - bar(italic(x))[1])), at=-dbar)
## Second permutation density
for(i in 1:nsim){
mn <- sample(n,n2,replace=FALSE)
dsims[i] <- mean(x[mn]) - mean(x[-mn])
}
pval2 <- (sum(dsims >= abs(dbar)) + sum (dsims <= -abs(dbar)))/nsim
lines(density(dsims),lty=2,lwd=1)
## Third permutation density
for(i in 1:nsim){
mn <- sample(n,n2,replace=FALSE)
dsims[i] <- mean(x[mn]) - mean(x[-mn])
}
pval3 <- (sum(dsims >= abs(dbar)) + sum (dsims <= -abs(dbar)))/nsim
lines(density(dsims),lty=3,lwd=1.25)
box(col="gray")
leg3 <- paste(c(pval1,pval2,pval3))
legend(x=20, y=0.078, title="P-values are", cex=1, xpd=TRUE,
  bty="n", lty=c(1,2,3), lwd=c(1,1,1,1.25), legend=leg3, y.intersp=0.8)

## A8_3a
## Bootstrap estimate of median of wren length: data frame cuckoos
wren <- subset(DAAG::cuckoos, species=="wren")[, "length"]
library(boot)
## First define median.fun(), with two required arguments:
##         data specifies the data vector,
##         indices selects vector elements for each resample
median.fun <- function(data, indices){median(data[indices])}
## Call boot(), with statistic=median.fun, R = # of resamples
set.seed(23)
(wren.boot <- boot(data = wren, statistic = median.fun, R = 4999))

## A8_4a
## Call the function boot.ci() , with boot.out=wren.boot
boot.ci(boot.out=wren.boot, type=c("perc","bca"))

## A8_4b
## Bootstrap estimate of 95% CI for `cor(chest, belly)`: `DAAG::possum`
corr.fun <- function(data, indices) 
  with(data, cor(belly[indices], chest[indices]))
set.seed(29)
corr.boot <- boot(DAAG::possum, corr.fun, R=9999)

## A8_4c
library(boot)
boot.ci(boot.out = corr.boot, type = c("perc", "bca"))

## A10_4
Animals <- MASS::Animals
manyMals <- rbind(Animals, sqrt(Animals), Animals^0.1, log(Animals))
manyMals$transgp <- rep(c("Untransformed", "Square root transform",
  "Power transform, lambda=0.1", "log transform"),
rep(nrow(Animals),4))
manyMals$transgp <- with(manyMals, factor(transgp, levels=unique(transgp)))
lattice::xyplot(brain~body|transgp, data=manyMals,
  scales=list(relation='free'), layout=c(2,2))

## A10_5
with(Animals, c(cor(brain,body), cor(brain,body, method="spearman")))
with(Animals, c(cor(log(brain),log(body)),
  cor(log(brain),log(body), method="spearman")))

## A10_9
usableDF <- DAAG::cuckoohosts[c(1:6,8),]
nr <- nrow(usableDF)
with(usableDF, {
  plot(c(clength, hlength), c(cbreadth, hbreadth), col=rep(1:2,c(nr,nr)))
  for(i in 1:nr)lines(c(clength[i], hlength[i]), c(cbreadth[i], hbreadth[i]))
  text(hlength, hbreadth, abbreviate(rownames(usableDF),8), pos=c(2,4,2,1,2,4,2))
})

## A10_10
## Take a random sample of 100 values from the normal distribution
x <- rnorm(100, mean=3, sd=5)
(xbar <- mean(x))
## Plot, against `xbar`, the sum of squared deviations from `xbar`
lsfun <- function(xbar) apply(outer(x, xbar, "-")^2, 2, sum)
curve(lsfun, from=xbar-0.01, to=xbar+0.01)

## A10_11
boxplot(avs, meds, horizontal=T)

## A10_15
x <- rpois(7, 78.3)
mean(x); var(x)

## A10_16
nvals100 <- rnorm(100)
heavytail <- rt(100, df = 4)
veryheavytail <- rt(100, df = 2)
boxplot(nvals100, heavytail, veryheavytail, horizontal=TRUE)

## A10_19
boxdists <- function(n=1000, times=10){
  df <- data.frame(normal=rnorm(n*times), t=rt(n*times, 7),
  sampnum <- rep(1:times, rep(n,times)))
  lattice::bwplot(sampnum ~ normal+t, data=df, outer=TRUE, xlab="", 
                  horizontal=T)
}

## A10_20
a <- 1
form <- ~rchisq(1000,1)^a+rchisq(1000,25)^a+rchisq(1000,500)^a
lattice::qqmath(form, scales=list(relation="free"), outer=TRUE)

## A10_21
y <- rnorm(51)
ydep <- y1[-1] + y1[-51]
acf(y)      # acf plots `autocorrelation function'(see Chapter 6)
acf(ydep)

## A10_24
ptFun <- function(x,N)pt(sqrt(N)*mean(x)/sd(x), df=N-1, lower.tail=FALSE)
simStat <- function(eff=.4, N=10, nrep=200, FUN)
    array(rnorm(n=N*nrep*length(eff), mean=eff), dim=c(length(eff),nrep,N)) |>
      apply(2:1, FUN, N=N) 
pval <- simStat(eff=.4, N=10, nrep=200, FUN=ptFun)
# Suggest a power transform that makes the distribution more symmetric
car::powerTransform(pval)   # See Subsection 2.5.6
labx <- c(0.0001, 0.001, 0.005, 0.01, 0.05, 0.1, 0.25)
bwplot(~I(pval^0.2), scales=list(x=list(at=labx^0.2, labels=paste(labx))),
       xlab=expression("P-value (scale is "*p^{0.2}*")") )

## A10_24a
pvalDF <- subset(df200, effsize==0.4 & N==10)$stat
plot(sort(pval^0.2), sort(pvalDF^0.2))
abline(0,1)

## A10_24c
## Estimated effect sizes: Set `FUN=effFun` in the call to `eff2stat()`
effFun <- function(x,N)mean(x)/sd(x)   
  # Try: `labx <- ((-1):6)/2`; `at = log(labx)`; `v = log(labx)  
## NB also, Bayes Factors: Set `FUN=BFfun` in the call to `eff2stat()`
BFfun <- function(x,N)BayesFactor::ttest.tstat(sqrt(N)*mean(x)/sd(x), n1=N, 
                                               simple=T)
  # A few very large Bayes Factors are likely to dominate the plots

## A10_27
(degC <- setNames(c(21,30,38,46),paste('rep',1:4)) ) 

## A10_27a
radonC <- tidyr::pivot_longer(MPV::radon, names_to='key', 
                              cols=names(degC), values_to='percent')
radonC$temp <- degC[radonC$key]
lattice::xyplot(percent ~ temp|factor(diameter), data = radonC)

## A10_27c
matplot(scale(t(MPV::radon[,-1])), type="l", ylab="scaled residuals")  

## A10_27d
radon.res <- aggregate(percent ~ diameter, data = radonC, FUN = scale, 
    scale = FALSE)

## A10_30
diamonds <- ggplot2::diamonds
with(diamonds, plot(carat, price, pch=16, cex=0.25))
with(diamonds, smoothScatter(carat, price))

## A10_31a
t2bfInterval <- function(t, n=10, rscale="medium", mu=c(-.1,.1)){
     null0 <- BayesFactor::ttest.tstat(t=t, n1=n, nullInterval=mu,
                                       rscale=rscale,simple=TRUE)
alt0 <- BayesFactor::ttest.tstat(t=t, n1=n, nullInterval=mu, rscale=rscale, 
                                 complement=TRUE, simple=TRUE)
alt0/null0
}

## A10_31b
pval <- c(0.05,0.01,0.001); nval <- c(10,40,160)
bfDF <- expand.grid(p=pval, n=nval)
pcol <- 1; ncol <- 2; tcol <- 3
bfDF[,'t'] <- apply(bfDF,1,function(x){qt(x[pcol]/2, df=x[ncol]-1,                                  lower.tail=FALSE)})
other <- apply(bfDF,1,function(x)
    c(BayesFactor::ttest.tstat(t=x[tcol], n1=x[ncol], rscale="medium",
                               simple=TRUE),
      BayesFactor::ttest.tstat(t=x[tcol], n1=x[ncol], rscale="wide",
                               simple=TRUE),
## Now specify a null interval
    t2bfInterval(t=x[tcol], n=x[ncol], mu=c(-0.1,0.1),rscale="medium"),
    t2bfInterval(t=x[tcol], n=x[ncol], mu=c(-0.1,0.1),rscale="wide")
  ))
bfDF <- setNames(cbind(bfDF, t(other)),
    c('p','n','t','bf','bfInterval'))

## A10_32
df <- data.frame(d = with(datasets::sleep, extra[group==2] - extra[group==1]))
library(statsr)
BayesFactor::ttestBF(df$d, rscale=1/sqrt(2))   # Or, `rscale="medium"`
  # `rscale="medium"` is the default
bayes_inference(d, type='ht', data=df, statistic='mean', method='t', rscale=1/sqrt(2),
                alternative='twosided', null=0, prior_family = "JZS")
  # Set `rscale=1/sqrt(2)` (default is 1.0) 
  # as for BayesFactor; gives same BF
# Compare with `prior_family = "JUI"` (`"JZS"` is the default), 
# with (if not supplied) default settings
bayes_inference(d, type='ht', data=df, statistic='mean', method='t',
                alternative='twosided', null=0, prior_family = "JUI")

## unnamed-chunk-1
if(file.exists("/Users/johnm1/pkgs/PGRcode/inst/doc/")){
code <- knitr::knit_code$get()
txt <- paste0("\n## ", names(code),"\n", sapply(code, paste, collapse='\n'))
writeLines(txt, con="/Users/johnm1/pkgs/PGRcode/inst/doc/ch1.R")
}
