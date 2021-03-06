% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/biodyn-plot.R
\name{plotMSEfn}
\alias{plotMSEfn}
\alias{plotMSE,biodyn,FLStock,FLBRP-method}
\alias{harvest'=catch(om)/stock(om)\%/\%(brp@refpts['msy','yield']/brp@refpts['msy','biomass']),}
\title{plotMSE}
\usage{
plotMSEfn(mp, om, brp = "missing")
}
\arguments{
\item{x, }{an object of class \code{biodyn}}

\item{y, }{an object of class \code{FLStock}}

\item{z, }{an object of class \code{FLBRP}}

\item{...}{other arguments}
}
\value{
an \code{ggplot2} object
}
\description{
Creates a \code{ggplot2} object that plots absolute and relative to MSY benchmarks time series of 
ssb, biomass, harvest rate and catch for  \code{FLStock} and  \code{biodyn}  objects
The basic object can then be modified by adding ggpot2 layers.
}
