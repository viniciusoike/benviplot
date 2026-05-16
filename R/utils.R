#' Format numbers using Brazilian conventions
#'
#' @param x A numeric vector
#' @param digits Number of decimal places to include. Can be negative to round
#'   to tens, hundreds, etc.
#' @param percent Logical indicating if % symbol should be appended
#'
#' @description
#' Formats numbers using Brazilian locale conventions: period (.) as thousands
#' separator and comma (,) as decimal separator. This is a convenient wrapper
#' to both the `format` and `round` base functions to convert numeric vectors
#' into character labels for tables or plots.
#'
#' @details
#' Brazilian number formatting uses:
#' - Thousands separator: `.` (period)
#' - Decimal separator: `,` (comma)
#'
#' For example, 1234567.89 becomes "1.234.567,9" (with digits = 1).
#'
#' @return A character vector with formatted numbers
#' @importFrom cli cli_abort
#' @export
#'
#' @examples
#' # Basic formatting
#' x <- 1235134.123
#' format_num_br(x)
#'
#' # Different decimal places
#' format_num_br(x, digits = 3)
#' format_num_br(x, digits = 0)
#'
#' # With percentage
#' format_num_br(12.5, digits = 1, percent = TRUE)
#'
#' # Negative digits round to tens, hundreds, etc.
#' format_num_br(1234567, digits = -3)
#'
#' # Works with vectors
#' format_num_br(c(100, 1000, 10000))
format_num_br <- function(x, digits = 1, percent = FALSE) {

  # Input validation
  if (!is.numeric(x)) {
    cli::cli_abort(c(
      "{.arg x} must be numeric.",
      "x" = "You provided: {.type {x}}"
    ))
  }

  if (!is.numeric(digits) || length(digits) != 1) {
    cli::cli_abort(c(
      "{.arg digits} must be a single numeric value.",
      "x" = "You provided: {.val {digits}}"
    ))
  }

  if (!is.logical(percent) || length(percent) != 1) {
    cli::cli_abort(c(
      "{.arg percent} must be a single logical value (TRUE or FALSE).",
      "x" = "You provided: {.val {percent}}"
    ))
  }

  # Round number (note: digits can be negative)
  x <- round(x, digits = digits)
  # Brazilian standard number formatting
  x <- format(x, big.mark = ".", decimal.mark = ",")
  # Append % symbol if requested
  if (isTRUE(percent)) {
    x <- paste0(x, "%")
  }

  return(x)
}
