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
#'@importFrom stats model.matrix na.exclude na.omit terms setNames
#'
#'@export
#'
mlr <- function(formula, data, na.action = "na.omit") {
  # handle NA
  if(na.action == "na.omit"){
    data = stats::na.omit(data)
  }else if(na.action == "na.exclude"){
    data = stats::na.exclude(data)
  }
  # covert the formula to Y and X
  formula_y = all.vars(formula)[1]
  formula_x = labels(stats::terms(formula))
  # split the X with interactions
  covariates = unique(unlist(strsplit(formula_x,":")))

  # build a X matrix and a Y matrix
  X = stats::model.matrix(formula, data = data)
  Y = as.matrix(data[formula_y])

  # calculate coefficients
  beta = solve(t(X) %*% X) %*% t(X) %*% Y

  # calculate residuals
  res = Y - X %*% beta

  # calculate fitted values
  fit_values = X %*% beta

  # calculate estimated sigma squares
  sigma_2 = sum(res*res)/(dim(data)[1] - length(formula_x) - 1)

  # calculate the variances of coefficients
  variance_matrix = sigma_2 * solve(t(X) %*% X)

  # calculate SSY
  SSY = 0
  for(i in 1:length(Y)){
    SSY = SSY + (Y[i]-mean(Y))^2
  }

  # get the output list
  output_list = list(
    "coefficients" = stats::setNames(as.vector(beta),rownames(beta)),
    "residuals" = stats::setNames(as.vector(res),rownames(res)),
    "rank" = length(formula_x)+1,
    "fitted.values" = stats::setNames(as.vector(fit_values),rownames(fit_values)),
    "df.residual" = dim(data)[1] - length(formula_x) - 1,
    "coefficients.matrix" = variance_matrix,
    "SSY" = SSY,
    "call" = paste0("lm(formula = ", Reduce(paste, deparse(formula)), ")"),
    "terms" = formula,
    "model" = data[c(formula_y,covariates)]
  )

  # print results
  cat(
    "\n",
    "Call:","\n",
    "lm( formula = ", Reduce(paste, deparse(formula)), ")","\n",
    "\n",
    "Coefficients:","\n"
  )
  print(stats::setNames(as.vector(beta),rownames(beta)))

  return(invisible(output_list))
}
