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
#' @param fit_color Color of the fitted regression line. Only applied when
#' `fit_variable = FALSE`. When `NULL` (default), uses automatic color selection.
#' When `fit_variable = TRUE`, the fit line colors are inherited from the
#' grouping variable and this parameter is ignored.
#' @param fit_ci Logical indicating if confidence interval should be plotted.
#' Defaults to `FALSE` for less cluttered visualization.
#' @param zero Draws axis lines. Must be one of `"x"`, `"y"`, `"both"`, or
#' `"none"` (default).
#' @param ... Further arguments to `geom_point`
#' @importFrom ggplot2 ggplot aes waiver geom_point geom_smooth
#' @importFrom cli cli_abort
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
    fit_color = NULL,
    fit_ci = FALSE,
    zero = "none",
    palette = "qual_benvi",
    scale_name = "",
    scale_label = ggplot2::waiver(),
    ...) {

  if (!zero %in% c("none", "x", "y", "both")) {
    cli::cli_abort(c(
      "{.arg zero} must be one of: {.val none}, {.val x}, {.val y}, or {.val both}.",
      "x" = "You provided: {.val {zero}}"
    ))
  }


  if (missing(variable)) {

    if (missing(color)) {

      color <- benvi_palette("benvi_blue", 1)

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
      pal_name = palette,
      name = scale_name,
      labels = scale_label
    )

  }

  if (isTRUE(fit)) {
    # When fit_variable is FALSE and fit_color is specified, use it
    if (!fit_variable && !is.null(fit_color)) {
      p <- p + geom_smooth(
        data = data,
        aes(x = {{ x }}, y = {{ y }}),
        method = fit_method,
        formula = fit_formula,
        se = fit_ci,
        color = fit_color,
        inherit.aes = FALSE
      )
    } else {
      p <- p + geom_smooth(
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

#' Add axis to a plot
#'
#' Helper function to add axis to a plot.
#' @param plot A `ggplot` object
#' @param type One of `"none"`, `"x"`, `"y"`, or `"both"` (default)
#' @export
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
