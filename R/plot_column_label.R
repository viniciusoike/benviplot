#' Column plot with text labels
#' @inheritParams plot_column
#'
#' @importFrom ggplot2 ggplot aes waiver geom_col geom_text coord_flip theme position_stack
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
    fill,
    pal,
    digits = 1,
    text_color = "white",
    text_family = "Roboto",
    text_size = 4,
    scale_name = "",
    scale_label = waiver(),
    zero = TRUE
    ) {

  p <- ggplot(data, aes(x = {{ x }}, y = {{ y }})) +
    geom_col(fill = fill) +
    geom_text(
      aes(label = {{ x }}),
      position = position_stack(vjust = 0.05),
      hjust = 0,
      color = text_color,
      family = text_family,
      size = text_size
    ) +
    geom_text(
      aes(label = pretty_number({{ y }}, digits = digits)),
      position = position_stack(vjust = 0.9),
      hjust = 0,
      color = text_color,
      family = text_family,
      size = text_size
    )

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  p <- p +
    coord_flip() +
    theme_benvi() +
    theme(
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid.major.y = element_blank()
    )

  return(p)
}
