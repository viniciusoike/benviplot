#' Plot a column chart
#'
#' @param data A data frame.
#' @param x <[`data-masked`][ggplot2::aes_eval]> Variable mapped to the x-axis.
#' @param y <[`data-masked`][ggplot2::aes_eval]> Variable mapped to the y-axis.
#' @param fill Fill color for the columns. Either a color string (e.g.,
#'   `"blue"`, `"#021841"`) for a single static color, or a bare column name
#'   (without quotes) to map a grouping variable to fill color.
#' @param zero Whether to draw a horizontal line at `y = 0`.
#' @param text Whether to add value labels to the columns.
#' @param text_inside Whether to place labels inside the columns with
#'   `ggfittext`. When `FALSE` (the default), labels use a fixed size and appear
#'   above or beside the columns.
#' @param text_place Placement of labels inside the columns. Choose `"top"`,
#'   `"bottom"`, `"left"`, `"right"`, `"centre"`, or `"center"`. Defaults to
#'   `"centre"` and applies only when `text_inside = TRUE`.
#' @param text_padding Padding around inside labels, supplied as a
#'   [grid::unit()] object. Defaults to 1 mm and applies only when
#'   `text_inside = TRUE`.
#' @param pal_name Name of the palette.
#' @param scale_name Fill legend title.
#' @param scale_label Fill legend labels.
#' @param digits Number of digits to show in text labels.
#' @param percent Whether to append a percent sign to text labels.
#' @param text_color Color of the text label. Default is `"gray20"`.
#' @param text_family Font family for the text label. Defaults to
#'   `getOption("theme_benvi.font_family", "sans")`.
#' @param text_size Size of the text label. Default is `3`.
#' @param position_col Position adjustment passed to [ggplot2::geom_col()].
#' @param position_text Position adjustment passed to [ggplot2::geom_text()].
#' @param ... Additional arguments passed to [ggplot2::geom_col()] or
#'   [ggplot2::geom_text()].
#'
#' @return A `ggplot` object.
#' @export
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' # Column chart by city at the latest date
#' latest <- subset(iqa, date == max(iqa$date))
#' plot_column(data = latest, x = name_muni, y = index)
#'
#' # With text labels above bars
#' plot_column(data = latest, x = name_muni, y = index, text = TRUE)
#' \dontshow{options(.op)}
#'
#' @examplesIf requireNamespace("ggfittext", quietly = TRUE)
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' # With text labels inside bars
#' latest <- subset(iqa, date == max(iqa$date))
#' plot_column(data = latest, x = name_muni, y = index, text = TRUE, text_inside = TRUE)
#' \dontshow{options(.op)}
#'
#' @importFrom ggplot2 ggplot aes geom_col geom_hline geom_text labs
#' theme element_blank position_stack position_dodge
#' @importFrom dplyr mutate pull
plot_column <- function(
  data,
  x,
  y,
  fill = NULL,
  zero = TRUE,
  text = FALSE,
  text_inside = FALSE,
  text_place = NULL,
  text_padding = NULL,
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  digits = 0,
  percent = FALSE,
  text_color = "gray20",
  text_family = getOption("theme_benvi.font_family", "sans"),
  text_size = 3,
  position_col = "stack",
  position_text = position_col,
  ...
) {
  fill_quo <- rlang::enquo(fill)
  fill_type <- detect_aesthetic_type(fill_quo, "fill", data)

  if (fill_type$type == "variable_mapping") {
    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }}, fill = !!fill_quo)
      ) +
      geom_col(position = position_col, ...) +
      scale_fill_benvi_d(
        pal_name = pal_name,
        name = scale_name,
        labels = scale_label
      )
  } else {
    static_fill <- if (fill_type$type == "static_color") {
      fill_type$value
    } else {
      "#021841"
    }

    p <-
      ggplot(
        data = data,
        aes(x = {{ x }}, y = {{ y }})
      ) +
      geom_col(fill = static_fill, position = position_col, ...)
  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  if (isTRUE(text)) {
    if (isTRUE(text_inside)) {
      if (!requireNamespace("ggfittext", quietly = TRUE)) {
        cli::cli_abort(c(
          "Package {.pkg ggfittext} is required for {.code text_inside = TRUE}.",
          "i" = "Install with: {.code install.packages('ggfittext')}"
        ))
      }

      if (is.null(text_place)) {
        text_place <- "centre"
      }

      if (is.null(text_padding)) {
        text_padding <- grid::unit(1, "mm")
      }

      dflabel <- data |>
        dplyr::mutate(
          label = format_num_br({{ y }}, digits = digits, percent = percent)
        )

      p <- p +
        ggfittext::geom_bar_text(
          data = dflabel,
          aes(x = {{ x }}, y = {{ y }}, label = label),
          min.size = text_size,
          family = text_family,
          color = text_color,
          place = text_place,
          padding.x = grid::unit(0, "mm"),
          padding.y = text_padding
        )
    } else {
      yjust <- max(data |> dplyr::pull({{ y }}), na.rm = TRUE) * 0.05
      dflabel <- data |>
        dplyr::mutate(
          ytext = ifelse({{ y }} > 0, {{ y }} + yjust, {{ y }} - yjust),
          label = format_num_br({{ y }}, digits = digits, percent = percent)
        )

      if (missing(position_text)) {
        position_text <- "identity"
      }

      if (position_text == "stack") {
        position_text <- position_stack(vjust = 0.5)
        yjust <- 0
      } else if (position_text == "dodge") {
        position_text <- position_dodge(width = 0.9)
      }

      p <- p +
        geom_text(
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
