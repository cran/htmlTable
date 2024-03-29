% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyHtmlTable.R
\name{tidyHtmlTable}
\alias{tidyHtmlTable}
\title{Generate an htmlTable using tidy data as input}
\usage{
tidyHtmlTable(
  x,
  value,
  header,
  rnames,
  rgroup,
  hidden_rgroup,
  cgroup,
  tspanner,
  hidden_tspanner,
  skip_removal_warning = getOption("htmlTable.skip_removal_warning", FALSE),
  rnames_unique,
  table_fn = htmlTable,
  ...
)
}
\arguments{
\item{x}{Tidy data used to build the \code{htmlTable}}

\item{value}{Column containing values for individual table cells. Defaults to "value" (same as \link[tidyr:pivot_wider]{tidyr::pivot_wider}).}

\item{header}{Column in \code{x} specifying column headings}

\item{rnames}{Column in \code{x} specifying row names. Defaults to "name" (same as \code{\link[tidyr:pivot_wider]{tidyr::pivot_wider()}}).}

\item{rgroup}{Column in \code{x} specifying row groups.}

\item{hidden_rgroup}{Strings indicating \code{rgroup} values to be hidden.}

\item{cgroup}{Columns in \code{x} specifying the column groups.}

\item{tspanner}{Column in \code{x} specifying \code{tspanner} groups.}

\item{hidden_tspanner}{Strings indicating \code{tspanner} values to be hidden.}

\item{skip_removal_warning}{Boolean to suppress warnings when removing \code{NA} columns.}

\item{rnames_unique}{Designates unique row names when regular names lack uniqueness.}

\item{table_fn}{Function to format the table, defaults to \code{\link[=htmlTable]{htmlTable()}}.}

\item{...}{Additional arguments passed to \code{\link[=htmlTable]{htmlTable()}}.}
}
\value{
Returns the HTML code that, when rendered, displays a formatted table.
}
\description{
This function maps columns from the input data, \code{x}, to \code{\link[=htmlTable]{htmlTable()}} parameters.
It's designed to provide a fluent interface for those familiar with the \code{tidyverse} ecosystem.
}
\section{Column-mapping}{


Columns from \code{x} are mapped (transformed) to specific parameters of the \code{\link[=htmlTable]{htmlTable()}}
The following columns are converted to match the intended input structure:
\itemize{
\item \code{value}
\item \code{header}
\item \code{rnames}
\item \code{rgroup}
\item \code{cgroup}
\item \code{tspanner}
}

Each combination of the variables in \code{x} should be unique to map correctly to the output table.
}

\section{Row uniqueness}{


Usually each row should have a unique combination of the mappers.
Sometimes though rows come in a distinct order and the order identifies
the row more than the name. E.g. if we are identifying bone fractures using the
AO-classification we will have classes ranging in the form of:
\itemize{
\item A
\item A1
\item A1.1
\item A2
\item A2.1
\item A2.2
\item B
\item ...
}

we can simplify the names while retaining the key knowledge to:
\itemize{
\item A
\item .1
\item ...1
\item .2
\item ...1
\item ...2
\item B
\item ...
}

This will though result in non-unique rows and thus we need to provide the original
names in addition to the \code{rnames} argument. To do this we have \code{rnames_unique} as a parameter,
without this \code{tidyHtmlTable} we risk unintended merging of cells, generating > 1 value per cell.

\emph{Note} it is recommended that you verify with the full names just to make sure that
any unexpected row order change has happened in the underlying pivot functions.
}

\section{Sorting}{


Rows can be pre-sorted using \code{\link[dplyr:arrange]{dplyr::arrange()}} before passing to \code{tidyHtmlTable}.
Column sorting is based on \code{arrange(cgroup, header)}. If you want to sort in non-alphabetic
order you can provide a factor variable and that information will be retained.
}

\section{Hidden values}{


\code{htmlTable} Allows for some values within \code{rgroup},
\code{cgroup}, etc. to be specified as \code{""}. The following parameters
allow for specific values to be treated as if they were a string of length
zero in the \code{htmlTable} function.
\itemize{
\item \code{hidden_rgroup}
\item \code{hidden_tspanner}
}
}

\section{Simple tibble output}{


The tibble discourages the use of row names. There is therefore a convenience
option for \code{tidyHtmlTable} where you can use the function just as you
would with \code{\link[=htmlTable]{htmlTable()}} where \code{rnames} is populated with
the \code{rnames} argument provided using \code{tidyselect} syntax (defaults to
the "names" column if present int the input data).
}

\section{Additional dependencies}{


In order to run this function you also must have \pkg{dplyr},
\pkg{tidyr}, \pkg{tidyselect} and \pkg{purrr}
packages installed. These have been removed due to
the additional 20 Mb that these dependencies added (issue #47).
\emph{Note:} if you use \pkg{tidyverse} it will already have
all of these and you do not need to worry.
}

\examples{
library(tibble)
library(dplyr)
library(tidyr)

# Prep and select basic data
data("mtcars")
base_data <- mtcars \%>\%
  rownames_to_column() \%>\%
  mutate(gear = paste(gear, "Gears"),
         cyl = paste(cyl, "Cylinders")) \%>\%
  select(rowname, cyl, gear, wt, mpg, qsec)

base_data \%>\%
  pivot_longer(names_to = "per_metric",
               cols = c(wt, mpg, qsec)) \%>\%
  group_by(cyl, gear, per_metric) \%>\%
  summarise(value_Mean = round(mean(value), 1),
            value_Min = round(min(value), 1),
            value_Max = round(max(value), 1),
            .groups = "drop") \%>\%
  pivot_wider(names_from = per_metric,
              values_from = starts_with("value_")) \%>\%
  # Round the values into a nicer format where we want the weights to have two decimals
  txtRound(ends_with("_wt"), digits = 2) \%>\%
  txtRound(starts_with("value") & !ends_with("_wt"), digits = 1) \%>\%
  # Convert into long format
  pivot_longer(cols = starts_with("value_"), names_prefix = "value_") \%>\%
  separate(name, into = c("summary_stat", "per_metric")) \%>\%
  # Without sorting the row groups wont appear right
  # If the columns end up in the wrong order you may want to change the columns
  # into factors
  arrange(per_metric) \%>\%
  addHtmlTableStyle(align = "r") \%>\%
  tidyHtmlTable(
    header = gear,
    cgroup = cyl,
    rnames = summary_stat,
    rgroup = per_metric,
    skip_removal_warning = TRUE)
}
\seealso{
\code{\link[=htmlTable]{htmlTable()}}
}
