#' Plot the original series plus a trend-line with emphasis on the trendline
#'
#' @inheritParams plot_line
#' @param name_series String indicating the name of the original series
#' @param name_trend String indicating the name of the trend series
#'
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

  if (isTRUE(zero)) {
    p <- ggplot() +
      geom_hline(yintercept = 0)
  }

  p +
    geom_line(
      data = dplyr::filter(data, series_id == name_series),
      aes(x = {{ x }}, y = {{ y }}),
      color = color,
      alpha = 0.5) +
    geom_line(
      data = dplyr::filter(data, series_id == name_trend),
      aes(x = {{ x }}, y = {{ y }}, color = series_id),
      color = color,
      size = 1) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
    scale_y_continuous(labels = scales::label_number(big.mark = ".")) +
    theme_benvi()

}
