#' Plot an area chart
#' @inheritParams plot_column
#' @param fill Color for the area underneath the line
#' @param order Logical indicating if the stacked areas should be ordered.
#' Default behavior (`TRUE`) stacks the largest groups on top.
#' @param position Argument passed to `geom_area`.
#' @importFrom ggplot2 ggplot aes waiver geom_area geom_hline labs theme
#' @importFrom dplyr mutate
#' @importFrom stats reorder
#'
#' @return A ggplot2 plot
#' @export
plot_area <- function(
    data,
    x,
    y,
    fill,
    variable,
    zero = TRUE,
    order = TRUE,
    palette = "qual_benvi",
    scale_name = "",
    scale_label = ggplot2::waiver(),
    text = FALSE,
    text_color = "gray20",
    text_family = "Poppins",
    text_size = 3,
    position = "stack",
    position_text = "identity"
) {

  if (missing(variable)) {
    if (missing(fill)) {
      fill <- benvi_palette("benvi_blue", 1)
    }

    # Plot a simple area chart of a single-variable

    p <- ggplot() +
      geom_area(
        data = data,
        aes(x = {{ x }}, y = {{ y }}),
        fill = fill,
        position = position
      )

  } else {

    if (isTRUE(order)) {

      # Orders the fill variable to stack bigger groups on the top
      data <- dplyr::mutate(
        data,
        ordered_fill = reorder(factor({{ variable }}), -{{ y }})
      )

      # Plot a fill-colored area chart

      p <- ggplot() +
        geom_area(
          data = data,
          aes(x = {{ x }}, y = {{ y }}, fill = ordered_fill),
          position = position
        )

    } else {

      # Plot a fill-colored area chart (unordered)

      p <- ggplot() +
        geom_area(
          data = data,
          aes(x = {{ x }}, y = {{ y }}, fill = {{ variable }}),
          position = position
        )

    }

    # Include benvi colors

    p <- p +
      scale_fill_benvi_d(
        pal_name = palette,
        name = scale_name,
        labels = scale_label
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
