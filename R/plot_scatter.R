#' Plot a scatter chart
#'
#' @inheritParams plot_column
#' @param color Color of the points. Either a color string (e.g., `"blue"`,
#'   `"#021841"`) for a single static color, or a bare column name (without
#'   quotes) to map a grouping variable to color. Continuous numeric variables
#'   automatically use a continuous color scale.
#' @param fit Whether to draw a fitted line over the points.
#' @param fit_variable Whether to fit separate lines for groups mapped to
#'   `color`. Defaults to `FALSE`.
#' @param fit_method Smoothing method passed to [ggplot2::geom_smooth()].
#'   Defaults to `"auto"`.
#' @param fit_formula Formula passed to [ggplot2::geom_smooth()].
#' @param fit_color Color of the fitted regression line. Only applied when
#' `fit_variable = FALSE`. When `NULL` (default), uses automatic color selection.
#' When `fit_variable = TRUE`, the fit line colors are inherited from the
#' grouping variable and this parameter is ignored.
#' @param fit_ci Whether to draw the confidence interval around fitted lines.
#'   Defaults to `FALSE`.
#' @param zero Axis lines to draw. Choose `"x"`, `"y"`, `"both"`, or `"none"`
#'   (the default).
#' @param pal_name Name of the palette.
#' @param ... Additional arguments passed to [ggplot2::geom_point()].
#' @importFrom ggplot2 ggplot aes waiver geom_point geom_smooth
#' @importFrom cli cli_abort
#' @return A `ggplot` object.
#' @export
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' plot_scatter(data = mtcars, x = wt, y = mpg)
#'
#' # With regression line
#' plot_scatter(data = mtcars, x = wt, y = mpg, fit = TRUE)
#' \dontshow{options(.op)}
plot_scatter <- function(
  data,
  x,
  y,
  color = NULL,
  fit = FALSE,
  fit_variable = FALSE,
  fit_method = "auto",
  fit_formula = NULL,
  fit_color = NULL,
  fit_ci = FALSE,
  zero = "none",
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  ...
) {
  if (!zero %in% c("none", "x", "y", "both")) {
    cli::cli_abort(c(
      "{.arg zero} must be one of: {.val none}, {.val x}, {.val y}, or {.val both}.",
      "x" = "You provided: {.val {zero}}"
    ))
  }

  color_quo <- rlang::enquo(color)
  color_type <- detect_aesthetic_type(color_quo, "color", data)

  if (color_type$type == "variable_mapping") {
    p <- ggplot(
      data = data,
      aes(x = {{ x }}, y = {{ y }}, color = !!color_quo)
    )

    p <- plot_add_xy(p, type = zero)
    p <- p + geom_point(...)

    if (isTRUE(color_type$is_continuous)) {
      p <- p +
        scale_color_benvi_c(
          pal_name = pal_name,
          name = scale_name
        )
    } else {
      p <- p +
        scale_color_benvi_d(
          pal_name = pal_name,
          name = scale_name,
          labels = scale_label
        )
    }
  } else {
    static_color <- if (color_type$type == "static_color") {
      color_type$value
    } else {
      benvi_palette("benvi_blue", 1)
    }

    p <- ggplot(data = data, aes(x = {{ x }}, y = {{ y }}))
    p <- plot_add_xy(p, type = zero)
    p <- p + geom_point(color = static_color, ...)
  }

  if (isTRUE(fit)) {
    # When fit_variable is FALSE and fit_color is specified, use it
    if (!fit_variable && !is.null(fit_color)) {
      p <- p +
        geom_smooth(
          data = data,
          aes(x = {{ x }}, y = {{ y }}),
          method = fit_method,
          formula = fit_formula,
          se = fit_ci,
          color = fit_color,
          inherit.aes = FALSE
        )
    } else {
      p <- p +
        geom_smooth(
          data = data,
          aes(x = {{ x }}, y = {{ y }}),
          method = fit_method,
          formula = fit_formula,
          se = fit_ci,
          inherit.aes = fit_variable
        )
    }
  }

  p <- p + theme_benvi()

  return(p)
}

# Internal helper to add x/y axis lines to a ggplot.
#' @importFrom ggplot2 geom_hline geom_vline
plot_add_xy <- function(plot, type = "both") {
  plot <- switch(
    type,
    none = plot,
    x = plot + geom_hline(yintercept = 0),
    y = plot + geom_vline(xintercept = 0),
    both = plot + geom_hline(yintercept = 0) + geom_vline(xintercept = 0)
  )

  return(plot)
}
