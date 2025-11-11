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
#' @param text Logical indicating if text labels should be plotted on column bars
#' @param text_inside Logical indicating if text labels should be placed inside
#'   bars (using ggfittext). When TRUE, text is auto-sized to fit inside bars.
#'   When FALSE (default), text appears above/beside bars at fixed size.
#' @param text_place Placement of inside text. One of "top", "bottom", "left",
#'   "right", "centre"/"center". Only used when text_inside = TRUE. Defaults to
#'   "centre" for vertical bars or "right" for flipped bars.
#' @param text_padding Padding around inside text as grid::unit(). Only used
#'   when text_inside = TRUE. Defaults to 1mm.
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
#' \dontrun{
#' # Basic column chart
#' df <- data.frame(cat = factor(c("A", "B", "C")), value = c(5, 7, 3))
#' plot_column(data = df, x = cat, y = value)
#'
#' # With text labels above bars
#' plot_column(data = df, x = cat, y = value, text = TRUE)
#'
#' # With text labels inside bars (auto-sized)
#' plot_column(data = df, x = cat, y = value, text = TRUE, text_inside = TRUE)
#' }
#'
#' @importFrom ggplot2 ggplot aes geom_col geom_hline geom_text coord_flip labs
#' theme element_blank position_stack position_dodge
#' @importFrom ggfittext geom_bar_text
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
    text_inside = FALSE,
    text_place = NULL,
    text_padding = NULL,
    palette = "qual_benvi",
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
    if (missing(fill)) { fill <- "#021841" }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})) +
      geom_col(fill = fill, position = position_col, ...)

  } else {

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

    if (isTRUE(text_inside)) {
      # Use ggfittext for auto-sized text inside bars

      # Set defaults for text_place based on flip
      if (is.null(text_place)) {
        text_place <- if (isTRUE(flip)) "right" else "centre"
      }

      # Set default padding
      if (is.null(text_padding)) {
        text_padding <- grid::unit(1, "mm")
      }

      # Format labels
      dflabel <- data |>
        dplyr::mutate(
          label = format_num_br({{y}}, digits = digits, percent = percent))

      # Add geom_bar_text layer
      p <- p + ggfittext::geom_bar_text(
        data = dflabel,
        aes(x = {{ x }}, y = {{ y }}, label = label),
        min.size = text_size,
        family = text_family,
        color = text_color,
        place = text_place,
        padding.x = if (isTRUE(flip)) text_padding else grid::unit(0, "mm"),
        padding.y = if (isTRUE(flip)) grid::unit(0, "mm") else text_padding
      )

    } else {
      # Use geom_text for fixed-size text above/beside bars

      yjust <- max(data |> dplyr::pull({{ y }}), na.rm = TRUE) * 0.05
      dflabel <- data |>
        dplyr::mutate(
          ytext = ifelse({{y}} > 0, {{y}} + yjust, {{y}} - yjust),
          label = format_num_br({{y}}, digits = digits, percent = percent))

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

  }

  p <- p +
    labs(x = NULL) +
    theme_benvi() +
    theme(
      panel.grid.major.x = element_blank()
    )

  return(p)

}
