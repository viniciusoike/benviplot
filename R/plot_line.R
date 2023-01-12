#' Title
#'
#' @param data A data.frame type object.
#' @param x Variable to be mapped on the x-axis.
#' @param y Variable to be mapped on the y-axis.
#' @param color Indicates the color of the line. Should only be used in the
#' absence of `variable`.
#' @param variable Indicates the grouping variable for color groups.
#' @param zero Logical indicating if a horizontal line (y = 0) should be drawn
#' on the plot.
#' @param point Logical indicating if points should be drawn on top of line.
#' @param pal_name String indicating which color palette to use.
#' @param scale_name String indicating color legend title.
#' @param scale_label String indicating color legend labels.
#' @param ... Other arguments to ggplot2 function.
#'
#' @return A ggplot2 plot
#' @export
#' @importFrom ggplot2 ggplot aes geom_line geom_point geom_hline labs
#'
#' @examples
#' sales <- data.frame(time = 2000:2005, value = c(10, 5, 6, 8, 11, 4))
#' plot_line(data = sales, x = time, y = value)
plot_line <- function(
    data,
    x,
    y,
    color,
    variable,
    zero = TRUE,
    point = FALSE,
    pal_name,
    scale_name = "",
    scale_label = ggplot2::waiver(),
    ...) {

  if (missing(variable)) {

    if (missing(color)) { color <- benvi_palette("Basic", 1) }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})) +
      geom_line(
        linewidth = 1,
        color = color)

    if (isTRUE(point)) {
      p <- p + geom_point(color = color)
      }

  } else {

    if (missing(pal_name)) { pal_name <- "Qual9" }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})) +
      geom_line(
        data = data,
        aes(color = {{ variable }}),
        linewidth = 1) +
      scale_color_benvi_d(
        pal_name = pal_name,
        name = scale_name,
        labels = scale_label)

    if (isTRUE(point)) {
      p <- p + geom_point(data = data, aes(color = {{variable}}))
    }

  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  p <- p +
    labs(x = NULL, ...) +
    theme_benvi()

  return(p)

}

