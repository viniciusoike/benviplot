#' A color palette for Benvi.
#'
#' Construction of the package is inspired by the [ghibli](https://github.com/ewenme/ghibli)
#' package.
#'
#' @param pal_name Name of the palette. Defaults to "qual_2".
#' @param n Number of colors desired. Sets have 4 colors, Qual have 8 colors.
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed.
#' @param type Either "continuous" or "discrete". Continuous automatically
#' interpolates between the colors.
#' @return A vector of characters with color attribute
#' @export
#' @importFrom grDevices colorRampPalette rgb
#' @importFrom cli cli_abort
#' @examples
#' # Use default palette
#' benvi_palette()
#'
#' # Specify palette name
#' benvi_palette("greens")
#' benvi_palette("greens", n = 20, type = "continuous")
#' benvi_palette("greens", n = 2, type = "discrete")
benvi_palette <- function(
  pal_name = "qual_2",
  n,
  direction = 1,
  type = c("discrete", "continuous")
) {
  if (abs(direction) != 1) {
    cli::cli_abort(c(
      "{.arg direction} must be 1 or -1.",
      "x" = "You provided: {direction}"
    ))
  }

  pal <- palette[[pal_name]]$hex
  if (is.null(pal)) {
    available_pals <- paste(names(palette), collapse = ", ")
    cli::cli_abort(c(
      "Palette {.val {pal_name}} not found.",
      "i" = "Available palettes: {available_pals}"
    ))
  }

  if (missing(n)) {
    n <- length(pal)
  }

  type <- match.arg(type)

  if (type == "discrete" && n > length(pal)) {
    cli::cli_abort(c(
      "Too many colors requested from palette {.val {pal_name}}.",
      "x" = "You requested {n} {cli::qty(n)}color{?s}.",
      "i" = "This palette only has {length(pal)} {cli::qty(length(pal))}color{?s}.",
      "i" = "Use {.code type = 'continuous'} to interpolate more colors."
    ))
  }

  out <- switch(
    type,
    continuous = colorRampPalette(pal)(n),
    discrete = pal[1:n]
  )

  if (direction == -1) {
    out <- rev(out)
  }

  structure(out, class = "palette", pal_name = pal_name)
}

pal_pal <- function(pal_name, direction) {
  function(n) {
    benvi_palette(pal_name = pal_name, direction = direction)
  }
}

#' Print a palette
#'
#' @keywords internal
#' @importFrom graphics image par
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(
    1:n,
    1,
    as.matrix(1:n),
    col = x,
    ylab = "",
    xaxt = "n",
    yaxt = "n",
    bty = "n"
  )
}
