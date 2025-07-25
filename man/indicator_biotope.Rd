% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/indicator_biotope.R
\name{indicator_biotope}
\alias{indicator_biotope}
\title{Calculation of the CrowdWater Biotope Indicator}
\usage{
indicator_biotope(df_cw, return_scoring_system = FALSE)
}
\arguments{
\item{df_cw}{Dataframe of the crowdwater lake properties prepared by
\code{\link[=prepare_data]{prepare_data()}}}

\item{return_scoring_system}{If TRUE the scoring system is returned instead
of the indicator vector.}
}
\value{
Either a numeric vector of the indicator points, or a description of the
scoring system. This is a list of properties and categories which contribute
to the indicator.
}
\description{
The indicator is calculated per observation
}
