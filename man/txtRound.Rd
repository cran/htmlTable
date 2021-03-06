% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/txtFrmt.R
\name{txtRound}
\alias{txtRound}
\alias{txtRound.default}
\alias{txtRound.data.frame}
\alias{txtRound.table}
\alias{txtRound.matrix}
\title{A convenient rounding function}
\usage{
txtRound(x, ...)

\method{txtRound}{default}(
  x,
  digits = 0,
  digits.nonzero = NA,
  txt.NA = "",
  dec = getOption("htmlTable.decimal_marker", default = "."),
  scientific = NULL,
  txtInt_args = getOption("htmlTable.round_int", default = NULL),
  ...
)

\method{txtRound}{data.frame}(x, ...)

\method{txtRound}{table}(x, ...)

\method{txtRound}{matrix}(x, digits = 0, excl.cols = NULL, excl.rows = NULL, ...)
}
\arguments{
\item{x}{The value/vector/data.frame/matrix to be rounded}

\item{...}{Passed to next method}

\item{digits}{The number of digits to round each element to.
If you provide a vector each element will apply to the corresponding columns.}

\item{digits.nonzero}{The number of digits to keep if the result is close to
zero. Sometimes we have an entire table with large numbers only to have a
few but interesting observation that are really interesting}

\item{txt.NA}{The string to exchange \code{NA} with}

\item{dec}{The decimal marker. If the text is in non-English decimal
and string formatted you need to change this to the appropriate decimal
indicator. The option for this is \code{htmlTable.decimal_marker}.}

\item{scientific}{If the value should be in scientific format.}

\item{txtInt_args}{A list of arguments to pass to \code{\link[=txtInt]{txtInt()}} if that is to be
used for large values that may require a thousands separator. The option
for this is \code{htmlTable.round_int}.}

\item{excl.cols}{Columns to exclude from the rounding procedure.
This can be either a number or regular expression. Skipped if \code{x} is a vector.}

\item{excl.rows}{Rows to exclude from the rounding procedure.
This can be either a number or regular expression.}
}
\value{
\code{matrix/data.frame}
}
\description{
If you provide a string value in X the function will try to round this if
a numeric text is present. If you want to skip certain rows/columns then
use the excl.* arguments.
}
\examples{
mx <- matrix(c(1, 1.11, 1.25,
               2.50, 2.55, 2.45,
               3.2313, 3, pi),
             ncol = 3, byrow=TRUE)
txtRound(mx, 1)
}
\seealso{
Other text formatters: 
\code{\link{txtInt}()},
\code{\link{txtMergeLines}()},
\code{\link{txtPval}()}
}
\concept{text formatters}
