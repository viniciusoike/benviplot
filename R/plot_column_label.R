#' Column plot with text labels
#' @inheritParams plot_column
#' @param label Text label to mapped onto the column. Defaults to y variable.
#' @param fill_guide Optional indicating if fill guide should be supressed.
#'
#'
#' @importFrom ggplot2 ggplot aes waiver geom_col geom_text coord_flip theme position_stack
#' @importFrom ggfittext geom_bar_text
#' @return A ggplot2 plot
#' @export
#'
#' @examples
#' df <- data.frame(
#'   house_region = c("Vila Mariana", "Moema", "Bela Vista"),
#'   price_m2_sold = c(11257.12, 9874.54, 8991.38)
#' )
#'
#' plot_column_label(df, x = house_region, y = price_m2_sold, fill = "#633758")
plot_column_label <- function(
    data,
    x,
    y,
    label = y,
    fill,
    variable,
    zero = TRUE,
    flip = TRUE,
    fill_guide = "none",
    pal,
    text_color = "white",
    text_family = "Roboto",
    text_size = 4,
    scale_name = "",
    scale_label = waiver()
) {

  if (missing(variable)) {
    if (missing(fill)) {
      fill <- benvi_palette("Basic", 1)
    }

    p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}), label = {{ y }}) +
      geom_col(fill = fill)

  } else {

    p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}), label = {{ y }}) +
      geom_col(aes(fill = {{ variable }})) +
      scale_fill_benvi_d(
        pal_name = pal,
        name = scale_name,
        label = scale_label
      )

    if (guide_fill == "none") {
      p <- p + guides(fill = "none")
    }

  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }


  if (isTRUE(flip)) {

    p <- p +
      coord_flip() +
      ggfittext::geom_bar_text(
        min.size = text_size,
        family = text_family,
        color = text_color,
        place = "right",
        padding.x = grid::unit(5, "mm")
      )

  } else {

    p <- p +
      ggfittext::geom_bar_text(
        min.size = text_size,
        family = text_family,
        color = text_color,
        place = "top",
        padding.y = grid::unit(5, "mm")
      )
  }

  p <- p +
    theme_benvi() +
    theme(
      axis.title.y = element_blank(),
      panel.grid.major.y = element_blank()
    )

  return(p)
}
