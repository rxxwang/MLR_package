
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HW3project

<!-- badges: start -->

[![R-CMD-check](https://github.com/rxxwang/MLR_package/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rxxwang/MLR_package/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of HW3project is to reproduce perfermance of lm().

## Installation

You can install the development version of HW3project from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rxxwang/MLR_package")
#> Downloading GitHub repo rxxwang/MLR_package@HEAD
#>          checking for file 'C:\Users\Thinkpad\AppData\Local\Temp\RtmpIprhfj\remotesb40577c478a\rxxwang-MLR_package-df25a63/DESCRIPTION' ...  ✔  checking for file 'C:\Users\Thinkpad\AppData\Local\Temp\RtmpIprhfj\remotesb40577c478a\rxxwang-MLR_package-df25a63/DESCRIPTION' (377ms)
#>       ─  preparing 'HW3project':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>      Omitted 'LazyData' from DESCRIPTION
#>       ─  building 'HW3project_0.1.0.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/Thinkpad/AppData/Local/Temp/RtmpSSvin8/temp_libpath1f783c3f3152'
#> (as 'lib' is unspecified)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(HW3project)
data(mtcars)
model_mlr = mlr(mpg ~ cyl + wt + cyl * wt, mtcars)
#> 
#>  Call: 
#>  lm( formula =  mpg ~ cyl + wt + cyl * wt ) 
#>  
#>  Coefficients: 
#> (Intercept)         cyl          wt      cyl:wt 
#>  54.3068062  -3.8032187  -8.6555590   0.8083947
```