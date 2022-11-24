#'mlr
#'
#'Fits the multiple linear regression model
#'
#'@param formula the formula that linear regression model should fit
#'
#'@param data the dataframe where the input data comes from
#'
#'@param na.action a function which indicates what should happen when the data contain NAs. Default is na.omit.
#'
#'@return a list that contains the following values: coefficients, residuals, rank, fitted.values, df.residual, call, terms, model
#'
#'@examples
#'mlr(mpg ~ cyl + wt, mtcars)
#'mlr(mpg ~ cyl + wt + cyl * wt, mtcars)
#'mlr(mpg ~ cyl + wt, mtcars, na.action = "na.exclude")
#'
#'@importFrom stats model.matrix
#'
#'@export
#'
mlr <- function(formula, data, na.action = "na.omit") {
  # handle NA
  if(na.action == "na.omit"){
    data = na.omit(data)
  }else if(na.action == "na.exclude"){
    data = na.exclude(data)
  }
  # covert the formula to Y and X
  formula_y = all.vars(formula)[1]
  formula_x = labels(terms(formula))
  # split the X with interactions
  covariates = unique(unlist(strsplit(formula_x,":")))

  # build a X matrix and a Y matrix
  library(stats)
  X = model.matrix(formula, data = data)
  Y = as.matrix(data[formula_y])

  # use Rcpp for the calculation of parameters
  # sourceCpp("Rcpp.cpp")
  # calculate coefficients
  beta = solve(t(X) %*% X) %*% t(X) %*% Y

  # calculate residuals
  res = Y - X %*% beta

  # calculate fitted values
  fit_values = X %*% beta

  output_list = list(
    "coefficients" = as.vector(beta),
    "residuals" = as.vector(res),
    "rank" = length(formula_x)+1,
    "fitted.values" = as.vector(fit_values),
    "df.residual" = dim(data)[1] - length(formula_x) - 1,
    "call" = paste0("lm(formula = ", Reduce(paste, deparse(formula)), ")"),
    "terms" = formula,
    "model" = data[c(formula_y,covariates)]
  )

  colnames(beta) = NULL
  cat(
    "\n",
    "Call:","\n",
    "lm( formula = ", Reduce(paste, deparse(formula)), ")","\n",
    "\n",
    "Coefficients:","\n"
  )
  print(t(beta))

  return(invisible(output_list))
}
