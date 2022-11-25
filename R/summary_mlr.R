#'summary_mlr
#'
#'Gives the summary result of mlr function
#'
#'@param model the model generated from the mlr function in this package
#'
#'@return a list that contains the following values:     terms , residuals, coefficients , sigma, df,  r.squared, adj.r.squared, fstatistic
#'
#'@examples
#'summary_mlr(mlr(mpg ~ cyl + wt, mtcars))
#'
#'@importFrom stats pt setNames pf quantile
#'
#'@export
#'
summary_mlr <- function(model){
  formula = model$terms

  # calculate quartiles of residuals
  quartile_residuals = stats::quantile(model$residuals, probs = c(0,0.25,0.5,0.75,1))
  quartile_residuals = stats::setNames(as.vector(quartile_residuals),c("Min","1Q","Median","3Q","Max"))

  # use Rcpp for the calculation of standard errors, calculate t values and p values
  se = sqrt(StandardError(as.vector(model$coefficients.matrix), length(model$coefficients)))
  tvalue = model$coefficients/se
  pvalue = stats::pt(abs(tvalue),model$df.residual,lower.tail = F)*2

  # Generate the coefficient table
  summary_coefficients = data.frame(
    Estimate = model$coefficients,
    Std.Error = se,
    tvalue = tvalue,
    Pr = pvalue
  )
  summary_coefficients_origin = as.matrix(summary_coefficients)
  colnames(summary_coefficients_origin) = c("Estimate","Std. Error","t value","Pr(>|t|)")
  rownames(summary_coefficients_origin) = names(model$coefficients)
  for(i in 1:length(model$coefficients)){
    p = summary_coefficients$Pr[i]
    if(p < 0.001){
      summary_coefficients[i,5] = "***"
    }else if(p < 0.01){
      summary_coefficients[i,5] = "**"
    }else if(p < 0.05){
      summary_coefficients[i,5] = "*"
    }else if(p < 0.1){
      summary_coefficients[i,5] = "."
    }else{
      summary_coefficients[i,5] = " "
    }
  }
  colnames(summary_coefficients) = c("Estimate","Std. Error","t value","Pr(>|t|)","")
  rownames(summary_coefficients) = names(model$coefficients)
  summary_coefficients = as.matrix(summary_coefficients)

  # calculate SSE, SSR and R squared
  SSE = sum(model$residuals * model$residuals)
  SSR = model$SSY - SSE
  r2 = SSR/model$SSY
  adj.r2 = 1 - SSE * (length(model$residuals)-1) / (model$SSY * model$df.residual)

  # calculate F statistics
  Fvalue = SSR/(length(model$coefficients)-1)/SSE*model$df.residual
  fstatistic = c(Fvalue, length(model$coefficients)-1, model$df.residual)
  names(fstatistic) = c("value","numdf","dendf")
  F_p = stats::pf(Fvalue, length(model$coefficients)-1, model$df.residual, lower.tail = FALSE)

  # print results
  cat(
    "\n",
    "Call:","\n",
    "lm( formula = ", Reduce(paste, deparse(formula)), ")","\n",
    "\n",
    "Redisuals:","\n")
  print(quartile_residuals)
  cat(
    "\n",
    "Coefficients:","\n"
  )
  print(noquote(summary_coefficients))
  cat(
    "---","\n",
    "Signif. codes:","\n",
    "0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1","\n",
    "\n",
    "Residual standard error: ",round(sqrt(SSE/model$df.residual),3),
    "on",model$df.residual,"degrees of freedom","\n",
    "Multiple R-squared: ",round(r2,4),",	Adjusted R-squared: ",round(adj.r2,4),"\n",
    "F-statistic: ",round(fstatistic[1],2),"on",length(model$coefficients)-1, "and",
    model$df.residual,"DF,  p-value:",F_p,"\n"
  )
  # get the output list
  output_list = list(
    terms = model$terms,
    residuals = model$residuals,
    coefficients = summary_coefficients_origin,
    sigma = sqrt(SSE/model$df.residual),
    df = c(dim(summary_coefficients)[1],model$df.residual,dim(summary_coefficients)[1]),
    r.squared = r2,
    adj.r.squared = adj.r2,
    fstatistic = fstatistic
  )
  return (output_list)
}
