#' A color palette for Benvi.
#'
#' Construction of the package is inspired by the [ghibli](https://github.com/ewenme/ghibli)
#' package.
#'
#' @param n Number of colors desired. Sets have 4 colors, Qual have 8 colors.
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed.
#' @param type Either "continuous" or "discrete". Continuous automatically
#' interpolates between the colors.
#' @param pal_name Name of the palette.
#' @return A vector of characters with color attribute
#' @export
#' @importFrom grDevices colorRampPalette rgb
#' @examples
#' benvi_palette("Set3")
#' benvi_palette("Set3", n = 20, type = "continuous")
#' benvi_palette("Set3", n = 2, type = "discrete")
benvi_palette <- function(
    pal_name,
    n,
    direction = 1,
    type = c("discrete", "continuous")) {

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  pal <- palette[[pal_name]]$hex
  if (is.null(pal)) {
    stop("Palette not found.")
  }

  if (missing(n)) {
    n <- length(pal)
  }

  type <- match.arg(type)

  if (type == "discrete" && n > length(pal)) {
    stop(
      paste0("Number of requested colors greater than what palette can offer, which is ",
      length(pal),
      "."))
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

#' @export
#' @importFrom graphics image par rect text
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}
