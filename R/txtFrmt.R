#' A merges lines while preserving the line break for HTML/LaTeX
#'
#' This function helps you to do a table header with multiple lines
#' in both HTML and in LaTeX. In HTML this isn't that tricky, you just use
#' the `<br />` command but in LaTeX I often find
#' myself writing `vbox`/`hbox` stuff and therefore
#' I've created this simple helper function
#'
#' @param ... The lines that you want to be joined
#' @param html If HTML compatible output should be used. If `FALSE`
#'  it outputs LaTeX formatting. Note if you set this to 5
#'  then the HTML5 version of *br* will be used: `<br>`
#'  otherwise it uses the `<br />` that is compatible
#'  with the XHTML-formatting.
#' @return string
#'
#' @examples
#' txtMergeLines("hello", "world")
#' txtMergeLines("hello", "world", html=FALSE)
#' txtMergeLines("hello", "world", list("A list", "is OK"))
#'
#' @family text formatters
#' @export
txtMergeLines <- function(..., html = 5){
  strings <- c()
  for (i in list(...)) {
    if (is.list(i)) {
      for (c in i)
        strings <- append(strings, i)
    }else{
      strings <- append(strings, i)
    }

  }
  if (length(strings) == 0) {
    return("")
  }

  if (length(strings) == 1) {
    strings <- gsub("\n", ifelse(html == 5, "<br>\n", "<br />\n"), strings)
    return(strings)
  }

  ret <- ifelse(html != FALSE, "", "\\vbox{")
  first <- TRUE
  for (line in strings) {
    line <- as.character(line)
    if (first)
      ret <- paste0(ret, ifelse(html != FALSE, line, sprintf("\\hbox{\\strut %s}", line)))
    else
      ret <- paste0(ret, ifelse(html != FALSE,
                                paste(ifelse(html == 5, "<br>\n", "<br />\n"),
                                      line),
                                sprintf("\\hbox{\\strut %s}", line)))
    first <- FALSE
  }
  ret <- ifelse(html, ret, paste0(ret, "}"))

  return(ret)
}

#' SI or English formatting of an integer
#'
#' English uses ',' between every 3 numbers while the
#' SI format recommends a ' ' if x > 10^4. The scientific
#' form 10e+? is furthermore avoided.
#'
#' @param x The integer variable
#' @param language The ISO-639-1 two-letter code for the language of
#'  interest. Currently only English is distinguished from the ISO
#'  format using a ',' as the separator.
#' @param html If the format is used in HTML context
#'  then the space should be a non-breaking space, `&nbsp;`
#' @param ... Passed to [base::format()]
#' @return `string`
#'
#' @examples
#' txtInt(123)
#'
#' # Supplying a matrix
#' txtInt(matrix(c(1234, 12345, 123456, 1234567), ncol = 2))
#'
#' # Missing are returned as empty strings, i.e. ""
#' txtInt(c(NA, 1e7))
#'
#' @family text formatters
#' @export
txtInt <- function(x, language = "en", html = TRUE, ...){
  if (length(x) > 1) {
    ret <- sapply(x, txtInt, language = language, html = TRUE, ...)
    if (is.matrix(x)) {
      ret <- matrix(ret, nrow = nrow(x))
      rownames(ret) <- rownames(x)
      colnames(ret) <- colnames(x)
    }
    return(ret)
  }
  if (is.na(x)) return('')

  if (abs(x - round(x)) > .Machine$double.eps^0.5 &&
        !"nsmall" %in% names(list(...)))
    warning("The function can only be served integers, '", x, "' is not an integer.",
            " There will be issues with decimals being lost if you don't add the nsmall parameter.")

  if (language == "en")
    return(format(x, big.mark = ",", scientific = FALSE, ...))

  if (x >= 10^4)
    return(format(x,
                  big.mark = ifelse(html, "&nbsp;", " "),
                  scientific = FALSE, ...))

  return(format(x, scientific = FALSE, ...))
}


#' Formats the p-values
#'
#' Gets formatted p-values. For instance
#' you often want `0.1234` to be `0.12` while also
#' having two values up until a limit,
#' i.e. `0.01234` should be `0.012` while
#' `0.001234` should be `0.001`. Furthermore you
#' want to have `< 0.001` as it becomes ridiculous
#' to report anything below that value.
#'
#' @param pvalues The p-values
#' @param lim.2dec The limit for showing two decimals. E.g.
#'  the p-value may be `0.056` and we may want to keep the two decimals in order
#'  to emphasize the proximity to the all-mighty `0.05` p-value and set this to
#'  \eqn{10^-2}. This allows that a value of `0.0056` is rounded to `0.006` and this
#'  makes intuitive sense as the `0.0056` level as this is well below
#'  the `0.05` value and thus not as interesting to know the exact proximity to
#'  `0.05`. *Disclaimer:* The `0.05`-limit is really silly and debated, unfortunately
#'  it remains a standard and this package tries to adapt to the current standards in order
#'  to limit publication associated issues.
#' @param lim.sig The significance limit for the less than sign, i.e. the '`<`'
#' @param html If the less than sign should be `<` or `&lt;` as needed for HTML output.
#' @param ... Currently only used for generating warnings of deprecated call parameters.
#' @return vector
#'
#' @examples
#' txtPval(c(0.10234,0.010234, 0.0010234, 0.000010234))
#' @family text formatters
#' @rdname txtPval
#' @export
txtPval <- function(pvalues,
                    lim.2dec = 10^-2,
                    lim.sig = 10^-4,
                    html=TRUE, ...){

  if (is.logical(html))
    html <- ifelse(html, "&lt; ", "< ")
  sapply(pvalues, function(x, lim.2dec, lim.sig, lt_sign) {
    if (is.na(as.numeric(x))) {
      warning("The value: '", x, "' is non-numeric and txtPval",
              " can't therefore handle it")
      return(x)
    }

    if (x < lim.sig)
      return(sprintf("%s%s", lt_sign, format(lim.sig, scientific = FALSE)))

    if (x > lim.2dec)
      return(format(x,
                    digits = 2,
                    nsmall = -floor(log10(x)) + 1))

    return(format(x, digits = 1, scientific = FALSE))
  }, lim.sig = lim.sig,
  lim.2dec = lim.2dec,
  lt_sign = html)
}

#' A convenient rounding function
#'
#' If you provide a string value in X the function will try to round this if
#' a numeric text is present. If you want to skip certain rows/columns then
#' use the excl.* arguments.
#'
#' @param x The value/vector/data.frame/matrix to be rounded
#' @param digits The number of digits to round each element to.
#'  If you provide a vector each element will apply to the corresponding columns.
#' @param digits.nonzero The number of digits to keep if the result is close to
#'  zero. Sometimes we have an entire table with large numbers only to have a
#'  few but interesting observation that are really interesting
#' @param excl.cols Columns to exclude from the rounding procedure.
#'  This can be either a number or regular expression. Skipped if `x` is a vector.
#' @param excl.rows Rows to exclude from the rounding procedure.
#'  This can be either a number or regular expression.
#' @param txt.NA The string to exchange `NA` with
#' @param dec The decimal marker. If the text is in non-English decimal
#'  and string formatted you need to change this to the appropriate decimal
#'  indicator. The option for this is `htmlTable.decimal_marker`.
#' @param scientific If the value should be in scientific format.
#' @param txtInt_args A list of arguments to pass to [txtInt()] if that is to be
#'  used for large values that may require a thousands separator. The option
#'  for this is `htmlTable.round_int`.
#' @param ... Passed to next method
#' @return `matrix/data.frame`
#'
#' @examples
#' mx <- matrix(c(1, 1.11, 1.25,
#'                2.50, 2.55, 2.45,
#'                3.2313, 3, pi),
#'              ncol = 3, byrow=TRUE)
#' txtRound(mx, 1)
#' @export
#' @rdname txtRound
#' @importFrom stringr str_split str_replace
#' @family text formatters
txtRound <- function(x, ...){
  UseMethod("txtRound")
}

#' @export
#' @rdname txtRound
txtRound.default = function(x,
                            digits = 0,
                            digits.nonzero = NA,
                            txt.NA = "",
                            dec = getOption("htmlTable.decimal_marker", default = "."),
                            scientific = NULL,
                            txtInt_args = getOption("htmlTable.round_int",
                                                    default = NULL),
                            ...){
  if (length(digits) != 1 & length(digits) != length(x))
    stop("You have ",
         length(digits),
         " digits specifications but a vector of length ",
         length(x),
         ": ",
         paste(x, collapse = ", "))

  if (length(x) > 1) {
    return(mapply(txtRound.default,
                  x = x,
                  digits = digits,
                  digits.nonzero = digits.nonzero,
                  txt.NA = txt.NA,
                  dec = dec,
                  ...))
  }

  if (!is.na(digits.nonzero)) {
    if (!is.numeric(digits.nonzero)
        || floor(digits.nonzero) != digits.nonzero
    ) {
      stop("The digits.nonzero should be an integer, you provided: ", digits.nonzero)
    }
    if (digits.nonzero < digits) {
      stop("The digits.nonzero must be larger than digits, as it is used for allowing more 0 when encountering small numbers.",
           " For instance, if we have 10.123 we rarely need more than 10.1 in form of digits while a for a small number",
           " such as 0.00123 we may want to report 0.001 (i.e. digits = 1, digits.nonzero = 3)")
    }
  }

  dec_str <- sprintf("^[^0-9\\%s-]*([\\-]{0,1}(([0-9]*|[0-9]+[ 0-9]+)[\\%s]|)[0-9]+(e[+]{0,1}[0-9]+|))(|[^0-9]+.*)$",
                     dec, dec)
  if (is.na(x))
    return(txt.NA)
  if (!is.numeric(x) &&
      !grepl(dec_str, x))
    return(x)

  if (is.character(x) && grepl(dec_str, x)) {
    if (dec != ".")
      x <- gsub(dec, ".", x)
    if (grepl("[0-9.]+e[+]{0,1}[0-9]+", x) && is.null(scientific)) {
      scientific <- TRUE
    }

    # Select the first occurring number
    # remove any spaces indicating thousands
    # and convert to numeric
    x <-
      sub(dec_str, "\\1", x) %>%
      gsub(" ", "", .) %>%
      as.numeric
  }

  if (!is.na(digits.nonzero)) {
    decimal_position <- floor(log10(abs(x)))
    if (decimal_position < -digits && decimal_position >= -digits.nonzero) {
      digits <- -decimal_position
    }
  }

  if (round(x, digits) == 0)
    x <- 0

  if (!is.null(scientific) && scientific) {
    x <- round(x, digits)
    return(format(x, scientific = TRUE))
  }

  ret <- sprintf(paste0("%.", digits, "f"), x)
  if (is.null(txtInt_args)) {
    return(ret)
  }

  stopifnot(is.list(txtInt_args))

  separator <- str_replace(ret, "^[0-9]*([.,])[0-9]*$", "\\1")
  # There is no decimal
  if (separator == ret) {
    int_section <- as.numeric(ret)
    txtInt_args$x <- int_section
    return(do.call(txtInt, txtInt_args))
  }

  ret_sections <- str_split(ret, paste0("[", separator, "]"))[[1]]
  if (length(ret_sections) == 1) {
    return(ret)
  }

  if (length(ret_sections) != 2) {
    return(ret)
  }

  int_section <- as.numeric(ret_sections[1])
  txtInt_args$x <- int_section
  int_section <- do.call(txtInt, txtInt_args)
  return(paste0(int_section, separator, ret_sections[2]))
}

#' @export
#' @rdname txtRound
txtRound.data.frame <- function(x, ...){
  i <- sapply(x, is.factor)
  if (any(i)) {
    x[i] <- lapply(x[i], as.character)
  }

  x <- as.matrix(x)
  x <- txtRound.matrix(x, ...)

  return(as.data.frame(x, stringsAsFactors = FALSE))
}

#' @rdname txtRound
#' @export
txtRound.table <- function(x, ...){
  if (is.na(ncol(x))) {
    dim(x) <- c(1, nrow(x))
  }
  return(txtRound.matrix(x, ...))
}

#' @rdname txtRound
#' @export
txtRound.matrix <- function(x, digits = 0, excl.cols = NULL, excl.rows = NULL, ...){
  if (length(dim(x)) > 2)
    stop("The function only accepts vectors/matrices/data.frames as primary argument")

  rows <- 1L:nrow(x)
  if (!is.null(excl.rows)) {
    if (is.character(excl.rows)) {
      excl.rows <- grep(excl.rows, rownames(x))
    }

    if (length(excl.rows) > 0)
      rows <- rows[-excl.rows]
  }

  cols <- 1L:(ifelse(is.na(ncol(x)), 1, ncol(x)))
  if (!is.null(excl.cols)) {
    if (is.character(excl.cols)) {
      excl.cols <- grep(excl.cols, colnames(x))
    }

    if (length(excl.cols) > 0)
      cols <- cols[-excl.cols]
  }

  if (length(cols) == 0)
    stop("No columns to round")

  if (length(rows) == 0)
    stop("No rows to round")

  if (length(digits) != 1 & length(digits) != length(cols))
    stop("You have ",
         length(digits),
         " digits specifications but ",
         length(cols),
         " columns to apply them to: ",
         paste(cols, collapse = ", "))

  ret_x <- x
  for (row in rows) {
    ret_x[row, cols] <-
      mapply(txtRound,
             x = x[row, cols],
             digits = digits,
             ...,
             USE.NAMES = FALSE)
  }

  return(ret_x)
}
