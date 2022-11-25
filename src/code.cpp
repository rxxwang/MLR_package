#include <Rcpp.h>
#include <vector>
using namespace Rcpp;
//' Gets the Standard Error from a coefficient variance matrix
//'
//' @param x Numeric vector in R
//'
//' @param n integer in R
//'
// [[Rcpp::export]]

NumericVector StandardError(NumericVector x, int n){
  NumericVector v(n);
  for(int i = 0; i < n; i++){
    v[i] = x[(n+1)*i];
  }
  return v;
}
