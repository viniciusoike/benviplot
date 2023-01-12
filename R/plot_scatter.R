#' Plot a scatter chart
#' @inheritParams plot_column
#' @param color Color of the points
#' @param fit Logical indicating if a regression line should be plotted on top
#' of the chart.
#' @param fit_variable Logical indicating if regression should be grouped.
#' Defaults to `FALSE`.
#' @param fit_method Type of model to generate regression line. See `geom_smooth`
#' for more control and details. Defaults to `"auto"`.
#' @param fit_formula A formula for fit_method. See `geom_smooth`.
#' @param fit_ci Logical indicating if confidence interval should be plotted.
#' Defaults to `FALSE` for less cluttered visualization.
#' @param zero Draws axis lines. Must be one of `"x"`, `"y"`, `"both"`, or
#' `"none"` (default).
#' @param ... Further arguments to `geom_point`
#' @importFrom ggplot2 ggplot aes waiver geom_point geom_smooth
#' @return A ggplot2 plot.
#' @export
plot_scatter <- function(
    data,
    x,
    y,
    color,
    variable,
    fit = FALSE,
    fit_variable = FALSE,
    fit_method = "auto",
    fit_formula = NULL,
    fit_ci = FALSE,
    zero = "none",
    pal = "Qual9",
    scale_name = "",
    scale_label = ggplot2::waiver(),
    ...) {

  stopifnot("Argument zero must be one of: none, x, y, or both." =
              any(zero %in% c("none", "x", "y", "both")))


  if (missing(variable)) {

    if (missing(color)) {

      color <- benvi_palette("Basic", 1)

    }

    p <- ggplot(data = data, aes(x = {{ x }}, y = {{ y }}))
    p <- plot_add_xy(p, type = zero)
    p <- p + geom_point(color = color, ...)

  } else {

    p <- ggplot(
      data = data,
      aes(x = {{ x }}, y = {{ y }}, color = {{ variable }})
      )

    p <- plot_add_xy(p, type = zero)
    p <- p + geom_point(...)
    p <- p + scale_color_benvi_d(
      pal_name = pal,
      name = scale_name,
      labels = scale_label
    )

  }

  if (isTRUE(fit)) {
    p <- p + geom_smooth(
      data = data,
      aes(x = {{ x }}, y = {{ y }}),
      method = fit_method,
      formula = fit_formula,
      se = fit_ci,
      inherit.aes = fit_variable
    )
  }

  p <- p + theme_benvi()

  return(p)
}

#' Add axis to a plot
#'
#' Helper function to add axis to a plot.
#' @param plot A `ggplot` object
#' @param type One of `"none"`, `"x"`, `"y"`, or `"both"` (default)
#' @export
#' @importFrom ggplot2 geom_hline geom_vline
plot_add_xy <- function(plot, type = "both") {

  if (type == "none") {
    plot <- plot
  }

  if (type == "x") {
    plot <- plot + geom_hline(yintercept = 0)
  }

  if (type == "y") {
    plot <- plot + geom_vline(xintercept = 0)
  }

  if (type == "both") {
    plot <- plot + geom_hline(yintercept = 0) + geom_vline(xintercept = 0)
  }

  return(plot)
}
