#' Plot the original series plus a trend-line with emphasis on the trendline (Deprecated)
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `plot_line_trend()` has been deprecated due to its inflexible data format
#' requirements. Use standard ggplot2 with `geom_smooth()` or manual trend
#' calculations instead.
#'
#' @inheritParams plot_line
#' @param name_series String indicating the name of the original series
#' @param name_trend String indicating the name of the trend series
#'
#' @details
#' ## Migration Guide
#'
#' The functionality can be easily replicated with standard ggplot2:
#'
#' ```r
#' # Instead of plot_line_trend():
#' library(ggplot2)
#'
#' # Automatic smooth trend:
#' ggplot(df, aes(x = date, y = value)) +
#'   geom_line(alpha = 0.5, color = benvi_palette("blues")[3]) +
#'   geom_smooth(method = "loess", se = FALSE, linewidth = 1,
#'               color = benvi_palette("blues")[4]) +
#'   theme_benvi()
#'
#' # Or with manual trend data:
#' ggplot() +
#'   geom_line(data = original, aes(x = date, y = value),
#'             alpha = 0.5, color = benvi_palette("blues")[3]) +
#'   geom_line(data = trend, aes(x = date, y = value),
#'             linewidth = 1, color = benvi_palette("blues")[4]) +
#'   theme_benvi()
#' ```
#'
#' @keywords internal
#' @importFrom ggplot2 ggplot aes geom_line geom_hline theme scale_x_date scale_y_continuous
#' @importFrom scales label_number
#' @importFrom dplyr filter
#' @return A ggplot2 plot
#' @export
plot_line_trend <- function(
    data,
    x = ts_date,
    y = value,
    name_series = "original",
    name_trend = "trend",
    color = benvi_palette("rio_qual", 1),
    zero = TRUE
    ) {

  lifecycle::deprecate_soft(
    when = "1.1.1",
    what = "plot_line_trend()",
    details = "Use ggplot2::geom_smooth() or manual trend lines instead."
  )

  if (isTRUE(zero)) {
    p <- ggplot() +
      geom_hline(yintercept = 0)
  }

  p <- p +
    geom_line(
      data = dplyr::filter(data, series_id == name_series),
      aes(x = {{ x }}, y = {{ y }}),
      color = color,
      alpha = 0.5) +
    geom_line(
      data = dplyr::filter(data, series_id == name_trend),
      aes(x = {{ x }}, y = {{ y }}),
      color = color,
      linewidth = 1) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
    scale_y_continuous(labels = scales::label_number(big.mark = ".")) +
    theme_benvi()

  return(p)

}
