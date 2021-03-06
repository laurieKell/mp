% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/biodyn-mse.R
\name{mseBiodyn}
\alias{mseBiodyn}
\alias{mse}
\title{mseBiodyn}
\usage{
mseBiodyn(
  om,
  eql,
  srDev,
  uDev,
  mp,
  start = range(om)["maxyear"],
  end = start + 30,
  interval = 3,
  oem = oem,
  hcrPar = function(mp, ftar = 0.7, btrig = 0.6, fmin = 0 - 1, blim = 0.001) {    
    hcrParam(ftar = ftar * fmsy(mp), btrig = btrig * bmsy(mp), fmin = fmin * fmsy(mp),
    blim = blim * bmsy(mp)) },
  bndF = NULL,
  bndTac = NULL,
  maxF = 1,
  omega = 1,
  refB = 1,
  qTrend = 0
)
}
\arguments{
\item{om}{an \code{FLStock} object}

\item{srDev}{a \code{FLQuant} with recruitment deviates}

\item{uDev}{an \code{FLQuant} or \code{FLQuants} with CPUE residuals}

\item{mp}{an \code{biodyn} object that holds the options for the biomass dynamic assessment model}

\item{range}{a \code{vector} the starting and end years for the projections, and the interval for running the MP}

\item{ftar}{a \code{numeric} with target F in HCR}

\item{fmin}{a \code{numeric} with minimum F in HCR}

\item{blim}{a \code{numeric} with biomass limit for HCR}

\item{btrig}{a \code{numeric} with biomass trigger (i.e. when to reduce F) in HCR}

\item{what}{a \code{character} that specifies what is to be used for the reference point in the HCR, recycled as required}

\item{mult}{a \code{logical} that specifies whether quantity in HCR options is a multiplier or probability, recycled as required}
}
\value{
a list of \code{data.frame}s with performance measures from OM and summaries from MP, if \code{con!=NULL} will
also write to a MYSQL database
}
\description{
Runs a full MSE using an \code{FLStock} object as the Operating Model and \code{biodyn} as the Mangement Procedure
}
\examples{
\dontrun{
library(mpb)
library(FLash)
library(FLBRP)

load(om)
load(eql)

om=mpb::fwdWindow(om,eql,end=2030)
om=propagate(om,100)

srDev=FLQuant(0,dimnames=list(year=2000:2030))
srDev=rlnorm(100,srDev,0.3)

om=mpb::fwd(om,catch=catch(om)[,ac(2000:2011)],sr=eql,sr.residuals=srDev)

library(popbio)

mp=mpb::FLBRP2biodyn(  eql,"biodyn")
mp=mpb::FLStock2biodyn(om, "biodyn")
}
}
\seealso{
\code{\link{biodyn}}
}
