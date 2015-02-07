% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/htmlTable.R
\name{htmlTable}
\alias{htmlTable}
\alias{htmlTable.default}
\alias{knit_print.htmlTable}
\alias{print.htmlTable}
\title{Outputting HTML tables}
\usage{
htmlTable(x, ...)

\method{htmlTable}{default}(x, header, rnames, rowlabel, caption, tfoot, label,
  rgroup, n.rgroup, cgroup, n.cgroup, tspanner, n.tspanner, total,
  align = paste(rep("c", ncol(x)), collapse = ""),
  align.header = paste(rep("c", ncol(x)), collapse = ""), align.cgroup,
  css.rgroup = "font-weight: 900;", css.rgroup.sep = "",
  css.tspanner = "font-weight: 900; text-align: left;",
  css.tspanner.sep = "border-top: 1px solid #BEBEBE;",
  css.total = "border-top: 1px solid #BEBEBE; font-weight: 900;",
  css.cell = "", css.cgroup = "", css.class = "gmisc_table",
  pos.rowlabel = "bottom", pos.caption = "top", col.rgroup = "none",
  col.columns = "none", padding.rgroup = "&nbsp;&nbsp;",
  padding.tspanner = "", ctable = TRUE, compatibility = "LibreOffice",
  cspan.rgroup = "all", ...)

\method{knit_print}{htmlTable}(x, ...)

\method{print}{htmlTable}(x, useViewer, ...)
}
\arguments{
  \item{x}{The matrix/data.frame with the data. For the
  \code{print} and \code{knit_print} it takes a string of
  the class \code{htmlTable} as \code{x} argument.}

  \item{...}{Passed on to \code{print.htmlTable} function
  and any argument except the \code{useViewer} will be
  passed on to the \code{\link[base]{cat}} functions
  arguments.}

  \item{header}{A vector of character strings specifying
  column header, defaulting to
  \code{\link[base]{colnames}(x)}}

  \item{rnames}{Default rownames are generated from
  \code{\link[base]{rownames}(x)}. If you provide
  \code{FALSE} then it will skip the rownames. \emph{Note:}
  For \code{data.frames} if you do
  \code{\link[base]{rownames}(my_dataframe) <- NULL} it
  still has rownames. Thus you need to use \code{FALSE} if
  you want to surpress rownames for \code{data.frames}.}

  \item{rowlabel}{If the table has rownames or
  \code{rnames}, rowlabel is a character string containing
  the column heading for the \code{rnames}.}

  \item{caption}{Adds a table caption.}

  \item{tfoot}{Adds a table footer (uses the \code{<tfoot>}
  html element). The output is run through
  \code{\link{txtMergeLines}} simplifying the generation of
  multiple lines.}

  \item{label}{A text string representing a symbolic label
  for the table for referencing as an anchor. All you need
  to do is to reference the table, for instance \code{<a
  href="#anchor_name">see table 2</a>}. This is known as
  the element's id attribute, i.e. table id, in HTML
  linguo, and should be unique id for an HTML element in
  contrast to the \code{css.class} element attribute.}

  \item{rgroup}{A vector of character strings containing
  headings for row groups. \code{n.rgroup} must be present
  when \code{rgroup} is given. The first
  \code{n.rgroup[1]}rows are sectioned off and
  \code{rgroup[1]} is used as a bold heading for them. The
  usual row dimnames (which must be present if
  \code{rgroup} is) are indented. The next
  \code{n.rgroup[2]} rows are treated likewise, etc. If you
  don't want a row to be part of a row group then you just
  put "" for that row, remember to add the corresponding
  number of rows in n.rgroup.}

  \item{n.rgroup}{An integer vector giving the number of
  rows in each grouping. If \code{rgroup} is not specified,
  \code{n.rgroup} is just used to divide off blocks of rows
  by horizontal lines. If \code{rgroup} is given but
  \code{n.rgroup} is omitted, \code{n.rgroup} will default
  so that each row group contains the same number of rows.}

  \item{cgroup}{A vector or a matrix of character strings
  defining major column header. The default is to have
  none. These elements are also known as \emph{column
  spanners}. If you want a column \emph{not} to have a
  spanner then put that column as "". If you pass cgroup
  and \code{n.crgroup} as matrices you can have column
  spanners for several rows. See cgroup section below for
  details.}

  \item{n.cgroup}{An integer vector or matrix containing
  the number of columns for which each element in cgroup is
  a heading. For example, specify
  \code{cgroup=c("Major_1","Major_2")},
  \code{n.cgroup=c(3,3)} if \code{"Major_1"} is to span
  columns 1-3 and \code{"Major_2"} is to span columns 4-6.
  \code{rowlabel} does not count in the column numbers. You
  can omit \code{n.cgroup} if all groups have the same
  number of columns.}

  \item{tspanner}{The table spanner is somewhat of a table
  header that you can use when you want to join different
  tables with the same columns.}

  \item{n.tspanner}{An integer vector with the number of
  rows in the original matrix that the table spanner should
  span.}

  \item{total}{The last row is sometimes a row total with a
  border on top and bold fonts. Set this to \code{TRUE} if
  you are interested in such a row. If you want a total row
  at the end of each table spanner you can set this to
  \code{"tspanner"}.}

  \item{align}{A character strings specifying column
  alignments, defaulting to
  \code{\link[base]{paste}(rep('c',ncol(x)),collapse='')}
  to center. Valid alignments are l = left, c = center and
  r = right. You can also specify \code{align='c|c'} and
  other LaTeX tabular formatting. If you want to set the
  alignment of the rownames this string needst to be
  \code{ncol(x) + 1}, otherwise it automatically pads the
  string with a left alignment for the rownames.}

  \item{align.header}{A character strings specifying
  alignment for column header, defaulting to centered, i.e.
  \code{\link[base]{paste}(rep('c',ncol(x)),collapse='')}.}

  \item{align.cgroup}{The justification of the
  \code{cgroups}}

  \item{css.rgroup}{CSS style for the rgorup, if different
  styles are wanted for each of the rgroups you can just
  specify a vector with the number of elements}

  \item{css.rgroup.sep}{The line between different rgroups.
  The line is set to the TR element of the lower rgroup,
  i.e. you have to set the border-top/padding-top etc to a
  line with the expected function. This is only used for
  rgroups that are printed. You can specify different
  separators if you give a vector of rgroup - 1 length
  (this is since the first rgroup doesn't have a
  separator).}

  \item{css.tspanner}{The CSS style for the table spanner}

  \item{css.tspanner.sep}{The line between different
  spanners}

  \item{css.total}{The css of the total row}

  \item{css.cell}{The css.cell element allows you to add
  any possible CSS style to your table cells. If you
  provide a vector the vector it is assummed that the
  styles should be repeated throughout the columns. If you
  provide a matrix of the same size as your \code{x}
  argument. If have \code{ncol(x) + 1} the first row will
  correspond to the rowname style. Correspondingly if the
  size is \code{nrow(x) + 1} it is assummed that the first
  row is the header row.}

  \item{css.cgroup}{The same as \code{css.class} but for
  cgroup formatting.}

  \item{css.class}{The html CSS class for the table. This
  allows directing html formatting through
  \href{http://www.w3schools.com/css/css_selectors.asp}{CSS}
  directly at all instances of that class. \emph{Note:}
  unfortunately the CSS is frequently ignored by word
  processors. This option is mostly inteded for
  web-presentations.}

  \item{pos.rowlabel}{Where the rowlabel should be
  positioned. This value can be \code{"top"},
  \code{"bottom"}, \code{"header"}, or a integer between
  \code{1} and \code{nrow(cgroup) + 1}. The options
  \code{"bottom"} and \code{"header"} are the same, where
  the row label is presented at the same level as the
  header.}

  \item{pos.caption}{Set to \code{"bottom"} to position a
  caption below the table instead of the default of
  \code{"top"}.}

  \item{col.rgroup}{Alternating colors (zebra
  striping/banded rows) for each \code{rgroup}; one or two
  colors is recommended and will be recycled.}

  \item{col.columns}{Alternating colors for each column.}

  \item{padding.rgroup}{Generally two non-breakings spaces,
  i.e. \code{&nbsp;&nbsp;}, but some journals only have a
  bold face for the rgroup and leaves the subelements
  unindented.}

  \item{padding.tspanner}{The table spanner is usually
  without padding but you may specify padding similar to
  \code{padding.rgroup} and it will be added to all
  elements, including the rgroup elements. This allows for
  a 3-level hierarchy if needed.}

  \item{ctable}{If the table should have a double top
  border or a single a' la LaTeX ctable style}

  \item{compatibility}{Is default set to \code{LibreOffice}
  as some settings need to be in old html format as Libre
  Office can't handle some commands such as the css
  caption-alignment. Note: this option is not yet fully
  implemented for all details, in the future I aim to
  generate a html-correct table and one that is aimed at
  Libre Office compatibility. Word-compatibility is
  difficult as Word ignores most settings and destroys all
  layout attempts (at least that is how my 2010 version
  behaves).}

  \item{cspan.rgroup}{The number of columns that an
  \code{rgroup} should span. It spans by default all
  columns but you may want to limit this if you have column
  colors that you want to retain.}

  \item{useViewer}{If you are using RStudio there is a
  viewer thar can render the table within that is envoced
  if in \code{\link[base]{interactive}} mode. Set this to
  \code{FALSE} if you want to remove that functionality.
  You can also force the function to call a specific viewer
  by setting this to a viewer function, e.g.
  \code{useViewer = utils::browseUrl} if you want to
  override the default RStudio viewer. Another option that
  does the same is to set the
  \code{options(viewer=utils::browseUrl)} and it will
  default to that particular viewer (this is how RStudio
  decides on a viewer). \emph{Note:} If you want to force
  all output to go through the \code{\link[base]{cat}()}
  the set \code{\link[base]{options}(htmlTable.cat =
  TRUE)}.}
}
\value{
\code{string} Returns a string of class htmlTable
}
\description{
This is a function for outputting a more advanced table
than what \pkg{xtable}, \pkg{ztable}, or \pkg{knitr}'s
\code{\link[knitr]{kable}()} allows. It's aim is to provide
the \pkg{Hmisc} \code{\link[Hmisc]{latex}()} colgroup and
rowgroup functions in HTML. The html-output is designed for
maximum compatibility with LibreOffice/OpenOffice.
}
\section{Multiple rows of column spanners \code{cgroup}}{
  If you want to have a column spanner in multiple levels
  you can set the \code{cgroup} and \code{n.cgroup}
  arguments to matrices. If the different levels have
  different number of elements you need to set the ones
  that lack elements to NA. For instance \code{cgroup =
  rbind(c("first", "second", NA), c("a", "b", "c"))}. And
  the corresponding n,cgroup would be \code{n.cgroup =
  rbind(c(1, 2, NA), c(2, 1, 2))}. for a table consisting
  of 5 columns. The "first" spans the first two columns,
  the "second" spans the last three columns, "a" spans the
  first two, "b" the middle column, and "c" the last two
  columns.
}

\section{The add attribute to \code{rgroup}}{
  You can now have an additional element at the rgroup
  level by specifying the \code{att(rgroup, 'add')}. The
  value can either be a vector or a list of the same length
  as the rgroup or a list/vector with names corresponding
  to integers within the rgroup span.
}

\section{Important \pkg{knitr}-note}{
  This funciton will only work with \pkg{knitr} outputting
  \emph{html}, i.e. markdown mode. As the function returns
  raw html-code the compatibility with non-html formatting
  is limited, even with
  \href{http://johnmacfarlane.net/pandoc/}{pandoc}.

  Thanks to the the \code{\link[knitr]{knit_print}} and the
  \code{\link[knitr]{asis_output}} the
  \code{results='asis'} is \emph{no longer needed} except
  within for-loops. If you have a knitr-chunk with a for
  loop and use \code{print()} to produce raw html you must
  set the chunk option \code{results='asis'}. \code{Note}:
  the print-function relies on the
  \code{\link[base]{interactive}()} function for
  determining if the output should be sent to a browser or
  to the terminal. In vignettes and other directly knitted
  documents you may need to either set \code{useViewer =
  FALSE} alternatively set \code{options(htmlTable.cat =
  TRUE)}.
}

\section{Table counter}{
  If you set the option table_counter you will get a Table
  1,2,3 etc before each table, just set
  \code{options(table_counter=TRUE)}. If you set it to a
  number then that number will correspond to the start of
  the table_counter. The \code{table_counter} option will
  also contain the number of the last table, this can be
  useful when referencing it in text. By setting the option
  \code{options(table_counter_str = "<b>Table \%s:</b> ")}
  you can manipulate the counter table text that is added
  prior to the actual caption. Note, you should use the
  \code{\link{sprintf}} \code{\%s} instead of \code{\%d} as
  the software converts all numbers to characters for
  compatibility reasons. If you set
  \code{options(table_counter_roman = TRUE)} then the table
  counter will use Roman numumerals instead of Arabic.
}

\section{Possible issues}{
  Note that when using complex cgroup alignments with
  multiple levels not every browser is able to handle this.
  For instance the RStudio webkit browser seems to have
  issues with this and a
  \href{http://code.google.com/p/chromium/issues/detail?id=305130}{bug
  has been filed}.

  As the table uses html for rendering you need to be aware
  of that headers, rownames, and cell values should try
  respect this for optimal display. Browsers try to
  compensate and frequently the tables still turn out fine
  but it is not advized. Most importantly you should try to
  use \code{&lt;} instead of \code{<} and \code{&gt;}
  instead of \code{>}. You can find a complete list of html
  characters \href{http://ascii.cl/htmlcodes.htm}{here}.
}
\examples{
# A simple output
output <- matrix(1:4,
                 ncol=2,
                 dimnames = list(list("Row 1", "Row 2"),
                                 list("Column 1", "Column 2")))
htmlTable(output)

# An advanced output
output <-
  matrix(ncol=6, nrow=8)

for (nr in 1:nrow(output)){
  for (nc in 1:ncol(output)){
    output[nr, nc] <-
      paste0(nr, ":", nc)
  }
}

htmlTable(output, align="r",
          header =  paste(c("1st", "2nd",
                            "3rd", "4th",
                            "5th", "6th"),
                          "hdr"),
          rnames = paste(c("1st", "2nd",
                           "3rd",
                           paste0(4:8, "th")),
                         "row"),
          rgroup = paste("Group", LETTERS[1:3]),
          n.rgroup = c(2,4,nrow(output) - 6),
          cgroup = rbind(c("", "Column spanners", NA),
                         c("", "Cgroup 1", "Cgroup 2&dagger;")),
          n.cgroup = rbind(c(1,2,NA),
                           c(2,2,2)),
          caption="Basic table with both column spanners (groups) and row groups",
          tfoot="&dagger; A table footer commment",
          cspan.rgroup = 2,
          col.columns = c(rep("none", 2),
                          rep("#F5FBFF", 4)),
          col.rgroup = c("none", "#F7F7F7"),
          css.cell = "padding-left: .5em; padding-right: .2em;")

# See vignette("tables", package = "htmlTable")
# for more examples
}
\seealso{
\code{\link{txtMergeLines}}, \code{\link[Hmisc]{latex}}

Other table functions: \code{\link{tblNoLast}};
\code{\link{tblNoNext}}
}
