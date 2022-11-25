test_that("mlr works", {
  expect_equal(mlr(Ozone ~ Solar.R + Wind + Temp, airquality, na.action = "na.exclude")$coefficients,
               lm(Ozone ~ Solar.R + Wind + Temp, airquality, na.action = na.exclude)$coefficients)
  expect_equal(mlr(Ozone ~ Solar.R + Wind + Temp, airquality)$coefficients,
               lm(Ozone ~ Solar.R + Wind + Temp, airquality)$coefficients)
  expect_equal(mlr(Ozone ~ Solar.R + Wind + Temp, airquality)$residuals,
               lm(Ozone ~ Solar.R + Wind + Temp, airquality)$residuals)
  expect_equal(mlr(Ozone ~ Solar.R + Wind + Temp, airquality)$fitted.values,
               lm(Ozone ~ Solar.R + Wind + Temp, airquality)$fitted.values)
  expect_equal(summary_mlr(mlr(mpg ~ cyl + disp + hp, mtcars))$coefficients,
               summary(lm(mpg ~ cyl + disp + hp, mtcars))$coefficients)
  expect_equal(summary_mlr(mlr(Ozone ~ Solar.R + Wind + Temp, airquality))$adj.r.squared,
               summary(lm(Ozone ~ Solar.R + Wind + Temp, airquality))$adj.r.squared)
  expect_equal(summary_mlr(mlr(Ozone ~ Solar.R + Wind + Temp, airquality))$fstatistic,
               summary(lm(Ozone ~ Solar.R + Wind + Temp, airquality))$fstatistic)
})
