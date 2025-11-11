#' Column plot with text labels (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `plot_column_label()` has been deprecated in favor of enhanced `plot_column()`.
#' Use `plot_column(text = TRUE, text_inside = TRUE, flip = TRUE)` instead.
#'
#' @inheritParams plot_column
#' @param label <[`data-masked`][ggplot2::aes_eval]> Text label to mapped onto the column. Defaults to y variable.
#' @param fill_guide Optional indicating if fill guide should be suppressed.
#'
#' @details
#' ## Migration Guide
#'
#' The functionality of `plot_column_label()` is now available in `plot_column()`
#' with the `text_inside` parameter:
#'
#' ```r
#' # Old (deprecated):
#' plot_column_label(df, x = category, y = value, flip = TRUE)
#'
#' # New (recommended):
#' plot_column(df, x = category, y = value,
#'             text = TRUE, text_inside = TRUE, flip = TRUE)
#' ```
#'
#' @keywords internal
#' @importFrom ggplot2 ggplot aes waiver geom_col geom_text coord_flip theme position_stack guides
#' @importFrom ggfittext geom_bar_text
#' @return A ggplot2 plot
#' @export
#'
#' @examples
#' \dontrun{
#' # Use plot_column() instead
#' df <- data.frame(
#'   cat = c("A", "B", "C"),
#'   value = c(11257, 9874, 8991)
#' )
#' plot_column(df, x = cat, y = value, text = TRUE, text_inside = TRUE, flip = TRUE)
#' }
plot_column_label <- function(
    data,
    x,
    y,
    label,
    fill,
    variable,
    zero = TRUE,
    flip = TRUE,
    fill_guide = "none",
    palette = "qual_benvi",
    text_color = "white",
    text_family = "sans",
    text_size = 4,
    scale_name = "",
    scale_label = waiver()
) {

  lifecycle::deprecate_soft(
    when = "1.1.1",
    what = "plot_column_label()",
    with = "plot_column(text_inside = )"
  )

  if (missing(variable)) {
    if (missing(fill)) {
      fill <- benvi_palette("benvi_blue", 1)
    }

    if (missing(label)) {
      p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}, label = {{ y }})) +
        geom_col(fill = fill)
    } else {
      p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}, label = {{ label }})) +
        geom_col(fill = fill)
    }

  } else {

    if (missing(label)) {
      p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}, label = {{ y }})) +
        geom_col(aes(fill = {{ variable }})) +
        scale_fill_benvi_d(
          pal_name = palette,
          name = scale_name,
          labels = scale_label
        )
    } else {
      p <- ggplot(data, aes(x = {{ x }}, y = {{ y }}, label = {{ label }})) +
        geom_col(aes(fill = {{ variable }})) +
        scale_fill_benvi_d(
          pal_name = palette,
          name = scale_name,
          labels = scale_label
        )
    }

    if (fill_guide == "none") {
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
