% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/htmlTable_render_prAddEmptySpacerCell.R
\name{prAddEmptySpacerCell}
\alias{prAddEmptySpacerCell}
\title{Add an empty cell}
\usage{
prAddEmptySpacerCell(
  x,
  style_list,
  cell_style,
  align_style,
  cell_tag = c("td", "th"),
  colspan = 1
)
}
\arguments{
\item{x}{The matrix/data.frame with the data. For the \code{print} and \code{knit_print}
it takes a string of the class \code{htmlTable} as \code{x} argument.}

\item{cell_style}{The style of the current cell that should be applied to all cells}

\item{align_style}{The style from \code{\link[=prGetAlign]{prGetAlign()}}}

\item{cell_tag}{What HTML tag to use}

\item{colspan}{The number of rows each tag should span}
}
\value{
\code{string}
}
\description{
Depending on the \code{spacer.celltype} set in \code{\link[=addHtmlTableStyle]{addHtmlTableStyle()}} we
will use different spacer cells.
}
\seealso{
Other hidden helper functions for htmlTable: 
\code{\link{prAddCells}()},
\code{\link{prAddSemicolon2StrEnd}()},
\code{\link{prEscapeHtml}()},
\code{\link{prGetCgroupHeader}()},
\code{\link{prGetRowlabelPos}()},
\code{\link{prGetStyle}()},
\code{\link{prPrepInputMatrixDimensions}()},
\code{\link{prPrepareAlign}()},
\code{\link{prPrepareCgroup}()},
\code{\link{prTblNo}()}
}
\concept{hidden helper functions for htmlTable}
\keyword{internal}
