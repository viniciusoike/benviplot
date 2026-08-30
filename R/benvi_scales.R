#' Discrete Benvi color scales
#'
#' Map discrete values to colors from a Benvi palette.
#'
#' @rdname ggplot2-scales-discrete
#' @param pal_name Name of the palette. Defaults to `"qual_benvi"`.
#' @param direction Either `1` or `-1`. Use `-1` to reverse the palette.
#' @param ... Additional arguments passed to [ggplot2::discrete_scale()].
#'
#' @return A discrete ggplot2 scale that can be added to a `ggplot` object.
#'
#' @examples
#' library(ggplot2)
#' # Discrete color scale with rental index data
#' iqaiw_total <- subset(iqaiw, rooms == "Total")
#' ggplot(iqaiw_total, aes(x = date, y = index, colour = name_muni)) +
#'   geom_line() +
#'   scale_color_benvi_d("qual_benvi")
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
    ...
  )
}

#' @rdname ggplot2-scales-discrete
#' @export
scale_color_benvi_d <- scale_colour_benvi_d


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
    ...
  )
}

#' Continuous Benvi color scales
#'
#' Map continuous values to colors interpolated from a Benvi palette.
#'
#' @param ... Additional arguments passed to
#'   [ggplot2::scale_colour_gradientn()] or [ggplot2::scale_fill_gradientn()].
#' @param pal_name Name of the palette. Defaults to `"benvi_blue"`.
#' @param direction Either `1` or `-1`. Use `-1` to reverse the palette.
#'
#' @return A continuous ggplot2 scale that can be added to a `ggplot` object.
#'
#' @name ggplot2-scales-continuous
#' @rdname ggplot2-scales-continuous
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
#'   geom_point() +
#'   scale_color_benvi_c("benvi_blue")
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
      type = "continuous"
    ),
    ...
  )
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
      type = "continuous"
    ),
    ...
  )
}
