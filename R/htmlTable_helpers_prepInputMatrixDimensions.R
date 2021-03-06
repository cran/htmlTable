#' Makes sure the input is correct
#'
#' Checks and converts dimensions into something the
#' [htmlTable()] is comfortable with.
#'
#' @inheritParams htmlTable
#' @keywords internal
#' @family hidden helper functions for htmlTable
prPrepInputMatrixDimensions <- function(x, header = NULL) {
  if (!is.null(dim(x))) {
    if (length(dim(x)) != 2) {
      stop(
        "Your table variable seems to have the wrong dimension,",
        " length(dim(x)) = ", length(dim(x)), " != 2"
      )
    }
    return(x)
  }

  preset_styles <- getHtmlTableStyle(x)

  if (!is.numeric(x) && !is.character(x)) {
    x <- as.character(x)
  }

  ncol <- length(x)
  if (!is.null(header)) {
    ncol <- length(header)
  }

  ret <- matrix(x, ncol = ncol)

  # We need to make sures that the style info has been retained throughout
  attr(ret, style_attribute_name) <- preset_styles
  return(ret)
}
