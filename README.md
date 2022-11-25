
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HW3project

<!-- badges: start -->

[![R-CMD-check](https://github.com/rxxwang/MLR_package/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rxxwang/MLR_package/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/rxxwang/MLR_package/branch/main/graph/badge.svg)](https://app.codecov.io/gh/rxxwang/MLR_package?branch=main)
<!-- badges: end -->

The goal of HW3project is to reproduce perfermance of lm() and
summary().

## Installation

You can install the development version of HW3project from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rxxwang/MLR_package")
#> Downloading GitHub repo rxxwang/MLR_package@HEAD
#> 
#> * checking for file 'C:\Users\Thinkpad\AppData\Local\Temp\RtmpERaVc3\remotes53d01627c1c\rxxwang-MLR_package-f9befe1/DESCRIPTION' ... OK
#> * preparing 'HW3project':
#> * checking DESCRIPTION meta-information ... OK
#> * cleaning src
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Omitted 'LazyData' from DESCRIPTION
#> * building 'HW3project_0.1.0.tar.gz'
#> 
#> Installing package into 'C:/Users/Thinkpad/AppData/Local/R/win-library/4.2'
#> (as 'lib' is unspecified)
#> Warning in i.p(...): installation of package 'C:/Users/Thinkpad/AppData/Local/
#> Temp/RtmpERaVc3/file53d0a0e7c72/HW3project_0.1.0.tar.gz' had non-zero exit
#> status
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(HW3project)
data(mtcars)
# Use the mlr function to generate a multilinear regression model
model_mlr = mlr(mpg ~ cyl + wt + cyl * wt, mtcars)
#> 
#>  Call: 
#>  lm( formula =  mpg ~ cyl + wt + cyl * wt ) 
#>  
#>  Coefficients: 
#> (Intercept)         cyl          wt      cyl:wt 
#>  54.3068062  -3.8032187  -8.6555590   0.8083947
# Use the summary_mlr function to show the summary result of the model
summary = summary_mlr(model_mlr)
#> 
#>  Call: 
#>  lm( formula = mpg ~ cyl + wt + cyl * wt ) 
#>  
#>  Redisuals: 
#>        Min         1Q     Median         3Q        Max 
#> -4.2287505 -1.3495235 -0.5041851  1.4647220  5.2344247 
#> 
#>  Coefficients: 
#>             Estimate   Std. Error t value   Pr(>|t|)        
#> (Intercept) 54.3068062 6.127535    8.862749 1.288912e-09 ***
#> cyl         -3.8032187 1.005028   -3.784193 7.471791e-04 ***
#> wt          -8.6555590 2.320122   -3.730648 8.609666e-04 ***
#> cyl:wt       0.8083947 0.327322    2.469723 1.988242e-02 *  
#> --- 
#>  Signif. codes: 
#>  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
#>  
#>  Residual standard error:  2.368 on 28 degrees of freedom 
#>  Multiple R-squared:  0.8606 ,   Adjusted R-squared:  0.8457 
#>  F-statistic:  57.62 on 3 and 28 DF,  p-value: 4.231456e-12
```
