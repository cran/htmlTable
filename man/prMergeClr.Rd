% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/htmlTable_helpers_mergeClr.R
\name{prMergeClr}
\alias{prMergeClr}
\title{Merges multiple colors}
\usage{
prMergeClr(clrs)
}
\arguments{
\item{clrs}{The colors}
}
\value{
\code{character} A hexadecimal color
}
\description{
Uses the \code{\link[grDevices:colorRamp]{colorRampPalette()}} for merging colors.
\emph{Note:} When merging more than 2 colors the order in the color
presentation matters. Each color is merged with its neigbors before
merging with next. If there is an uneven number of colors the middle
color is mixed with both left and right side.
}
\keyword{internal}
