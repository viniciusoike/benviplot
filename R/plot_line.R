#' Plot a line chart
#'
#' @param data A data frame.
#' @param x <[`data-masked`][ggplot2::aes_eval]> Variable mapped to the x-axis.
#' @param y <[`data-masked`][ggplot2::aes_eval]> Variable mapped to the y-axis.
#' @param color Color of the line. Either a color string (e.g., `"blue"`,
#'   `"#021841"`) for a single static color, or a bare column name (without
#'   quotes) to map a grouping variable to color.
#' @param zero Whether to draw a horizontal line at `y = 0`.
#' @param point Whether to draw points over the line.
#' @param pal_name Name of the color palette.
#' @param scale_name Color legend title.
#' @param scale_label Color legend labels.
#' @param ... Additional arguments passed to [ggplot2::labs()].
#'
#' @return A `ggplot` object.
#' @export
#' @importFrom ggplot2 ggplot aes geom_line geom_point geom_hline labs
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' # Single series
#' sao_paulo <- subset(iqa, name_muni == "S\u00e3o Paulo")
#' plot_line(data = sao_paulo, x = date, y = index)
#'
#' # Multiple series with color mapping
#' total <- subset(iqaiw, rooms == "Total")
#' plot_line(data = total, x = date, y = index, color = name_muni)
#' \dontshow{options(.op)}
plot_line <- function(
  data,
  x,
  y,
  color = NULL,
  zero = TRUE,
  point = FALSE,
  pal_name,
  scale_name = "",
  scale_label = ggplot2::waiver(),
  ...
) {
  color_quo <- rlang::enquo(color)
  color_type <- detect_aesthetic_type(color_quo, "color", data)

  if (color_type$type == "variable_mapping") {
    if (missing(pal_name)) {
      pal_name <- "qual_benvi"
    }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})
      ) +
      geom_line(
        data = data,
        aes(color = !!color_quo),
        linewidth = 1
      ) +
      scale_color_benvi_d(
        pal_name = pal_name,
        name = scale_name,
        labels = scale_label
      )

    if (isTRUE(point)) {
      p <- p + geom_point(data = data, aes(color = !!color_quo))
    }
  } else {
    static_color <- if (color_type$type == "static_color") {
      color_type$value
    } else {
      benvi_palette("benvi_blue", 1)
    }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})
      ) +
      geom_line(
        linewidth = 1,
        color = static_color
      )

    if (isTRUE(point)) {
      p <- p + geom_point(color = static_color)
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
