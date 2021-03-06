% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_today.R
\name{get_today}
\alias{get_today}
\title{Latest daily variation of Moroccan stocks}
\usage{
get_today()
}
\value{
Returns a \code{data.frame} containing the daily variation for all the stocks.
\itemize{
\item \code{name}: name of the company/stock.
\item \code{price}: last price.
\item \code{variation}: variation of the price.
}
}
\description{
Get the last variation of all stocks that are available in the stock exchange and the MASI/MADEX indices.
}
\examples{
if( bcr:::check_internet() ) {
get_today()
}
}
