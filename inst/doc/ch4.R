
## CodeControl
options(rmarkdown.html_vignette.check_title = FALSE)
## xtras=FALSE
xtras <- F
library(knitr)
## opts_chunk[['set']](results="asis")
## opts_chunk[['set']](eval=T)
opts_chunk[['set']](eval=F)

## setup
Hmisc::knitrSet(basename="exploit", lang='markdown', fig.path="figs/g", w=7, h=7)
oldopt <- options(digits=4, width=70, scipen=999)
library(knitr)
## knitr::render_listings()
opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.align="center", 
                    fig.show='hold', formatR.arrow=FALSE, ps=10, 
                    strip.white = TRUE, comment=NA, width=70, 
                    tidy.opts = list(replace.assign=FALSE))

## D1_1a
sugar <- DAAG::sugar  # Copy dataset 'sugar' into the workspace
## Ensure that "Control" is the first level
sugar[["trt"]] <- relevel(sugar[["trt"]], ref="Control")
options()[["contrasts"]]  # Check the default factor contrasts
## If your output does not agree with the above, then enter
## options(contrasts=c("contr.treatment", "contr.poly"))

## 4.1
gph <- lattice::stripplot(trt ~ weight, pch=4, data=sugar,
  xlab=list("Weight (mg)", cex=0.9))
  bw10 <- list(fontsize=list(text=10, points=5))
update(gph, aspect=0.5, par.settings=bw10)

## D1_1c
sugar.aov <- aov(weight ~ trt, data=sugar)
## To display the model matrix, enter: model.matrix(sugar.aov)
## Note the use of summary.lm(), not summary() or summary.aov()
round(signif(coef(summary.lm(sugar.aov)), 3), 4)

## D1_1d
sem <- summary.lm(sugar.aov)$sigma/sqrt(3)  # 3 results/trt
# Alternatively, sem <- 6.33/sqrt(2)
qtukey(p=.95, nmeans=4, df=8) * sem

## D1_2a
contrasts(sugar$trt) <- 'contr.sum'
sugarSum.aov <- aov(weight ~ trt, data = sugar)
round(signif(coef(summary.lm(sugarSum.aov)), 3),4)

## D1_2b
dummy.coef(sugarSum.aov)

## D1_2c
contrasts(sugar$trt) <- "contr.sum"

## D1_2d
fish <- factor(1:3, labels=c("Trout","Cod","Perch"))

## D1_2e
contr.treatment(fish)
# Base is "Trout"

## D1_2f
contr.SAS(fish)
# Base is "Perch"

## D1_2g
contr.sum(fish)
# Base is mean of levels

## D2_1a
rice <- DAAG::rice
ricebl.aov <- aov(ShootDryMass ~ Block + variety * fert, data=rice)
print(summary(ricebl.aov), digits=3)

## D2_1b
round(signif(coef(summary.lm(ricebl.aov)), 3), 5)
with(summary.lm(ricebl.aov),
cat("Residual standard error: ", sigma, "on", df[2], "degrees of freedom"))

## D2_1c
## AOV calculations, ignoring block effects
rice.aov <- aov(ShootDryMass ~ variety * fert, data=rice)
summary.lm(rice.aov)$sigma

## D2_1d
ricebl.aov <- aov(ShootDryMass ~ factor(Block) + variety * fert, data=rice)

## D2_1e
model.tables(ricebl.aov, type="means", se=TRUE, cterms="variety:fert")

## D2_2a
appletaste <- DAAG::appletaste
with(appletaste, table(product, panelist))

## D2_2b
sapply(appletaste, is.factor)  # panelist & product are factors
appletaste.aov <- aov(aftertaste ~ product + panelist, data=appletaste)
summary(appletaste.aov)

## 4_2
termplot(appletaste.aov, partial=TRUE, col.res="black", fg='gray',
         cex=0.8, mgp=c(1.5,0.4,0))
 # Specify `partial=TRUE` to show partial residuals

## D2_2e
as.data.frame(effects::Effect("product", appletaste.aov, confidence.level=0.95))

## D2_2f
## NB that 'product' was first term in the model formula
## Thus, the 1st 4 coefficients have the information required
coef(summary.lm(appletaste.aov))[1:4, ]

## D3a
## Fit various models to columns of data frame leaftemp (DAAG)
leaftemp <- DAAG::leaftemp
leaf.lm1 <- lm(tempDiff ~ 1 , data = leaftemp)
leaf.lm2 <- lm(tempDiff ~ vapPress, data = leaftemp)
leaf.lm3 <- lm(tempDiff ~ CO2level + vapPress, data = leaftemp)
leaf.lm4 <- lm(tempDiff ~ CO2level + vapPress +
               vapPress:CO2level, data = leaftemp)

## D3b
anova(leaf.lm1, leaf.lm2, leaf.lm3, leaf.lm4)

## 4_3
options(contrasts = c("contr.treatment", "contr.poly"))
cex.eq <- 0.85
yran <- with(leaftemp, range(tempDiff))
yran[2] <- yran[2] + diff(yran) * 0.08
par(fig=c(0, 0.39, 0, 0.9))
plot(tempDiff~vapPress, xlab = "Vapour Pressure", data=leaftemp,
ylab = "Temperature difference", ylim = yran, fg="gray", tcl=-0.25,
pch = as.numeric(CO2level), cex=0.5, cex.axis=0.8, col="black")
mtext(side = 3, line = 1.5, "A: Single line", adj = 0, cex=1.15)
topleft <- par()$usr[c(1, 4)] + c(cex.eq, -cex.eq) * par()$cxy
chh <- par()$cxy[2]*0.5
ab1 <- leaf.lm2$coef
mtext(side=3,line=0.72,
paste("tempDiff =", round(ab1[1], 2), round(ab1[2], 2),
" x vapPress",sep = ""), adj=0, col="black", cex=cex.eq)
abline(ab1[1], ab1[2])
par(fig=c(0.3, 0.69, 0, 0.9), new=T)
plot(tempDiff~vapPress, data=leaftemp, xlab = "Vapour Pressure",
ylab = "", ylim = yran, pch = as.numeric(CO2level), tcl=-0.25,
cex=0.5, cex.axis=0.8, fg="gray")
mtext(side = 3, line = 1.5, "B: Parallel lines", adj = 0, cex=1.15)
a123 <- c(leaf.lm3$coef[1], sum(leaf.lm3$coef[1:2]),
sum(leaf.lm3$coef[c(1,3)]))
b1 <- leaf.lm3$coef[4]
mtext(side=3,line=.72,
paste("Intercepts are:", paste(round(a123,2), collapse=", ")),
adj = 0, col = "black", cex = cex.eq)
mtext(side=3,line=0, paste("Slope is:", round(b1, 2), sep = " "),
adj = 0, col = "black", cex = cex.eq)
ran <- with(leaftemp, sapply(split(vapPress, CO2level), range))
for(i in 1:3){
yi <- a123[i] + b1 * ran[,i]
lines(ran[,i], yi, lty = c(4,5,7)[i], lwd = 1, col = "black")
}
par(fig=c(0.6, 0.99, 0, 0.9), new=T)
plot(tempDiff~vapPress, data=leaftemp, xlab = "Vapour Pressure",
ylab = "",  ylim = yran,  pch = as.numeric(CO2level), tcl=-0.25,
cex=0.5, cex.axis=0.8, fg="gray")
mtext(side = 3, line = 1.5, "C: Separate lines", adj = 0, cex=1.15)
a123 <- c(leaf.lm4$coef[1], sum(leaf.lm4$coef[1:2]),
sum(leaf.lm4$coef[c(1,3)]))
b123 <- c(leaf.lm4$coef[4], sum(leaf.lm4$coef[4:5]),
sum(leaf.lm4$coef[c(4,6)]))
mtext(side=3,line=.72,
paste("Intercepts are:", paste(round(a123,2), collapse=", ")),
adj = 0, col = "black", cex = cex.eq)
mtext(side=3,line=0,
paste("Slopes are:", paste(round(b123,2), collapse=", ")),
adj=0, cex=cex.eq)
for(i in 1:3){
a <- a123[i]
yi <- a123[i] + b123[i] * ran[,i]
lines(ran[,i], yi, lty = c(4,5,7)[i], lwd = 1, col = "black")
}
par(fig=c(0, 1, 0, 1),new=T, mar=rep(0,4))
plot(0:1, 0:1, bty="n", axes=F, xlab="", ylab="", type="n")
legend(0.55, 0.985, legend=c("low","medium","high"), lty=c(4,5,7), col="black",
pch=1:3, xjust=0.5, yjust=1, bty="n", pt.cex=0.72, ncol=3,
text.width=0.1, cex=0.85)

## 4_4
plot(leaf.lm3, cook.levels=0.12, caption=c('A: Resids vs Fitted', 'B: Normal Q-Q',
'C: Scale-Location', '', 'D: Resids vs Leverage'), cex.caption=0.85, fg="gray")

## D3e
print(coef(summary(leaf.lm3)), digits=2)

## D4_1a
seedrates <- DAAG::seedrates
form2 <- grain ~ rate + I(rate^2)
# Without the wrapper function I(), rate^2 would be interpreted
# as the model formula term rate:rate, and hence as rate.
quad.lm2 <- lm(form2, data = seedrates)
## Alternative, using gam()
## quad.gam <- mgcv::gam(form2, data = seedrates)

## D4_1b
suppressPackageStartupMessages(library(ggplot2))

## 4_5
## Use ggplot2 functions to plot points, line, curve, & 95% CIs
## library(ggplot2)
gph <- ggplot(DAAG::seedrates, aes(rate,grain))+
  geom_point(aes(size=3), color='magenta')+xlim(c(25,185))
colors <- c("Linear"="blue", "Quadratic"="red")
ggdat <- ggplot_build(gph+geom_smooth(aes(rate,grain,color="Linear"),
  method=lm, formula=y~poly(x,2),fullrange=TRUE))$data[[2]]
gph1 <- gph+geom_smooth(aes(color="Linear"), method=lm, formula=y~x, fullrange=TRUE, fill='dodgerblue')
gph1 +  geom_line(data = ggdat, aes(x = x, y = y, color="Quadratic"),
                  linewidth=0.75)+
  geom_ribbon(data=ggdat, aes(x=x,y=y, ymin=ymin, ymax=ymax,
                              color="Quadratic"), linewidth=0.75,
  fill=NA, linetype=2, outline.type='both', show.legend=FALSE) +
  scale_color_manual(values=colors, aesthetics = "color")+
  theme(legend.position=c(.8,.78)) +
  coord_cartesian(expand=FALSE) + xlab("Seeding rate (kg/ha)") +
    ylab("Grains per head") + labs(color="Model") +
  guides(size='none',
         color = guide_legend(override.aes = list(fill="transparent") ) )
## detach("package:ggplot2")

## D4_1d
quad.lm2 <- lm(grain ~ rate + I(rate^2), data = DAAG::seedrates)
print(coef(summary(quad.lm2)), digits=2)
cat("\nCorrelation matrix\n")
print(summary(quad.lm2, corr=TRUE)$correlation, digits=2)

## D4_1e
seedratesP.lm2 <- lm(grain ~ poly(rate,2), data = seedrates)
print(coef(summary(seedratesP.lm2)), digits=2)

## D4_1f
## Alternative, using mgcv::gam()
seedratesP.gam <- mgcv::gam(grain ~ poly(rate,2), data = seedrates)

## D4_2a
logseed.lm <- lm(log(grain) ~ log(rate), data=DAAG::seedrates)
coef(summary(logseed.lm))

## 4_6
## Use ggplot2 functions to plot points, line, curve, & 95% CIs
## library(ggplot2)
gph <- ggplot(DAAG::seedrates, aes(rate,grain)) +
  geom_point(size=3, color="magenta")+xlim(c(25,185))
colors <- c("Loglinear"="gray40", "Quadratic"="red")
ggdat <- ggplot_build(gph+geom_smooth(method=lm, formula=y~poly(x,2),
                                      fullrange=TRUE))$data[[2]]
ggln <- ggplot_build(gph+geom_smooth(method=lm,
                        formula=log(y)~log(x),fullrange=TRUE))$data[[2]]
## Assign to gphA rather than (as in text) plotting at this point
gphA <- gph +  geom_line(data = ggdat, aes(x = x, y = y, color="Quadratic"),
                 linewidth=0.75) +
geom_ribbon(data=ggdat, aes(x=x,y=y, ymin=ymin, ymax=ymax, color="Quadratic"),
            linewidth=0.75, fill=NA, linetype=2, outline.type='both',
            show.legend=FALSE) +
geom_line(data = ggln, aes(x = x, y = exp(y), color="Loglinear"),
          linewidth = 0.75) +
geom_ribbon(data=ggln, aes(x=x,y=exp(y), ymin=exp(ymin), ymax=exp(ymax),
            color="Loglinear"), fill=NA, linewidth=0.75, linetype=3,
            outline.type='both', show.legend=FALSE)+
  scale_color_manual(values=colors, aesthetics = "color")+
  coord_cartesian(expand=FALSE) +
  xlab("Seeding rate (kg/ha)") + ylab("Grains per head") +
  labs(title="A: Loglinear fit vs quadratic fit", color="Model") +
  guides(size='none',
         color = guide_legend(override.aes = list(fill="transparent") ) ) +
  theme(legend.position=c(.8,.78))
df <- data.frame(rate=rep(DAAG::seedrates$rate,2), res=c(resid(logseed.lm),
  log(DAAG::seedrates$grain)-log(fitted(quad.lm2))),
  Model=rep(c("Loglinear","Quadratic"),rep(nrow(DAAG::seedrates),2)))
## Assign to gphB rather than (as in text) plotting at this point
gphB <- ggplot(df, aes(x=rate, y=res, shape=Model,color=Model))+
geom_point(size=2.5) + scale_color_manual(values=colors) +
xlab("Seeding rate (kg/ha)") + ylab("Residuals on log scale") +
labs(title="B: Residuals") +
  guides(size='none',
         color = guide_legend(override.aes = list(fill="transparent") ) ) +
  theme(legend.position=c(.8,.78))
## Now take advantage of the magic of the 'patchwork' package
library(patchwork)
gphA+gphB
## detach("package:ggplot2")

## D4_2c
aic <- AIC(quad.lm2, logseed.lm)
aic["logseed.lm",2] <- aic["logseed.lm",2] + sum(2*log(seedrates$grain))
round(aic,1)

## D4_3a
seedrates<-DAAG::seedrates
quad.lm2 <- lm(grain ~ poly(rate,degree=2), data=seedrates)
ns.lm2 <- lm(grain ~ splines::ns(rate,df=2), data=seedrates)
tps.gam2 <- mgcv::gam(grain ~ s(rate, k=3, fx=T), data=seedrates)

## D4_3b
mflist <- lapply(list(quad=quad.lm2, nsplines=ns.lm2, tps=tps.gam2), model.matrix)
mftab <- with(mflist, cbind(quad, nsplines, tps))
colnames(mftab) <- c("(Int)", "poly2.1", "poly2.2", "(Int)", "ns2.1", "ns2.2", "(Int)", "s3.1", "s3.2")
library(kableExtra)
linesep = c('', '', '', '\\addlinespace')
kbl(mftab, booktabs=TRUE, format='latex', toprule=FALSE,
format.args=list(justify="right", width=8)) |>
kable_styling(latex_options = c("scale_down",latex_options = "hold_position"), position='center') |>
add_header_above(c('poly(rate,2)' = 3, 'splines::ns(rate,df=2)' = 3, 's(rate, k=3, fx=T)' = 3),
align='c', monospace=rep(T,3))|>
add_header_above(c('lm: grain~' = 3, 'lm: grain~'=3, 'gam: grain~'=3),
                 align='c', monospace=rep(T,3), line=F)

## D4_3c
## Load required packages
suppressPackageStartupMessages(library(splines))
suppressPackageStartupMessages(library(mgcv))

## 4_7
library(mgcv)
fruitohms <- within(DAAG::fruitohms, kohms <- ohms/1000)
## Panel A: 3, 4 and 5 d.f. tprs (cubic spline fits are almost identical)
plot(kohms ~ juice, data=fruitohms, ylim=c(0, max(kohms)*1.1), fg="gray")
ohms.tp3 <- gam(kohms~s(juice, bs="tp", k=3, fx=T), data=fruitohms)
ohms.tp4 <- gam(kohms~s(juice, bs="tp", k=4, fx=T), data=fruitohms)
ohms.tp5 <- gam(kohms~s(juice, k=5, fx=T), data=fruitohms)
lines(fitted(ohms.tp4) ~ juice, data=fruitohms, col=2)
lines(fitted(ohms.tp4) ~ juice, data=fruitohms, col=2, lty=2, lwd=2)
lines(fitted(ohms.tp5) ~ juice, data=fruitohms, col=2, lty=3, lwd=2)
legend("topright", title="Comparison of fits", lty=c(1,2,3), lwd=c(1,2,2), col=c(2,2,2),
cex=0.8, legend=c("s(juice, k=3, fx=TRUE))", "s(juice, k=4, fx=TRUE)",
                   "s(juice, k=5, fx=TRUE)"))
mtext(side=3, line=0.75, "A: 3 vs 4 vs 5 d.f. thin plate spline", adj=0, cex=1.25)
## Panel B: Penalized spline fits
plot(kohms ~ juice, data=fruitohms, ylim=c(0, max(kohms)*1.1),
     ylab=" ", fg="gray")
## Fits with automatic choice of smoothing parameter
ohms.tp <- gam(kohms~s(juice, bs="tp"), data=fruitohms)
ohms.tpML <- gam(kohms ~ s(juice, bs="tp"), data=fruitohms, method="ML")
ohms.tpBIC <- gam(kohms ~ s(juice, bs="tp"), data=fruitohms,
                  gamma=log(nrow(fruitohms))/2, method="ML")
lines(fitted(ohms.tp) ~ juice, data=fruitohms, col=2)
lines(fitted(ohms.tpML) ~ juice, data=fruitohms, col=2, lty=2, lwd=2)
lines(fitted(ohms.tpBIC) ~ juice, data=fruitohms, col=2, lty=3, lwd=2)
legend("topright", title="Penalized regression spline fits", cex=0.8,
legend=c('method="GCV.Cp"','method="ML"', 'gamma=log(n)/2'),
         lty=1:3, col=c(2,2,2), lwd=c(1,2,2))
mtext(side=3, line=0.75, "B: Penalized regression spline fits", adj=0, cex=1.25)

## D4_3e
ohms.tp <- gam(kohms~s(juice, bs="tp"), data=fruitohms)
ohms.cs <- gam(kohms~s(juice, bs="cs"), data=fruitohms)
range(fitted(ohms.tp)-fitted(ohms.cs))

## D4_3f
summary(ohms.tp)

## D4_3g
summary(ohms.tpBIC)

## 4_8
## k=3 gives 3 basis terms; k=4 gives 4 basis terms
ohms.tp3 <- gam(kohms ~ s(juice, k=3), data=fruitohms)
ohms.tp4 <- gam(kohms ~ s(juice, k=4), data=fruitohms)
## Reorder to constant term first, then linear term, then ...
matohmstp3 <- model.matrix(ohms.tp3)[, c(1,3:2)]
matohmstp4 <- model.matrix(ohms.tp4)[, c(1,4:2)]
m <- dim(matohmstp4)[1]
longdf1 <- data.frame(juice=rep(fruitohms[, "juice"],4),
  basis2 = c(as.vector(matohmstp3),rep(NA,m)), basis3 = as.vector(matohmstp4),
  gp = factor(rep(c("Intercept", paste("tpSpline",1:3, sep="")), rep(m,4))))
gph1 <- lattice::xyplot(basis3 ~ juice | gp, data=longdf1, layout=c(1,4),
  ylab="Basis terms", strip=FALSE,
  panel=function(x,y,subscripts){
    lattice::llines(smooth.spline(x,y))
    y2 <- longdf1$basis2[subscripts]
    if(!any(is.na(y2))) lattice::llines(smooth.spline(x,y2),lty=1)},
  outer=TRUE)
  b2 <- coef(lm(kohms ~ 0+matohmstp3, data=fruitohms))
  b3 <- coef(lm(kohms ~ 0+matohmstp4, data=fruitohms))
  spline2 <- as.vector(sweep(matohmstp3, 2, b2, "*"))
  spline3 <- as.vector(sweep(matohmstp4, 2, b3, "*"))
  longdf2 <- data.frame(juice=rep(fruitohms[, "juice"],4),
  spline2 = c(spline2, rep(NA,m)), spline3=spline3,
    gp = factor(rep(c("Intercept", paste("spline",1:3, sep="")), rep(m,4))) )
    ## yran <- range(c(spline2, spline3))
  yran <- c(-6,8.5)
gph2 <- lattice::xyplot(spline3 ~ juice | gp, data=longdf2, layout=c(1,4),
                        scales=list(y=list(at=c(-4, 0, 4,8))), ylim=yran,
  ylab="Add these contributions (kilo-ohms)", strip=FALSE,
  panel=function(x,y,subscripts){
    lattice::llines(smooth.spline(x,y))
    y2 <- longdf2$spline2[subscripts]
    if(!any(is.na(y2)))
      lattice::llines(smooth.spline(x,y2), lty=2, lwd=2, col="red",
                      alpha=0.5)}, outer=TRUE)
maint <- c(A="A: Basis functions, tprs", B="B: Contribution to fitted curve")
bw10 <- list(fontsize=list(text=10, points=5), lty=c(2,2,1,1))
striplabels <- list(
  A=c("Constant","Basis 1","Basis 2","Basis 3"),
  B=c("Constant","Add 1","Add 2","Add 3"))
stripfun <- function(factor.levels)
  lattice::strip.custom(strip.names=TRUE, var.name="", sep=expression(""),
                        factor.levels=factor.levels)
print(update(gph1, par.settings=bw10,
strip.left=stripfun(factor.levels=striplabels[["A"]]),
  main=list(maint["A"], y=-0.5)), position=c(0,0,.5,1))
print(update(gph2, par.settings=bw10,
  strip.left=stripfun(factor.levels=striplabels[["B"]]),
  main=list(maint["B"], y=-0.5)), position=c(.5,0,1,1), newpage=FALSE)

## 4_9
out <- capture.output(gam.check(ohms.tpBIC, tcl=-0.5))

## D4_4c
## Printed output from `gam.check(ohms.tpBIC)`
cat(out, sep="\n")

## 4_10
ohms.scam <- scam::scam(kohms ~ s(juice,bs="mpd"), data=fruitohms)
plot(ohms.scam, resid=T, pch=1, shift=mean(predict(ohms.scam)),
     xlab="Apparent juice content (%)", ylab="Resistance (kohms)",
     fg="gray", shade=T, shade.col=adjustcolor('blue',0.4))
mtext(side=3, line=0.5, "A: Fitted monotone curve", cex=1.25, adj=0)
qqnorm(resid(ohms.scam), fg="gray", main="")
qqline(resid(ohms.scam), col=2)
mtext(side=3, line=0.5, "B: Normal Q-Q plot of residuals", cex=1.25, adj=0)
s2 <- smooth.spline(fruitohms$juice, resid(ohms.scam))
s2p <- update(s2, penalty=log(nrow(fruitohms))/2)
plot(s2$x, s2$yin, fg="gray", xlab="Apparent juice content", ylab="Residual")
lines(s2$x, s2$y, col=2)
lines(s2p$x, s2p$y, col=2, lty=2, lwd=2)
mtext(side=3, line=0.5, "C: Residuals vs ... juice content", cex=1.25, adj=0)

## D4_5b
ohms.scam <- scam::scam(kohms ~ s(juice,bs="mpd"), data=fruitohms)
summary(ohms.scam)

## D4_5
AIC(ohms.scam, ohms.tp)

## D4_5d
BIC(ohms.scam, ohms.tp)

## D4_6a
whiteside <- MASS::whiteside
gas.gam <- gam(Gas ~ Insul+s(Temp, by=Insul), data=whiteside)

## 4_11
library(mgcv)
suppressPackageStartupMessages(library(latticeExtra, quietly=TRUE))
whiteside <- MASS::whiteside
gas.gam <- gam(Gas ~ Insul+s(Temp, by=Insul), data=whiteside)
lims <- range(whiteside$Temp)
lims <- lims+diff(range(lims))*c(-0.04, 0.04)
df2 <- expand.grid(Temp=seq(from=lims[1], to=lims[2], length.out=20),
Insul=factor(unique(levels(whiteside$Insul))))
df2[, c('fit','se')] <- predict(gas.gam, se=TRUE, newdata=df2)
df2 <- within(df2, {low <- fit-2*se; high<-fit+2*se})
parset <- DAAG::DAAGtheme(color=FALSE, pch=c(1,4), cex=1.5)
gph <- xyplot(Gas ~ Temp, data=whiteside, groups=Insul,
  xlab = list("Temperature (degrees Celsius)", cex=1.25),
  ylab = list("Gas usage (1000s of cubic ft", cex=1.25),
  xaxs="i", yaxs="i", aspect = 1,
  auto.key=list(points=TRUE, lines=TRUE, space="right", cex=1.25),
  scales=list(cex=1.0, tck=0.5, xlim = lims, ylim = c(-.3, 1)),
  par.settings=parset,
  main="Gas usage vs temperature, before/after insulation")

my.panel.bands <- function(x, y, upper, lower, fill, col,
subscripts, ..., font, fontface)
{
upper <- upper[subscripts]
lower <- lower[subscripts]
panel.polygon(c(x, rev(x)), c(upper, rev(lower)),
col = fill, border = FALSE,
...)
}
panel2 <- function(x, y, ...){
panel.superpose(x, y, panel.groups = my.panel.bands, type='l',...)
panel.xyplot(x, y, type='l', lwd=2, ...)
}

gph2 <- xyplot(fit~Temp, data=df2, groups=Insul, upper = df2$high, lower = df2$low,
               panel = panel2, fill=adjustcolor('gray40', 0.4), subscripts=T,
               scales=list(cex=1.0, tck=0.5, xlim=lims), par.settings=parset)

update(gph, xlim=lims)+latticeExtra::as.layer(gph2)

## D4_6c
summary(gas.gam)

## D4_6d
Box.test(resid(gas.gam)[whiteside$Insul=='Before'], lag=1)
Box.test(resid(gas.gam)[whiteside$Insul=='After'], lag=1)

## 4_12
## GAM model -- `dewpoint` data
dewpoint <- DAAG::dewpoint
ds.gam <- gam(dewpt ~ s(mintemp) + s(maxtemp), data=dewpoint)
plot(ds.gam, resid=TRUE, pch=".", se=2, cex=2, fg="gray")

## 4_13
library(lattice)
## Residuals vs maxtemp, for different mintemp ranges
mintempRange <- equal.count(dewpoint$mintemp, number=3)
ds.xy <- xyplot(residuals(ds.gam) ~ maxtemp|mintempRange, data=dewpoint,
                layout=c(3,1), scales=list(tck=0.5), aspect=1, cex=0.65,
                par.strip.text=list(cex=0.75), type=c("p","smooth"),
                xlab="Maximum temperature", ylab="Residual")
ds.xy

## D5_1c
## Fit surface
ds.tp <- gam(dewpt ~ s(mintemp, maxtemp), data=DAAG::dewpoint)
vis.gam(ds.tp, plot.type="contour")   # gives a contour plot of the
# fitted regression surface
vis.gam(ds.gam, plot.type="contour")  # cf, model with 2 smooth terms

## D5_2a
hurricNamed <- DAAG::hurricNamed
hurricS.gam <- gam(car::yjPower(deaths, lambda=-0.2) ~
  s(log(BaseDam2014)) + s(LF.PressureMB),
  data=hurricNamed, method="ML")
anova(hurricS.gam)

## 4_14
plot(hurricS.gam, resid=TRUE, pch=16, cex=0.5, select=1, fg="gray")
mtext(side=3, line=1, "A: Term in log(BaseDam2014)", cex=1.0, adj=0, at=-3.75)
plot(hurricS.gam, resid=TRUE, pch=16, cex=0.5, select=2, fg="gray")
mtext(side=3, line=1, "B: Term in LF.PressureMB", cex=1.0, adj=0, at=878)
qqnorm(resid(hurricS.gam), main="", fg="gray")
mtext(side=3, line=1, "C: Q-Q plot of residuals", cex=1.0, adj=0, at=-4.25)

## D5_2c"100%"
hurricSlog1.gam <- gam(log(deaths+1) ~ s(log(BaseDam2014)), data=hurricNamed)
hurricSlog2.gam <- gam(log(deaths+1) ~ s(BaseDam2014), data=hurricNamed)

## 4_15
plot(hurricSlog1.gam, resid=TRUE, pch=16, cex=0.5, adj=0, fg="gray")
mtext(side=3, "A: Use log(BaseDam2014)", cex=1.4, adj=0, line=1, at=-3.15)
plot(hurricSlog2.gam, resid=TRUE, pch=16, cex=0.5, fg="gray")
mtext(side=3, "B: Use BaseDam2014", cex=1.4, adj=0, line=1, at=-28500)

## D5_3a
## If necessary, install the 'WDI' package & download data
if(!file.exists("wdi.RData")){
  if(!is.element("WDI", installed.packages()[,1]) )install.packages("WDI")
inds <- c('SP.DYN.TFRT.IN','SP.DYN.LE00.IN', 'SP.POP.TOTL')
indnams <- c("FertilityRate", "LifeExpectancy", "population")
wdi2020 <- WDI::WDI(country="all", indicator=inds, start=2020, end=2020,
                    extra=TRUE)
wdi2020 <- na.omit(droplevels(subset(wdi2020, !region %in% "Aggregates")))
wdi <- setNames(wdi2020[order(wdi2020[, inds[1]]),inds], indnams)
save(wdi, file="wdi.RData")
}

## D5_3b
load("wdi.RData")  # Needs `wdi.RData` in working directory; see footnote
library(qgam)
wdi[, "ppop"] <- with(wdi, population/sum(population))
wdi[,"logFert"] <- log(wdi[,"FertilityRate"])
form <- LifeExpectancy ~ s(logFert)
## Panel A model
fit.qgam <- qgam(form, data=wdi, qu=.5)
## Panel B: Multiple (10%, 90% quantiles; unweighted, then weighted
fit19.mqgam <- mqgam(form, data=wdi, qu=c(.1,.9))
wtd19.mqgam <- mqgam(form, data=wdi, qu=c(.1,.9),
                      argGam=list(weights=wdi[["ppop"]]))

## D5_3c
hat50 <- cbind(LifeExpectancy=wdi[, "LifeExpectancy"], logFert=wdi[,"logFert"],
                as.data.frame(predict(fit.qgam, se=T)))
hat50 <- within(hat50, {lo <- fit-2*se.fit; hi <- fit+2*se.fit})
hat19 <- as.data.frame(matrix(nrow=nrow(wdi), ncol=4))
for(i in 1:2){hat19[[i]] <- qdo(fit19.mqgam, c(.1,.9)[i], predict)
              hat19[[i+2]] <- qdo(wtd19.mqgam, c(.1,.9)[i], predict) }
  ## NB, can replace `predict` by `plot`, or `summary`
colnames(hat19) <- c(paste0(rep(c('q','qwt'),c(2,2)), rep(c('10','90'),2)))
hat19 <- cbind(hat19, logFert=wdi[,"logFert"])

## 4_16
## Panel A: Fit with SE limits, 50% quantile
gphA <- xyplot(lo+fit+hi~logFert, data=hat50, lty=c(2,1,2),lwd=1.5,type='l') +
  latticeExtra::as.layer(xyplot(LifeExpectancy~logFert,
                                data=hat50, pch='.', cex=2))
## Panel B: Multiple quantiles; unweighted and weighted fits
gph19 <- xyplot(q10+q90+qwt10+qwt90 ~ logFert, type="l",
                data=hat19, lty=rep(1:2,c(2,2)),lwd=1.5)
gphB <- xyplot(LifeExpectancy ~ logFert, data=wdi) + as.layer(gph19)
update(c("A: 50% curve, 2 SE limits"=gphA, "B: 0.1, 0.9 quantiles"=gphB,
         x.same=T, y.same=T), between=list(x=0.5),
       xlab="Fertility Rate", ylab="Life Expectancy",
       scales=list(x=list(at=log(2^((0:5)/2)), labels=round(2^((0:5)/2),1)),
                   alternating=F),
       par.settings=DAAG::DAAGtheme(color=F, col='gray50', cex=2, pch='.'))

## D5_3e
## Plots for the individual quantiles can be obtained thus:
## ## Panel A
plot(fit.qgam, shift=mean(predict(fit.qgam)))
## Panel B, 10% quantile
fitm10 <- qdo(fit19.mqgam, qu=0.1)
plot(fitm10, resid=T, shift=mean(predict(fitm10)),
     ylim=range(wdi$LifeExpectancy), cex=2)
wfitm10 <- qdo(wtd19.mqgam, qu=0.1)
plot(wfitm10, resid=T, shift=mean(predict(wfitm10)),
     ylim=range(wdi$LifeExpectancy), cex=2)

## D7a1
roller.lm <- lm(depression~weight, data=DAAG::roller)
roller.lm2 <- lm(depression~weight+I(weight^2), data=DAAG::roller)

## D7a2
toycars <- DAAG::toycars
lattice::xyplot(distance ~ angle, groups=factor(car), type=c('p','r'),
                data=toycars, auto.key=list(columns=3))

## D7b1
parLines.lm <- lm(distance ~ 0+factor(car)+angle, data=toycars)
sepLines.lm <- lm(distance ~ factor(car)/angle, data=toycars)

## D7b2
sepPol3.lm <- lm(distance ~ factor(car)/angle+poly(angle,3)[,2:3], data=toycars)

## D7b3
sapply(list(parLines.lm, sepLines.lm, sepPol3.lm), AICcmodavg::AICc)

## <<D7b4
setNames(sapply(list(parLines.lm, sepLines.lm, sepPol3.lm),
  function(x)summary(x)$adj.r.squared), c("parLines","sepLines","sepPol3"))

## D7c
seedrates.lm <- lm(grain ~ rate + I(rate^2), data=seedrates)
seedrates.pol <- lm(grain ~ poly(rate,2), data=seedrates)

## D7d1
geo.gam <- gam(thickness ~ s(distance), data=DAAG::geophones)

## D7d2
plot(DAAG::geophones$distance, acf(resid(geo.gam), lag.max=55)$acf)
Box.test(resid(geo.gam), lag=10)
Box.test(resid(geo.gam), lag=20)
Box.test(resid(geo.gam), lag=20, type="Ljung")

## D7e
library(mgcv)
xy <- data.frame(x=1:200, y=arima.sim(list(ar=0.75), n=200))
df.gam <- gam(y ~ s(x), data=xy)
plot(df.gam, residuals=TRUE)

## unnamed-chunk-1
if(file.exists("/Users/johnm1/pkgs/PGRcode/inst/doc/")){
code <- knitr::knit_code$get()
txt <- paste0("\n## ", names(code),"\n", sapply(code, paste, collapse='\n'))
writeLines(txt, con="/Users/johnm1/pkgs/PGRcode/inst/doc/ch4.R")
}
