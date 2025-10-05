#' Plot a column chart
#'
#' @param data A data.frame type object
#' @param x <[`data-masked`][ggplot2::aes_eval]> Variable to be mapped in the x-axis.
#' @param y <[`data-masked`][ggplot2::aes_eval]> Variable to be mapped in the y-axis.
#' @param fill Color for the columns. Should only be used if `variable`
#' is missing.
#' @param variable <[`data-masked`][ggplot2::aes_eval]> Variable to be used as grouping for the color groups. Should
#' only be used if `fill` is missing.
#' @param zero Logical indicating whether a horizontal line crossing the y = 0
#' axis should be plotted.
#' @param flip Logical indicating if plot should be flipped
#' @param text Logical indicating if text labels should be plotted above column
#' bars
#' @param palette String indicating the name of which palette to use.
#' @param scale_name String indicating fill legend title.
#' @param scale_label String indicating fill legend labels.
#' @param digits Number of digits to show in text labels.
#' @param percent Logical indicating if a % should be appended to text labels
#' @param text_color Color of the text label. Default is `"gray20"`.
#' @param text_family Font of the text label. Default is `"Poppins"`.
#' @param text_size Size of the text label. Default is `3`.
#' @param position_col Argument passed on to `position` in `geom_col`.
#' @param position_text Argument passed on to `position` in `geom_text`.
#' @param ... Further arguments for `geom_text`

#'
#' @return A ggplot2 plot
#' @export
#'
#' @examples
#' df <- data.frame(cat = factor(c("A", "B", "C")), value = c(5, 7, 3))
#' plot_column(data = df, x = cat, y = value)
#' @importFrom ggplot2 ggplot aes geom_col geom_hline geom_text coord_flip labs
#' theme element_blank position_stack position_dodge
#' @importFrom dplyr mutate pull
plot_column <- function(
    data,
    x,
    y,
    fill,
    variable,
    zero = TRUE,
    flip = FALSE,
    text = FALSE,
    palette = "Qual9",
    scale_name = "",
    scale_label = ggplot2::waiver(),
    digits = 0,
    percent = FALSE,
    text_color = "gray20",
    text_family = "Poppins",
    text_size = 3,
    position_col = "stack",
    position_text = position_col,
    ...) {

  if (missing(variable)) {
    if (missing(fill)) { fill <- "#3957BD" }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})) +
      geom_col(fill = fill, position = position_col, ...)

  } else {

    if (missing(pal)) { pal <- "Qual9" }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }}, fill = {{ variable }})) +
      geom_col(position = position_col, ...) +
      scale_fill_benvi_d(
        pal_name = palette,
        name = scale_name,
        labels = scale_label)

  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  if (isTRUE(flip)) {
    p <- p + coord_flip()
  }

  if (isTRUE(text)) {

    yjust <- max(data |> dplyr::pull({{ y }}), na.rm = TRUE) * 0.05
    dflabel <- data |>
      dplyr::mutate(
        ytext = ifelse({{y}} > 0, {{y}} + yjust, {{y}} - yjust),
        label = pretty_number({{y}}, digits = digits, percent = percent))

    if (missing(position_text)) {
      position_text <- "identity"
    }

    if (position_text == "stack") {
      position_text <- position_stack(vjust = 0.5)
      yjust <- 0
    } else if (position_text == "dodge") {
      position_text <- position_dodge(width = 0.9)
    }

    p <- p + geom_text(
      data = dflabel,
      aes(x = {{ x }}, y = ytext, label = label),
      color = text_color,
      position = position_text,
      family = text_family,
      size = text_size
    )

  }

  p <- p +
    labs(x = NULL) +
    theme_benvi() +
    theme(
      panel.grid.major.x = element_blank()
    )

  return(p)

}
