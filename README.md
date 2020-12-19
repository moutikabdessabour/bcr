
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bcr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/bcr)](https://cran.r-project.org/package=bcr)
[![](https://img.shields.io/badge/dev%20-0.1.1.9000-brightgreen.svg)](https://github.com/moutikabdessabour/bcr)
<!-- [![CRAN checks](https://cranchecks.info/badges/worst/bcr)](https://cran.r-project.org/web/checks/check_results_bcr.html) -->
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/bcr?color=grey)](https://moutikabdessabour.github.io/bcr/)
<!-- badges: end -->

*bcr* is an `R` package that scraps the web (mainly [**Le
Boursier**](https://leboursier.ma)) for Moroccan Financial Data. It aims
to facilitate the access of this data on `R`.

Data provided by this package:

  - Listing of **Moroccan Bonds**.
  - Latest *price variation* of **Moroccan stocks** (Including **MASI**
    and **MADEX** indices).
  - Listing of **Moroccan Market and Sectoral Indices**.
  - Historical *price* data of **Moroccan stocks**.
  - Intraday variation of **Moroccan stocks**.

## Installation

Either install directly from [CRAN](https://cran.r-project.org) :

``` r
# From the R console call
install.packages("bcr")
```

Or to get the development version first install the `{remotes}` package
then use the line below:

``` r
# install remotes first if you don't have it installed
# install.packages("remotes")
# install the development version
remotes::install_github("moutikabdessabour/bcr")
```

## Documentation

All you need to know about how to use thi package is provided
[here](https://moutikabdessabour.github.io/bcr/reference/index.html).
