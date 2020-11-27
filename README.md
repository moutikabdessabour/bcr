
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bcr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/bcr)](https://cran.r-project.org/package=bcr)
[![](https://img.shields.io/badge/dev%20-0.1.0-green.svg)](https://github.com/moutikabdessabour/bcr)
[![CRAN
checks](https://cranchecks.info/badges/worst/bcr)](https://cran.r-project.org/web/checks/check_results_bcr.html)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/bcr?color=grey)](https://moutikabdessabour.github.io/bcr/)
<!-- badges: end -->

*bcr* is an `R` package that scraps the web (mainly [**Le
Boursier**](leboursier.ma)) for Moroccan Financial Data. It aims to
facilitate the access of this data on `R`.

Data provided by *bcr*:

  - Listing of **Moroccan Bonds**
  - Latest *price variation* of Moroccan stocks (Including MASI and
    MADEX indices)
  - Listing of **Moroccan Market and Sectorial Indices**
  - Historical price data of Moroccan stocks
  - Intraday variation of Moroccan stocks

## Installation

Either install directly from CRAN :

``` r
# From the R console call
install.packages("collapse")
```

Or from github :

``` r
# install remotes first if you don't have it installed
# install.packages("remotes")
# install the development version
remotes::install_github("moutikabdessabour/bcr")
```

## Documentation

A minimal documentation is provided
[here](moutikabdessabour.github.io/bcr/reference/index.html). <!--
## Examples

<details>
  <summary><b><a style="cursor: pointer;">Click here to expand </a></b> </summary>
  
``` r
library(collapse)
data("iris")            # iris dataset in base R
v <- iris$Sepal.Length  # Vector
d <- num_vars(iris)     # Saving numeric variables (could also be a matrix, statistical functions are S3 generic)
g <- iris$Species       # Grouping variable (could also be a list of variables)

## Advanced Statistical Programming -----------------------------------------------------------------------------

# Simple (column-wise) statistics...
fmedian(v)                       # Vector
fsd(qM(d))                       # Matrix (qM is a faster as.matrix)
fmode(d)                         # data.frame
fmean(qM(d), drop = FALSE)       # Still a matrix
fmax(d, drop = FALSE)            # Still a data.frame

# Fast grouped and/or weighted statistics
w <- abs(rnorm(fnrow(iris)))
fmedian(d, w = w)                 # Simple weighted statistics
fnth(d, 0.75, g)                  # Grouped statistics (grouped third quartile)
fmedian(d, g, w)                  # Groupwise-weighted statistics
fsd(v, g, w)                      # Similarly for vectors
fmode(qM(d), g, w, ties = "max")  # Or matrices (grouped and weighted maximum mode) ...

# A fast set of data manipulation functions allows complex piped programming at high speeds
library(magrittr)                            # Pipe operators
iris %>% fgroup_by(Species) %>% fNdistinct   # Grouped distinct value counts
iris %>% fgroup_by(Species) %>% fmedian(w)   # Weighted group medians 
iris %>% add_vars(w) %>%                     # Adding weight vector to dataset
  fsubset(Sepal.Length < fmean(Sepal.Length), Species, Sepal.Width:w) %>% # Fast selecting and subsetting
  fgroup_by(Species) %>%                     # Grouping (efficiently creates a grouped tibble)
  fvar(w) %>%                                # Frequency-weighted group-variance, default (keep.w = TRUE)  
  roworder(sum.w)                            # also saves group weights in a column called 'sum.w'

# Can also use dplyr (but dplyr manipulation verbs are a lot slower)
library(dplyr)
iris %>% add_vars(w) %>% 
  filter(Sepal.Length < fmean(Sepal.Length)) %>% 
  select(Species, Sepal.Width:w) %>% 
  group_by(Species) %>% 
  fvar(w) %>% arrange(sum.w)

## Advanced Aggregation -----------------------------------------------------------------------------------------

collap(iris, Sepal.Length + Sepal.Width ~ Species, fmean)  # Simple aggregation using the mean..
collap(iris, ~ Species, list(fmean, fmedian, fmode))       # Multiple functions applied to each column
add_vars(iris) <- w                                        # Adding weights, return in long format..
collap(iris, ~ Species, list(fmean, fmedian, fmode), w = ~ w, return = "long")

# Generate some additional logical data
settransform(iris, AWMSL = Sepal.Length > fmedian(Sepal.Length, w = w), 
                   AWMSW = Sepal.Width > fmedian(Sepal.Width, w = w))

# Multi-type data aggregation: catFUN applies to all categorical columns (here AMWSW)
collap(iris, ~ Species + AWMSL, list(fmean, fmedian, fmode), 
       catFUN = fmode, w = ~ w, return = "long")

# Custom aggregation gives the greatest possible flexibility: directly mapping functions to columns
collap(iris, ~ Species + AWMSL, 
       custom = list(fmean = 2:3, fsd = 3:4, fmode = "AWMSL"), w = ~ w, 
       wFUN = list(fsum, fmin, fmax), # Here also aggregating the weight vector with 3 different functions
       keep.col.order = FALSE)        # Column order not maintained -> grouping and weight variables first

# Can also use grouped tibble: weighted median for numeric, weighted mode for categorical columns
iris %>% fgroup_by(Species, AWMSL) %>% collapg(fmedian, fmode, w = w)

## Advanced Transformations -------------------------------------------------------------------------------------

# All Fast Statistical Functions have a TRA argument, supporting 10 different replacing and sweeping operations
fmode(d, TRA = "replace")     # Replacing values with the mode
fsd(v, TRA = "/")             # dividing by the overall standard deviation (scaling)
fsum(d, TRA = "%")            # Computing percentages
fsd(d, g, TRA = "/")          # Grouped scaling
fmin(d, g, TRA = "-")         # Setting the minimum value in each species to 0
ffirst(d, g, TRA = "%%")      # Taking modulus of first value in each species
fmedian(d, g, w, "-")         # Groupwise centering by the weighted median
fnth(d, 0.95, g, w, "%")      # Expressing data in percentages of the weighted species-wise 95th percentile
fmode(d, g, w, "replace",     # Replacing data by the species-wise weighted minimum-mode
      ties = "min")

# TRA() can also be called directly to replace or sweep with a matching set of computed statistics
TRA(v, sd(v), "/")                       # Same as fsd(v, TRA = "/")
TRA(d, fmedian(d, g, w), "-", g)         # Same as fmedian(d, g, w, "-")
TRA(d, BY(d, g, quantile, 0.95), "%", g) # Same as fnth(d, 0.95, g, TRA = "%") (apart from quantile algorithm)

# For common uses, there are some faster and more advanced functions
fbetween(d, g)                           # Grouped averaging [same as fmean(d, g, TRA = "replace") but faster]
fwithin(d, g)                            # Grouped centering [same as fmean(d, g, TRA = "-") but faster]
fwithin(d, g, w)                         # Grouped and weighted centering [same as fmean(d, g, w, "-")]
fwithin(d, g, w, theta = 0.76)           # Quasi-centering i.e. d - theta*fbetween(d, g, w)
fwithin(d, g, w, mean = "overall.mean")  # Preserving the overall weighted mean of the data

fscale(d)                                # Scaling and centering (default mean = 0, sd = 1)
fscale(d, mean = 5, sd = 3)              # Custom scaling and centering
fscale(d, mean = FALSE, sd = 3)          # Mean preserving scaling
fscale(d, g, w)                          # Grouped and weighted scaling and centering
fscale(d, g, w, mean = "overall.mean",   # Setting group means to overall weighted mean,
       sd = "within.sd")                 # and group sd's to fsd(fwithin(d, g, w), w = w)

get_vars(iris, 1:2)                      # Use get_vars for fast selecting data.frame columns, gv is shortcut
fHDbetween(gv(iris, 1:2), gv(iris, 3:5)) # Linear prediction with factors and continuous covariates
fHDwithin(gv(iris, 1:2), gv(iris, 3:5))  # Linear partialling out factors and continuous covariates

# This again opens up new possibilities for data manipulation...
iris %>%  
  ftransform(ASWMSL = Sepal.Length > fmedian(Sepal.Length, Species, w, "replace")) %>%
  fgroup_by(ASWMSL) %>% collapg(w = w, keep.col.order = FALSE)

iris %>% fgroup_by(Species) %>% num_vars %>% fwithin(w)  # Weighted demeaning


## Time Series and Panel Series ---------------------------------------------------------------------------------

flag(AirPassengers, -1:3)                      # A sequence of lags and leads
EuStockMarkets %>%                             # A sequence of first and second seasonal differences
  fdiff(0:1 * frequency(.), 1:2)  
fdiff(EuStockMarkets, rho = 0.95)              # Quasi-difference [x - rho*flag(x)]
fdiff(EuStockMarkets, log = TRUE)              # Log-difference [log(x/flag(x))]
EuStockMarkets %>% fgrowth(c(1, frequency(.))) # Ordinary and seasonal growth rate
EuStockMarkets %>% fgrowth(logdiff = TRUE)     # Log-difference growth rate [log(x/flag(x))*100]

# Creating panel data
pdata <- EuStockMarkets %>% list(`A` = ., `B` = .) %>% 
         unlist2d(idcols = "Id", row.names = "Time")  

L(pdata, -1:3, ~Id, ~Time)                   # Sequence of fully identified panel-lags (L is operator for flag) 
pdata %>% fgroup_by(Id) %>% flag(-1:3, Time) # Same thing..

# collapse supports pseries and pdata.frame's, provided by the plm package
pdata <- plm::pdata.frame(pdata, index = c("Id", "Time"))         
L(pdata, -1:3)          # Same as above, ...
psacf(pdata)            # Multivariate panel-ACF
psmat(pdata) %>% plot   # 3D-array of time series from panel data + plotting

HDW(pdata)              # This projects out id and time fixed effects.. (HDW is operator for fHDwithin)
W(pdata, effect = "Id") # Only Id effects.. (W is operator for fwithin)

## List Processing ----------------------------------------------------------------------------------------------

# Some nested list of heterogenous data objects..
l <- list(a = qM(mtcars[1:8]),                                   # Matrix
          b = list(c = mtcars[4:11],                             # data.frame
                   d = list(e = mtcars[2:10], 
                            f = fsd(mtcars))))                   # Vector

ldepth(l)                       # List has 4 levels of nesting (considering that mtcars is a data.frame)
is.unlistable(l)                # Can be unlisted
has_elem(l, "f")                # Contains an element by the name of "f"
has_elem(l, is.matrix)          # Contains a matrix

get_elem(l, "f")                # Recursive extraction of elements..
get_elem(l, c("c","f"))         
get_elem(l, c("c","f"), keep.tree = TRUE)
unlist2d(l, row.names = TRUE)   # Intelligent recursive row-binding to data.frame   
rapply2d(l, fmean) %>% unlist2d # Taking the mean of all elements and repeating

# Application: extracting and tidying results from (potentially nested) lists of model objects
list(mod1 = lm(mpg ~ carb, mtcars), 
     mod2 = lm(mpg ~ carb + hp, mtcars)) %>%
  lapply(summary) %>% 
  get_elem("coef", regex = TRUE) %>%   # Regular expression search and extraction
  unlist2d(idcols = "Model", row.names = "Predictor")

## Summary Statistics -------------------------------------------------------------------------------------------

irisNA <- na_insert(iris, prop = 0.15)  # Randmonly set 15% missing
fNobs(irisNA)                           # Observation count
pwNobs(irisNA)                          # Pairwise observation count
fNobs(irisNA, g)                        # Grouped observation count
fNdistinct(irisNA)                      # Same with distinct values... (default na.rm = TRUE skips NA's)
fNdistinct(irisNA, g)  

descr(iris)                                   # Detailed statistical description of data

varying(iris, ~ Species)                      # Show which variables vary within Species
varying(pdata)                                # Which are time-varying ? 
qsu(iris, w = ~ w)                            # Fast (one-pass) summary (with weights)
qsu(iris, ~ Species, w = ~ w, higher = TRUE)  # Grouped summary + higher moments
qsu(pdata, higher = TRUE)                     # Panel-data summary (between and within entities)
pwcor(num_vars(irisNA), N = TRUE, P = TRUE)   # Pairwise correlations with p-value and observations
pwcor(W(pdata, keep.ids = FALSE), P = TRUE)   # Within-correlations

```

</details>
<p> </p>
-->
