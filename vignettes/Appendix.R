## ----CodeControl, echo=FALSE---------------------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
xtras=F
library(knitr)
## opts_chunk[['set']](results="asis")
opts_chunk[['set']](eval=F)

## ----setup, cache=FALSE, echo=FALSE--------------------------------------------------------------
#  Hmisc::knitrSet(basename="addNotes", lang='markdown', fig.path="figs/g", w=7, h=7)
#  oldopt <- options(digits=4, formatR.arrow=FALSE, width=70, scipen=999)
#  library(knitr)
#  ## knitr::render_listings()
#  opts_chunk[['set']](cache.path='cache-', out.width="80%", fig.align="center",
#                      fig.show='hold', size="small", ps=10, strip.white = TRUE,
#                      comment=NA, width=70, tidy.opts = list(replace.assign=FALSE))

## ----J1_1a, prompt=TRUE--------------------------------------------------------------------------
#  ## Arithmetic calculations.  See the help page `?Arithmetic`
#  2*3+10            # The symbol `*` denotes 'multiply'

## ----J1_1b, hold=T, prompt=TRUE------------------------------------------------------------------
#  ## Use the `c()` function to join results into a numeric vector
#  c(sqrt(10), 2*3+10, sqrt(10), 2^3)  # 2^3 is 2 to the power of 3
#  ## R knows about pi
#  2*pi*6378         # Approximate circumference of earth at equator (km)

## ----J1_1c---------------------------------------------------------------------------------------
#  ?help              # Get information on the use of `help()`
#  ?sqrt              # Or, type help(sqrt)
#  ?Arithmetic        # See, in similar vein ?Syntax
#  ?'<'               # `?Comparison` finds the same help page

## ----J1_1d---------------------------------------------------------------------------------------
#  ## Two commands on one line; Use ';' as separator
#  2*3*4+10; sqrt(10)        ## Try also `cat(2*3*4+10, sqrt(10), sep='n')
#  ## Convert CO2 carbon emissions from tonnes of carbon to tonnes of CO2
#  3.664*c(.53, 2.56, 9.62)  ## Data are for 1900, 1960 & 2020

## ----J1_1e---------------------------------------------------------------------------------------
#  ## Use `cat()` to print several items, with control of formatting
#  cat(2*3*4+10, sqrt(10), '\n')

## ----J1_1f---------------------------------------------------------------------------------------
#  ## Convert from amounts of carbon to amounts of CO2 (billions of tonnes)
#  ## and assign result to a named object
#  fossilCO2vals <- c(.53, 2.56, 9.62)*3.664  # Amounts in 1900, 1960, and 2020
#    # Equivalently `fossilCO2vals <- c(.53, 2.56, 9.62)*rep(3.664,3)`
#  ## To assign and print, enclose in round brackets
#  (fossilCO2vals <- c(.53, 2.56, 9.62)*3.664)

## ----J1_1g---------------------------------------------------------------------------------------
#  3.664*c(.53,2.56, 9.62) -> fossilCO2vals

## ----10_1, w=3.25, h=2.825, ps=11, mgp=c(2.25,0.5,0), tcl=-0.25, echo=FALSE, out.width="100%", fig.show='hold'----
#  Year <- c(1900, 1920, 1940, 1960, 1980, 2000, 2020)
#  CO2 <- c(.53,.96,1.32,2.56,5.32,6.95,9.62)*3.664
#  ## Now plot Carbon Dioxide emissions as a function of Year
#  plot(CO2 ~ Year, pch=16, fg="gray")

## ----10_1----------------------------------------------------------------------------------------
#  Year <- c(1900, 1920, 1940, 1960, 1980, 2000, 2020)
#  CO2 <- c(.53,.96,1.32,2.56,5.32,6.95,9.62)*3.664
#  ## Now plot Carbon Dioxide emissions as a function of Year
#  plot(CO2 ~ Year, pch=16, fg="gray")

## ----J1_1h---------------------------------------------------------------------------------------
#  CO2byYear <- data.frame(year=Year, co2gas=CO2)
#  CO2byYear         # Display the contents of the data frame.
#  rm(Year, CO2)     # Optionally, remove `Year` and `Carbon` from the workspace
#  plot(co2gas ~ year, data=CO2byYear, pch=16)

## ----J1_1i---------------------------------------------------------------------------------------
#  sqrt(10)           # Number of digits is determined by current seting
#  options(digits=2)  # Change until further notice,
#  sqrt(10)

## ----J2_1a---------------------------------------------------------------------------------------
#  vehicles <- c("Compact", "Large", "Midsize", "Small", "Sporty", "Van")
#  c(T, F, F, F, T, T, F)   # A logical vector, assuming F=FALSE and T=TRUE

## ----J2_1b, echo=T-------------------------------------------------------------------------------
#  ## Character vector
#  mammals <- c("Rat", "Pig", "Rat", "Mouse", "Pig")
#  ## Logical vector
#  rodent <- c("TRUE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
#  ## From character vector `mammals`, create factor
#  mfac <- factor(mammals)
#  levels(mfac)
#  table(mfac)

## ----J2_1c---------------------------------------------------------------------------------------
#  day1 <- as.Date(c("2022-01-01", "2022-02-01", "2022-03-01"))
#  as.numeric(day1)   # Days since 1 January 1970
#  day1[3] - day1[2]

## ----J2_1d---------------------------------------------------------------------------------------
#  ## Specify the indices of the elements that are to be extracted
#  x <- c(3, 11, 8, 15, 12,18)
#  x[c(1,4:6)]        # Elements in positions 1, 4, 5, and 6
#  ## Use negative indices to identify elements for omission
#  x[-c(2,3)]         # Positive and negative indices cannot be mixed
#  ## Specify a vector of logical values.
#  x > 10             # This generates a vector of logical values
#  x[x > 10]

## ----J2_1e---------------------------------------------------------------------------------------
#  bodywt <- c(Cow=465, Goat=28, Donkey=187, Pig=192)
#  bodywt[c("Goat", "Pig")]

## ----J2_4c---------------------------------------------------------------------------------------
#  arr123 <- array(1:24, dim=c(2,4,3))
#  ## This prints as three 2 by 4 matrices.  Print just the first of the three.
#  arr123[, 2, 1]     # Column 2 and index 1 of 3rd dimension
#  attributes(arr123)

## ----J2_2a---------------------------------------------------------------------------------------
#  gender <- c(rep("male",691), rep("female",692))
#  gender <- factor(gender)  # From character vector, create factor
#  levels(gender)            # Notice that `female` comes first

## ----J2_2b---------------------------------------------------------------------------------------
#  Gender <- factor(gender, levels=c("male", "female"))

## ----J2_2c---------------------------------------------------------------------------------------
#  mf1 <- factor(rep(c('male','female'),c(2,3)), labels=c("f", "m"))
#  ## The following has the same result
#  mf2 <- factor(rep(c('male','female'), c(2,3)))
#  levels(mf2) <- c("f","m")   # Assign new levels
#  if(all(mf1==mf2))print(mf1)

## ----J2_2d---------------------------------------------------------------------------------------
#  sum(gender=="male")

## ----J2_2e---------------------------------------------------------------------------------------
#  table(chickwts$feed)  # feed is a factor
#  source <- chickwts$feed
#  levels(source) <- c("milk","plant","plant","meat","plant","plant")
#  table(source)

## ----J2_2f---------------------------------------------------------------------------------------
#  stress <- rep(c("low","medium","high"), 2)
#  ord.stress <- ordered(stress, levels=c("low", "medium", "high"))
#  ord.stress
#  ord.stress >= "medium"

## ----J2_5a---------------------------------------------------------------------------------------
#  Cars93sum <- DAAG::Cars93.summary  # Create copy in workspace
#  Cars93sum

## ----J2_5b---------------------------------------------------------------------------------------
#  Cars93sum[4:6, 2:3]   # Extract rows 4 to 6 and columns 2 and 3
#  Cars93sum[6:4, ]      # Extract rows in the order 6, 5, 4
#  Cars93sum[, 2:3]      # Extract columns 2 and 3
#  ## Or, use negative integers to specify rows and/or columns to be omitted
#  Cars93sum[-(1:3), -c(1,4)]  # In each case, numbers must be all +ve or all -ve
#  ## Specify row and/or column names
#  Cars93sum[c("Small","Sporty","Van"), c("Max.passengers","No.of.cars")]

## ----J2_5c---------------------------------------------------------------------------------------
#  names(Cars93sum)[3] <- "numCars"
#  names(Cars9sum) <- c("minPass","maxPass","numCars","code")

## ----J2_5d---------------------------------------------------------------------------------------
#  ## trees (datasets) has data on Black Cherry Trees
#  with(trees, round(c(mean(Girth), median(Girth), sd(Girth)),1))

## ----J2_5e---------------------------------------------------------------------------------------
#  with(DAAG::pair65,       # stretch of rubber bands
#    {lenchange = heated-ambient
#     c(mean(lenchange), median(lenchange))
#  })

## ----J2_5f, eval=F-------------------------------------------------------------------------------
#  ## Add variables `mph` and `gradient` to `DAAG::nihills`
#  nihr <- within(DAAG::nihills, {mph <- dist/time; gradient <- climb/dist})

## ----J2_5g---------------------------------------------------------------------------------------
#  unlist(Cars93sum[1, ])

## ----J2_5h---------------------------------------------------------------------------------------
#  ## For columns of `DAAG::jobs`, show the range of values
#  sapply(DAAG::jobs, range)
#  ## Split egg lengths by species, calculate mean, sd, and number for each
#  with(DAAG::cuckoos, sapply(split(length,species),
#                             function(x)c(av=mean(x), sd=sd(x), nobs=length(x))))

## ----J2_5i---------------------------------------------------------------------------------------
#  apply(UCBAdmissions, 3, function(x)(x[1,2]/(x[1,2]+x[2,2]))*100) # Females
#  apply(UCBAdmissions, 3, function(x)(x[1,1]/(x[1,1]+x[2,1]))*100) # Males

## ----J2_5j---------------------------------------------------------------------------------------
#  UCBAdmissions[, , 1]

## ----J2_5k---------------------------------------------------------------------------------------
#  DAAG::cricketer |> dplyr::count(year, left, name="Freq") -> handYear
#  names(handYear)[2] <- "hand"
#  byYear <- tidyr::pivot_wider(handYear, names_from='hand', values_from="Freq")

## ----J2_6a---------------------------------------------------------------------------------------
#  CO2byYear <- data.frame(year = seq(from=1900, to=2020, by=20),
#                          co2gas = c(1.94, 3.52, 4.84, 9.38, 19.49, 25.46, 35.25))
#  write.table(CO2byYear, file='gas.txt')    # Write data frame to file
#  CO2byYear <- read.table(file="gas.txt")   # Read data back in
#  write.csv(CO2byYear, file='gas.csv')                  # Write data frame
#  CO2byYear <- read.csv(file="gas.csv", row.names=1)    # Read data back in

## ----J2_7a---------------------------------------------------------------------------------------
#  sites <- DAAG::possumsites    # sites is then a data frame
#  sites[,3]                     # returns a vector
#  sites[,3, drop=FALSE]         # returns a 1-column data frame

## ----J2_7b---------------------------------------------------------------------------------------
#  dplyr::as_tibble(sites)[,3]   # returns a 1-column tibble
#  dplyr::as_tibble(sites)[[3]]  # returns a vector
#  sites[[3]]                    # returns a vector

## ----J2_7c---------------------------------------------------------------------------------------
#  attributes(DAAG::possumsites)[['row.names']]

## ----J2_7e---------------------------------------------------------------------------------------
#  possumSites <- tibble::as_tibble(DAAG::possumsites, rownames="Site")
#  possumSites

## ----J2_8a---------------------------------------------------------------------------------------
#  ## Summary statistics for 31 felled black cherry tree
#  ## Median (middle value), range, number, units
#  htstats <- list(med=76, range=c(low=63,high=87), n=31, units="ft")
#  htstats[1:2]       # Show first two list elements only

## ----J2_8b---------------------------------------------------------------------------------------
#  ## The following are alternative ways to extract the second list element
#  htstats[2]          # First list element (Can replace `2` by 'range')
#  htstats[2][1]       # A subset of a list is a list

## ----J2_8c---------------------------------------------------------------------------------------
#  htstats[[2]]; htstats$range; htstats[["range"]]

## ----J2_8d, echo=FALSE---------------------------------------------------------------------------
#  htstats[[2]];

## ----J2_8e---------------------------------------------------------------------------------------
#  unlist(htstats[2])  # Contents of second list element, with composite names
#  unlist(htstats[2], use.names=F)   # Elements have no names

## ----J2_8f---------------------------------------------------------------------------------------
#  tstats <- with(MASS::shoes, t.test(B, A, paired=TRUE))
#  names(tstats)        ## Names of list elements. See `?t.test` for details.
#  tstats[1]            ## Type tstats[1] to see the first list element
#  ## Compact listing of contents list elements 1 to 5, which are all numeric
#  unlist(tstats[1:5])  ## With `unlist(tstats)` all elements become character

## ----J3_1a---------------------------------------------------------------------------------------
#  ## Data indices
#  length()       # number of elements in a vector or a list
#  order()        # x[order(x)] sorts x (by default, NAs are last)
#  which()        # which indices of a logical vector are `TRUE`
#  which.max()    # locates (first) maximum (NB, also: `which.min()`)

## ----J3_1b---------------------------------------------------------------------------------------
#  ## Data manipulation
#  c()            # join together (`concatenate`) elements or vectors or lists
#  diff()         # vector of first differences
#  sort()         # sort elements into order, by default omitting NAs
#  rev()          # reverse the order of vector elements
#  t()            # transpose matrix or data frame
#                 # (a data frame is first coerced to a matrixwith()
#  with()         # do computation using columns of specified data frame

## ----J3_1c---------------------------------------------------------------------------------------
#  ## Data summary
#  mean()         # mean of the elements of a vector
#  median()       # median of the elements of a vector
#  range()        # minimum and maximum value elements of vector
#  unique()       # form the vector of distinct values
#  ## List function arguments
#  args()         # information on the arguments to a function

## ----J3_1d---------------------------------------------------------------------------------------
#  ## Obtain details
#  head()         # display first few rows (by default 6) of object
#  ls()           # list names of objects in the workspace

## ----J3_1e---------------------------------------------------------------------------------------
#  ## Print multiple objects
#  cat()          # prints multiple objects, one after the other

## ----J3_1f---------------------------------------------------------------------------------------
#  ## Functions that return TRUE or FALSE?
#  all()          # returns TRUE if all values are TRUE
#  any()          # returns TRUE if any values are TRUE
#  is.factor()    # returns TRUE if the argument is a factor
#  is.na()        # returns TRUE if the argument is an NA
#                 # NB also is.logical(), etc.

## ----J3_2e, hold=TRUE----------------------------------------------------------------------------
#  seq(from =1, by=2, length.out=3)  # Unabbeviated arguments
#  seq(from =1, by=2, length=3)      # Abbreviate `length.out` to `length`

## ----J3_2a, echo=FALSE---------------------------------------------------------------------------
#  mean.and.sd <- function(x){
#      av <- mean(x)
#      sdev <- sd(x)
#      c(mean=av, SD=sdev)   # Return value (here, a numeric vector of length 2)
#      }

## ----J3_2b---------------------------------------------------------------------------------------
#  distance <- c(148,182,173,166,109,141,166)
#  mean.and.sd(distance)

## ----J3_2c---------------------------------------------------------------------------------------
#  ## Execute the function with the  default argument:
#  mean.and.sd()

## ----J3_2d---------------------------------------------------------------------------------------
#  ## Thus, to return the mean, SD and name of the input vector
#  ## replace c(mean=av, SD=sdev) by
#  list(mean=av, SD=sdev, dataset = deparse(substitute(x)))

## ----J3_3a---------------------------------------------------------------------------------------
#  mean(rnorm(20, sd=2))
#  20 |> rnorm(sd=2) |> mean()

## ----J3_3b---------------------------------------------------------------------------------------
#  logmammals <- MASS::mammals |> log() |> setNames(c("logbody","logbrain"))
#  ## Alternatively, use the ability to reverse the assignment operator.
#  MASS::mammals |> log() |> setNames(c("logbody","logbrain")) -> logmammals
#    ## This last is more in the spirit of pipes.

## ----J3_3c---------------------------------------------------------------------------------------
#  MASS::mammals |>
#    log() |>
#    setNames(c("logbody","logbrain")) |>
#    (\(d)lm(logbrain ~ logbody, data=d))() |>
#    coef()

## ----J3_e4a--------------------------------------------------------------------------------------
#  ## Multiple of divisor that leaves smallest non-negative remainder
#  c("Multiple of divisor" = 24 %/% 9, "Remainder after division" = 6)

## ----J4_1b---------------------------------------------------------------------------------------
#  x <- 1:6
#  log(x)                 # Natural logarithm of 1, 2, ... 6
#  log(x, base=10)        # Common logarithm (base 10)
#  log(64, base=c(2,10))  # Apply different bases to one number
#  log(matrix(1:6, nrow=2), base=2)  # Take logarithms of all matrix elements

## ----J4_1c---------------------------------------------------------------------------------------
#  seq(from=5, to=22, by=3)  # The first value is 5.
#  rep(c(2,3,5), 4)          #  Repeat the sequence (2, 3, 5) four times over
#  rep(c("female", "male"), c(2,3))    # Use syntax with a character vector

## ----J4_2a---------------------------------------------------------------------------------------
#  nbranch <- subset(DAAG::rainforest, species=="Acacia mabellae")$branch
#  nbranch            # Number of small branches (2cm or less)

## ----J4_2b---------------------------------------------------------------------------------------
#  mean(nbranch, na.rm=TRUE)

## ----J4_2c---------------------------------------------------------------------------------------
#  nbranch == NA      # This always equals `NA`

## ----J4_2d---------------------------------------------------------------------------------------
#  is.na(nbranch)    # Use to check for NAs

## ----J4_2e---------------------------------------------------------------------------------------
#  nbranch[is.na(nbranch)] <- -999
#    # `mean(nbranch)` will then be a nonsense value

## ----J4_2g---------------------------------------------------------------------------------------
#  options()$na.action # Version 3.2.2, following startup

## ----J4_2f---------------------------------------------------------------------------------------
#  with(DAAG::nswdemo, table(trt, re74>0, useNA="ifany"))

## ----J4_4a---------------------------------------------------------------------------------------
#  summary(DAAG::primates)

## ----J4_4b---------------------------------------------------------------------------------------
#  primates <- DAAG::primates

## ----J4_4d, eval=F-------------------------------------------------------------------------------
#  gplots::plotCI()    # `plotCI() function in package `gplots`
#  plotrix::plotCI()   # `plotCI() function in package `plotrix`

## ----J4_4e---------------------------------------------------------------------------------------
#  sessionInfo()[['basePkgs']]

## ----J4_4f---------------------------------------------------------------------------------------
#  ## List just the workspace and the first eight packages on the search list:
#  search()[1:9]

## ----J4_4g---------------------------------------------------------------------------------------
#  data(package="datasets")

## ----J5_1a, eval=xtras, w=5.5, fig.asp=0.9, top=2, out.width="60"--------------------------------
#  grog <- DAAG::grog
#  chr <- with(grog, match(Country, c('Australia', 'NewZealand')))
#    # Australia: 1; matches 1st element of c('Australia', 'NewZealand')
#    # NewZealand: 2; matches 2nd element
#  plot(Beer ~ Year, data=grog, ylim=c(0, max(Beer)*1.1), pch = chr)
#  with(grog, points(Wine ~ Year, pch=chr, col='red'))
#  legend("bottomright", legend=c("Australia", "New Zealand"), pch=1:2)
#  title(main="Beer consumption (l, pure alcohol)", line=1)

## ----J5_1b, eval=xtras, w=5.5, fig.asp=0.9, out.width="60"---------------------------------------
#  library(latticeExtra)    ## Loads both lattice and the add-on latticeExtra
#  gph <- xyplot(Beer+Wine ~ Year, groups=Country, data=grog)
#  update(gph, par.settings=simpleTheme(pch=19), auto.key=list(columns=2))

## ----J5_1c, eval=xtras, w=5.5, fig.asp=0.8, out.width="100%"-------------------------------------
#  ## Or, condition on `Country`
#  xyplot(Beer+Wine+Spirit ~ Year | Country, data=grog,
#         par.settings=simpleTheme(pch=19), auto.key=list(columns=3))

## ----J5_1d, eval=xtras, w=5.5, fig.asp=1.15, fig.show='asis', out.width="100%"-------------------
#  tinting <- DAAG::tinting
#  xyplot(csoa~it | tint*target, groups=agegp, data=tinting, auto.key=list(columns=2))

## ----J5_1e, eval=xtras, w=5.5, fig.asp=0.7, out.width="100%"-------------------------------------
#  cuckoos <- DAAG::cuckoos
#  av <- with(cuckoos, aggregate(length, list(species=species), FUN=mean))
#  gph <- dotplot(species ~ length, data=cuckoos, alpha=0.4) +
#    as.layer(dotplot(species ~ x, pch=3, cex=1.4, col="black", data=av))
#  update(gph, xlab="Length of egg (mm)")

## ----J5_1f, eval=xtras, w=5.5, fig.asp=0.7, out.width="100%"-------------------------------------
#  ## Alternatives, using `layer()` or `as.layer()`
#  avg <- with(cuckoos, data.frame(nspec=1:nlevels(species),
#                               av=sapply(split(length,species),mean)))
#  dotplot(species ~ length, data=cuckoos) +
#    layer(lpoints(nspec~av, pch=3, cex=1.25, col="black"), data=avg)

## ----J5_1g, eval=xtras, w=5.5, fig.asp=0.7, out.width="100%"-------------------------------------
#  dotplot(species ~ length, data=cuckoos) +
#    as.layer(dotplot(nspec~av, data=avg, pch=3, cex=1.25, col="black"))

## ----J5_1h, eval=xtras, w=5.5, fig.asp=0.7, out.width="100%"-------------------------------------
#  ## Specify panel function
#  dotplot(species ~ length, data=cuckoos,
#    panel=function(x,y,...){panel.dotplot(x, y, pch=1, col="gray40")
#      avg <- data.frame(nspec=1:nlevels(y), av=sapply(split(x,y),mean))
#      with(avg, lpoints(nspec~av, pch=3, cex=1.25, col="black")) })

## ----J5_1i, eval=xtras, w=5.5, fig.asp=0.7, out.width="100%"-------------------------------------
#  cuckoos <- DAAG::cuckoos
#  ## Panel A: Dotplot without species means added
#  gphA <- dotplot(species ~ length, data=cuckoos)
#  ## Panel B: Box and whisker plot
#  gphB <- bwplot(species ~ length, data=cuckoos)
#  update(c("A: Dotplot"=gphA, "B: Boxplot"=gphB), between=list(x=0.4),
#         xlab="Length of egg (mm)", layout=c(2,1))
#    ## `latticeExtra::c()` joins compatible plots together.
#    ## `layout=c(2,1)` : join horizontally; `layout=c(1,2)` : join vertically

## ----J5_2a, eval=F-------------------------------------------------------------------------------
#  vignette('plot3D', package='plot3D')

## ----10_2, w=6, h=4.75, eval=FALSE, left=-2, bot=-2, ps=10, message=FALSE, warning=FALSE, out.width="100%"----
#  ycol <- -2.1 - (0:9) * 2.1
#  ftype <- c("plain", "bold", "italic", "bold italic", "symbol")
#  yline <- 4.2
#  ypmax <- 20
#  farleft <- -7.8
#  plot(c(-4, 31), c(4.25, ypmax), type = "n", xlab = "", ylab = "",
#  axes = F)
#  chh <- par()$cxy[2]
#  text(0:25, rep(ypmax + 0.8 * chh, 26), paste(0:25), srt = 90,
#  cex = 0.75, xpd = T)
#  text(-1.5, ypmax + 0.8 * chh, "pch = ", cex = 0.75, xpd = T)
#  points(0:25, rep(ypmax, 26), pch = 0:25, lwd=0.8)
#  letterfont <- function(ypos = ypmax, font = 2) {
#  par(font = font)
#  text(-1.35, ypos, "64-76", cex = 0.75, adj = 1, xpd = TRUE)
#  text(19 - 1.35, ypos, "96-108", cex = 0.75, adj = 1)
#  points(c(0:12), rep(ypos, 13), pch = 64:76)
#  points(19:31, rep(ypos, 13), pch = 96:108)
#  text(farleft, ypos, paste(font), xpd = T)
#  text(farleft, ypos - 0.5, ftype[font], cex = 0.75)
#  }
#  plotfont <- function(xpos = 0:31, ypos = ypmax, font = 1,
#  sel32 = 2:4, showfont = TRUE) {
#  par(font = font)
#  i <- 0
#  for (j in sel32) {
#  i <- i + 1
#  maxval <- j * 32 - 1
#  if(j==4)maxval <- maxval-1
#  text(-1.35, ypos - i + 1, paste((j - 1) * 32, "-",
#  maxval, sep = ""), cex = 0.75, adj = 1, xpd = TRUE)
#  if(j!=4)
#  points(xpos, rep(ypos - i + 1, 32), pch = (j - 1) *
#  32 + (0:31))
#  else
#  points(xpos[-32], rep(ypos - i + 1, 31), pch = (j - 1) *
#  32 + (0:30))
#  }
#  lines(rep(-1.05, 2), c(ypos - length(sel32) + 1, ypos) +
#  c(-0.4, 0.4), xpd = T, col = "grey40")
#  if (showfont) {
#  text(farleft, ypos, paste("font =", font, " "), xpd = T)
#  text(farleft, ypos - 0.5, ftype[font], cex = 0.75,
#  xpd = T)
#  }
#  }
#  plotfont(ypos = ypmax - 1.5, font = 1, sel32 = 2:4)
#  for (j in 2:4) letterfont(ypos = ypmax - 2.1 - 1.4 * j, font = j)
#  plotfont(ypos = ypmax - 9.1, font = 5, sel32 = 3)
#  plotfont(xpos = c(-0.5, 1:31), ypos = ypmax - 10.1, font = 5,
#  sel32 = 4, showfont = FALSE)
#  par(font = 1)
#  ltypes <- c("blank", "solid", "dashed", "dotted", "dotdash",
#  "longdash", "twodash")
#  lcode <- c("", "", "44", "13", "1343", "73", "2262")
#  for (i in 0:6) {
#  lines(c(4, 31), c(yline + 4.5 - 0.8 * i, yline + 4.5 -
#  0.8 * i), lty = i, lwd = 2, xpd = T)
#  if (i == 0)
#  numchar <- paste("lty =", i, " ")
#  else numchar <- i
#  text(farleft, yline + 4.5 - 0.8 * i, numchar, xpd = TRUE)
#  text(farleft + 3.5, yline + 4.5 - 0.8 * i, ltypes[i +
#  1], cex = 0.85, xpd = TRUE)
#  text(farleft + 7.5, yline + 4.5 - 0.8 * i, lcode[i +
#  1], cex = 0.85, xpd = TRUE)
#  }

## ----10_2, eval=F--------------------------------------------------------------------------------
#  ycol <- -2.1 - (0:9) * 2.1
#  ftype <- c("plain", "bold", "italic", "bold italic", "symbol")
#  yline <- 4.2
#  ypmax <- 20
#  farleft <- -7.8
#  plot(c(-4, 31), c(4.25, ypmax), type = "n", xlab = "", ylab = "",
#  axes = F)
#  chh <- par()$cxy[2]
#  text(0:25, rep(ypmax + 0.8 * chh, 26), paste(0:25), srt = 90,
#  cex = 0.75, xpd = T)
#  text(-1.5, ypmax + 0.8 * chh, "pch = ", cex = 0.75, xpd = T)
#  points(0:25, rep(ypmax, 26), pch = 0:25, lwd=0.8)
#  letterfont <- function(ypos = ypmax, font = 2) {
#  par(font = font)
#  text(-1.35, ypos, "64-76", cex = 0.75, adj = 1, xpd = TRUE)
#  text(19 - 1.35, ypos, "96-108", cex = 0.75, adj = 1)
#  points(c(0:12), rep(ypos, 13), pch = 64:76)
#  points(19:31, rep(ypos, 13), pch = 96:108)
#  text(farleft, ypos, paste(font), xpd = T)
#  text(farleft, ypos - 0.5, ftype[font], cex = 0.75)
#  }
#  plotfont <- function(xpos = 0:31, ypos = ypmax, font = 1,
#  sel32 = 2:4, showfont = TRUE) {
#  par(font = font)
#  i <- 0
#  for (j in sel32) {
#  i <- i + 1
#  maxval <- j * 32 - 1
#  if(j==4)maxval <- maxval-1
#  text(-1.35, ypos - i + 1, paste((j - 1) * 32, "-",
#  maxval, sep = ""), cex = 0.75, adj = 1, xpd = TRUE)
#  if(j!=4)
#  points(xpos, rep(ypos - i + 1, 32), pch = (j - 1) *
#  32 + (0:31))
#  else
#  points(xpos[-32], rep(ypos - i + 1, 31), pch = (j - 1) *
#  32 + (0:30))
#  }
#  lines(rep(-1.05, 2), c(ypos - length(sel32) + 1, ypos) +
#  c(-0.4, 0.4), xpd = T, col = "grey40")
#  if (showfont) {
#  text(farleft, ypos, paste("font =", font, " "), xpd = T)
#  text(farleft, ypos - 0.5, ftype[font], cex = 0.75,
#  xpd = T)
#  }
#  }
#  plotfont(ypos = ypmax - 1.5, font = 1, sel32 = 2:4)
#  for (j in 2:4) letterfont(ypos = ypmax - 2.1 - 1.4 * j, font = j)
#  plotfont(ypos = ypmax - 9.1, font = 5, sel32 = 3)
#  plotfont(xpos = c(-0.5, 1:31), ypos = ypmax - 10.1, font = 5,
#  sel32 = 4, showfont = FALSE)
#  par(font = 1)
#  ltypes <- c("blank", "solid", "dashed", "dotted", "dotdash",
#  "longdash", "twodash")
#  lcode <- c("", "", "44", "13", "1343", "73", "2262")
#  for (i in 0:6) {
#  lines(c(4, 31), c(yline + 4.5 - 0.8 * i, yline + 4.5 -
#  0.8 * i), lty = i, lwd = 2, xpd = T)
#  if (i == 0)
#  numchar <- paste("lty =", i, " ")
#  else numchar <- i
#  text(farleft, yline + 4.5 - 0.8 * i, numchar, xpd = TRUE)
#  text(farleft + 3.5, yline + 4.5 - 0.8 * i, ltypes[i +
#  1], cex = 0.85, xpd = TRUE)
#  text(farleft + 7.5, yline + 4.5 - 0.8 * i, lcode[i +
#  1], cex = 0.85, xpd = TRUE)
#  }

## ----J6_1b, eval=xtras---------------------------------------------------------------------------
#  library(RColorBrewer)
#  palette(brewer.pal(12, "Set3"))

