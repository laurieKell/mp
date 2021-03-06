weighted.var.se<-function(x, w, na.rm=FALSE){
  #  Computes the variance of a weighted mean following Cochran 1977 definition
  if (na.rm) { w <- w[i <- !is.na(x)]; x <- x[i] }
  n = length(w)
  xWbar = weighted.mean(x,w,na.rm=na.rm)
  wbar = mean(w)
  out = n/((n-1)*sum(w)^2)*(sum((w*x-wbar*xWbar)^2)-2*xWbar*sum((w-wbar)*(w*x-wbar*xWbar))+xWbar^2*sum((w-wbar)^2))
  
  return(out)}

#'
#' x=rlnorm(100)
#' w=1:100
#' 
#' weighted.var.se(x,w)^.5
#' 
#' http://stats.stackexchange.com/questions/25895/computing-standard-error-in-weighted-mean-estimation
