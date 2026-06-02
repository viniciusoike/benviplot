#' Plot an area chart
#' @inheritParams plot_column
#' @param fill Fill color for the area. Either a color string (e.g., `"blue"`,
#'   `"#021841"`) for a single static color, or a bare column name (without
#'   quotes) to map a grouping variable to fill color.
#' @param order Logical indicating if the stacked areas should be ordered.
#' Default behavior (`TRUE`) stacks the largest groups on top.
#' @param position Argument passed to `geom_area`.
#' @importFrom ggplot2 ggplot aes waiver geom_area geom_hline labs theme
#' @importFrom dplyr mutate
#' @importFrom stats reorder
#'
#' @return A ggplot2 plot
#' @export
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' # Simple area chart
#' sao_paulo <- subset(iqa, name_muni == "S\u00e3o Paulo")
#' plot_area(data = sao_paulo, x = date, y = index)
#'
#' # Stacked area chart with fill mapping
#' total <- subset(iqaiw, rooms == "Total")
#' plot_area(data = total, x = date, y = index, fill = name_muni)
#' \dontshow{options(.op)}
plot_area <- function(
  data,
  x,
  y,
  fill = NULL,
  zero = TRUE,
  order = TRUE,
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  text = FALSE,
  text_color = "gray20",
  text_family = getOption("theme_benvi.font_family", "sans"),
  text_size = 3,
  position = "stack",
  position_text = "identity"
) {
  fill_quo <- rlang::enquo(fill)
  fill_type <- detect_aesthetic_type(fill_quo, "fill", data)

  if (fill_type$type == "variable_mapping") {
    if (isTRUE(order)) {
      data <- dplyr::mutate(
        data,
        ordered_fill = reorder(factor(!!fill_quo), -{{ y }})
      )

      p <- ggplot() +
        geom_area(
          data = data,
          aes(x = {{ x }}, y = {{ y }}, fill = ordered_fill),
          position = position
        )
    } else {
      p <- ggplot() +
        geom_area(
          data = data,
          aes(x = {{ x }}, y = {{ y }}, fill = !!fill_quo),
          position = position
        )
    }

    p <- p +
      scale_fill_benvi_d(
        pal_name = pal_name,
        name = scale_name,
        labels = scale_label
      )
  } else {
    static_fill <- if (fill_type$type == "static_color") {
      fill_type$value
    } else {
      benvi_palette("benvi_blue", 1)
    }

    p <- ggplot() +
      geom_area(
        data = data,
        aes(x = {{ x }}, y = {{ y }}),
        fill = static_fill,
        position = position
      )
  }

  # Horizontal line (y = 0)

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  if (isTRUE(text)) {
    # work in progress
  }

  # Remove x-axis label and Benvi theme

  p <- p +
    labs(x = NULL) +
    theme_benvi() +
    theme(
      panel.grid.major.x = element_blank()
    )

  return(p)
}
