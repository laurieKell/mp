% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/biodyn-control.R
\name{setControl<-,biodyn,FLPar-method}
\alias{setControl<-,biodyn,FLPar-method}
\alias{setControl<-,biodyn,FLQuant-method}
\alias{setControl<-,biodyn,FLQuants-method}
\alias{setControl<-,aspic,FLPar-method}
\title{setControl<-}
\usage{
\S4method{setControl}{biodyn,FLPar}(object, min = 0.1, max = 10) <- value
}
\arguments{
\item{object}{an object of class \code{biodyn}}

\item{value}{\code{params} object}

\item{...}{any other parameter}
}
\description{
Sets the control slot in a biodyn object given the parameters in the \code{params}
slot. The starting values \code{val} are set to those in \code{params} and the \code{min} and
\code{max} bounds to .1 and 10 times these.
}
\examples{
\dontrun{
bd=sim()
setControl(bd)=params(bd)
}
 
}
\seealso{
\code{\link{controlFn}}
}
