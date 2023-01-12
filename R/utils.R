#' Format a number as a label
#'
#' @param x A numeric vector
#' @param digits Number of decimal cases to include
#' @param percent Logical indicating if % should be pasted
#'
#' @description This is a convenient wrapper to both the `format` and the `round`
#' base functions to convert a numeric vector into a character of labels for
#' tables or plots.
#'
#' @return A character vector
#' @export
#'
#' @examples
#' x <- 1235134.123
#' pretty_number(x)
#' pretty_number(x, digits = 3)
#' pretty_number(x, digits = 1, percent = TRUE)
pretty_number <- function(x, digits = 1, percent = FALSE) {
  # Round number (note: digits can be negative)
  x <- round(x, digits = digits)
  # Brazilian standard number marking
  x <- format(x, big.mark = ".", decimal.mark = ",")
  # Pastes % symbol
  if (isTRUE(percent)) {x <- paste0(x, "%")}

  return(x)
}
