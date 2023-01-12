#' Format a number as a label
#'
#' @param x A numeric vector
#' @param digits Number of decimal cases to include
#'
#' @description This is a convinient wrapper to both the `format` and the `round`
#' base functions to convert a numeric vector into a character of labels for
#' tables or plots.
#'
#' @return 
#' @export
#'
#' @examples
#' x <- 1235134.123
#' pretty_num(x)
#' pretty_num(x, digits = 3)
pretty_number <- function(x, digits = 1, percent = FALSE) {
  x <- round(x, digits = digits)
  x <- format(x, big.mark = ".", decimal.mark = ",")
  if (isTRUE(percent)) {x <- paste0(x, "%")}
  x
}

#' Column plot with text labels
#'
#' @param data A `data.frame`, `tibble` or `data.table`
#' @param x The x variable to be mapped. Usually a factor.
#' @param y The y variable to be mapped. Usually a numeric.
#' @param fill Color to fill the columns.
#' @param pal_name Palette name for `scale_fill_benvi_d`
#' @param text.digits Number of decimal cases to show
#' @param text.color Color of the text labels. Defaults to `white`
#' @param text.family Font family of the text labels. Defaults to "Roboto"
#' @param text.size Size of the text labels. Defaults to 4.
#' @param scale.name Argument for `scale_fill_benvi_d`
#' @param scale.label Argument for `scale_fill_benvi_d`
#' @param zero Logical indicating if a straight line should be drawn across the
#' 0 y axis.
#'
#' @return
#' @export
#'
#' @examples
#' df <- data.frame(
#' house_region = c("Vila Mariana", "Moema", "Bela Vista"),
#' price_m2_sold = c(11257.12, 9874.54, 8991.38))
#' 
#' plot_column_label(df, x = house_region, y = price_m2_sold, fill = "#633758")
plot_column_label <- function(data, x, y, fill, pal_name,
                              text.digits = 1,
                              text.color = "white",
                              text.family = "Roboto",
                              text.size = 4,
                              scale.name = "",
                              scale.label = waiver(),
                              zero = TRUE) {
  
  
  p <- ggplot(data, aes(x = {{ x }}, y = {{ y }})) +
    geom_col(fill = fill) +
    geom_text(
      aes(label = {{ x }}),
      position = position_stack(vjust = 0.05),
      hjust = 0,
      color = text.color,
      family = text.family,
      size = text.size) +
    geom_text(
      aes(label = pretty_number({{ y }}, digits = text.digits)),
      position = position_stack(vjust = 0.9),
      hjust = 0,
      color = text.color,
      family = text.family,
      size = text.size)
  
  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }
  
  p <- p +
    coord_flip() +
    theme_benvi +
    theme(
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid.major.y = element_blank()
    )
  
  p
}

# df <- data.frame(
#   house_region = c("Vila Mariana", "Moema", "Bela Vista"),
#   price_m2_sold = c(11257.12, 9874.54, 8991.38)
# )
# 
# plot_column_label(df, x = house_region, y = price_m2_sold, fill = "#633758")
