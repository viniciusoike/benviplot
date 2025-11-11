#' Discrete scales to use for ggplot2
#'
#' Functions to use `ggplot2` scales with Benvi colors.
#'
#' @rdname ggplot2-scales-discrete
#' @param pal_name Name of the palette. Defaults to "qual_benvi".
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed.
#' @param ... additional arguments to pass to discrete_scale
#'
#' @examples
#' \dontrun{
#' if (require('ggplot2')) {
#'   # Discrete color scale with rental index data
#'   iqaiw_total <- subset(iqaiw, rooms == "Total")
#'   ggplot(iqaiw_total, aes(x = date, y = index, colour = name_muni)) +
#'     geom_line() +
#'     scale_color_benvi_d("qual_benvi")
#' }
#' }
#'
#' @export
#' @importFrom ggplot2 discrete_scale
#' @importFrom cli cli_abort
scale_colour_benvi_d <- function(pal_name = "qual_benvi", direction = 1, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg ggplot2} is required.",
      "i" = "Install with: {.code install.packages('ggplot2')}"
    ))
  }

  ggplot2::discrete_scale(
    "colour",
    palette = pal_pal(pal_name = pal_name, direction = direction),
    ...)

}

#' @rdname ggplot2-scales-discrete
#' @export
scale_color_benvi_d <- scale_colour_benvi_d


#' @param pal_name Name of the palette.
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed.
#' @rdname ggplot2-scales-discrete
#' @export
#' @importFrom ggplot2 discrete_scale
#' @importFrom cli cli_abort
scale_fill_benvi_d <- function(pal_name = "qual_benvi", direction = 1, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg ggplot2} is required.",
      "i" = "Install with: {.code install.packages('ggplot2')}"
    ))
  }

  ggplot2::discrete_scale(
    "fill",
    palette = pal_pal(pal_name = pal_name, direction = direction),
    ...)

}

#' Continuous scales to use for ggplot2
#'
#' These functions provide the option to use Benvi colors inside continuous
#' palettes with the `ggplot2` package.
#'
#'
#' @param ... Arguments to pass on to `ggplot2::scale_colour_gradientn()` or
#' `ggplot2::scale_fill_gradientn()`
#' @inheritParams benvi_palette
#'
#' @return A `ScaleContinuous` object that can be added to a `ggplot` object
#'
#' @name ggplot2-scales-continuous
#' @rdname ggplot2-scales-continuous
#'
#' @examples
#' \dontrun{
#' if (require('ggplot2')) {
#'   # Continuous color scale with sales data
#'   ggplot(sales_report, aes(x = price_m2_listing,
#'                            y = price_m2_contract,
#'                            colour = price_m2_listing)) +
#'     geom_point() +
#'     scale_colour_benvi_c("benvi_blue")
#' }
#' }
#'
#' @export
#' @importFrom ggplot2 scale_colour_gradientn
#' @importFrom cli cli_abort
scale_colour_benvi_c <- function(pal_name = "benvi_blue", direction = 1, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg ggplot2} is required.",
      "i" = "Install with: {.code install.packages('ggplot2')}"
    ))
  }

  ggplot2::scale_colour_gradientn(
    colours = benvi_palette(
      pal_name = pal_name,
      direction = direction,
      n = 256,
      type = "continuous"),
    ...)
}

#' @rdname ggplot2-scales-continuous
#' @export
#'
scale_color_benvi_c <- scale_colour_benvi_c
#' @rdname ggplot2-scales-continuous
#' @export
#' @importFrom ggplot2 scale_fill_gradientn
#' @importFrom cli cli_abort
scale_fill_benvi_c <- function(pal_name = "benvi_blue", direction = 1, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg ggplot2} is required.",
      "i" = "Install with: {.code install.packages('ggplot2')}"
    ))
  }

  ggplot2::scale_fill_gradientn(
    colours = benvi_palette(
      pal_name = pal_name,
      direction = direction,
      n = 256,
      type = "continuous"),
    ...)
}
