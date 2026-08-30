#' Format numbers using Brazilian conventions
#'
#' @param x A numeric vector.
#' @param digits Number of decimal places to include. Can be negative to round
#'   to tens, hundreds, etc.
#' @param percent Whether to append a percent sign.
#'
#' @description
#' Formats numbers with a period as the thousands separator and a comma as the
#' decimal separator. The result is suitable for labels in tables and plots.
#'
#' @details
#' Brazilian number formatting uses `.` as the thousands separator and `,` as
#' the decimal separator.
#'
#' For example, `1234567.89` becomes `"1.234.567,9"` when `digits = 1`.
#'
#' @return A character vector containing the formatted numbers.
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
  # Brazilian standard number formatting. scientific = FALSE keeps large values
  # readable ("100.000" rather than "1e+05"); trim = FALSE would left-pad every
  # element to a common width, which is wrong for plot and table labels.
  x <- format(
    x,
    big.mark = ".",
    decimal.mark = ",",
    scientific = FALSE,
    trim = TRUE
  )
  # Append % symbol if requested
  if (isTRUE(percent)) {
    x <- paste0(x, "%")
  }

  return(x)
}

#' Check if string is a valid color
#'
#' Validates hex colors and named colors recognized by R's graphics device.
#' Used internally by smart detection functions to distinguish between
#' static color strings and column names.
#'
#' @param x Character vector of length 1
#'
#' @return Logical. TRUE if x is a valid color specification, FALSE otherwise.
#' @keywords internal
#' @noRd
is_valid_color <- function(x) {
  if (!is.character(x) || length(x) != 1) {
    return(FALSE)
  }

  # Check hex color pattern (#RGB, #RRGGBB, #RRGGBBAA)
  # Must check hex BEFORE col2rgb because col2rgb is too permissive
  if (grepl("^#", x)) {
    # For hex colors, only accept standard formats
    return(grepl("^#([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$", x))
  }

  # Check if grDevices recognizes it as a named color
  tryCatch(
    {
      grDevices::col2rgb(x)
      return(TRUE)
    },
    error = function(e) {
      return(FALSE)
    }
  )
}

#' Detect if aesthetic parameter is static color or variable mapping
#'
#' Intelligently determines whether a user-provided aesthetic parameter (color/fill)
#' is a static color string ("blue", "#FF0000") or a variable mapping (column name
#' or expression). This enables intuitive API where both use cases work naturally.
#'
#' @param quo Quosure from rlang::enquo()
#' @param param_name Character. Parameter name for error messages (e.g., "color", "fill")
#' @param data Data frame to evaluate variable in (optional). If provided, enables
#'   detection of continuous vs discrete variables.
#'
#' @return List with:
#'   \itemize{
#'     \item type: "missing", "static_color", or "variable_mapping"
#'     \item value: The static color value (if type = "static_color")
#'     \item is_continuous: Logical (if type = "variable_mapping" and data provided)
#'   }
#'
#' @keywords internal
#' @noRd
#' @importFrom rlang enquo
detect_aesthetic_type <- function(quo, param_name = "parameter", data = NULL) {
  # Check if parameter was not provided
  if (rlang::quo_is_null(quo)) {
    return(list(type = "missing"))
  }

  expr <- rlang::quo_get_expr(quo)

  # Check if it's a string literal (static color)
  if (is.character(expr) && length(expr) == 1) {
    if (is_valid_color(expr)) {
      return(list(type = "static_color", value = expr))
    } else {
      cli::cli_abort(c(
        "{.arg {param_name}} = {.val {expr}} is not a valid color",
        "i" = "Use a bare column name for variable mapping: {.code {param_name} = column_name}",
        "i" = "Or use a valid color name/hex code: {.code {param_name} = \"blue\"}",
        "i" = "See {.code colors()} for valid color names"
      ))
    }
  }

  # It's a variable mapping (symbol or expression)
  # Detect if continuous or discrete
  is_continuous <- FALSE
  if (!is.null(data)) {
    tryCatch(
      {
        var_vals <- rlang::eval_tidy(quo, rlang::as_data_mask(data))
        is_continuous <- is.numeric(var_vals) && !is.factor(var_vals)
      },
      error = function(e) NULL
    )
  }

  return(list(
    type = "variable_mapping",
    is_continuous = is_continuous
  ))
}
