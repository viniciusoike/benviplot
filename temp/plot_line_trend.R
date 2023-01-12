#' [Experimental]
#' Plot the original series plus a trend-line with emphasis on the trendline
#'
#' @param df 
#' @param x 
#' @param y 
#' @param name.series 
#' @param name.trend 
#' @param color 
#' @param zero 
#'
#' @return
#' @export
#'
#' @examples
plot_line_trend <- function(
    df,
    x = ts_date,
    y = value,
    name.series = "original",
    name.trend = "trend",
    color = benvi_palette("rio_qual")[1],
    zero = TRUE) {
  
  if (isTRUE(zero)) {
    p <- ggplot() +
      geom_hline(yintercept = 0)
  }
  
  p +
    geom_line(
      data = dplyr::filter(df, series_id == name.series),
      aes(x = {{ x }}, y = {{ y }}),
      color = color,
      alpha = 0.5) +
    geom_line(
      data = dplyr::filter(df, series_id == name.trend),
      aes(x = {{ x }}, y = {{ y }}, color = series_id),
      color = color,
      size = 1) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
    scale_y_continuous(labels = scales::label_number(big.mark = ".")) +
    theme_benvi
  
}

# netflow <- sbpe |> 
#   filter(ts_year >= 2015) |> 
#   mutate(
#     trend = roll_mean(sbpe_netflow, n = 6, align = "center", fill = NA),
#     trend = roll_mean(trend, n = 2, align = "center", fill = NA)) |>
#   select(ts_date, original = sbpe_netflow, trend) |> 
#   pivot_longer(cols = -ts_date, names_to = "series_id") |> 
#   mutate(series_id = factor(series_id, levels = c("original", "trend")))
# 
# plot_line_trend(netflow)
# 
# library(fable)
# library(fpp3)
# 
# netflow |> 
#   mutate(month = yearmonth(ts_date)) |> 
#   as_tsibble(key = series_id, index = month) |> 
#   filter(series_id == "original") |> 
#   na.omit() |> 
#   model(
#     STL(value ~ trend() + season(), robust = TRUE),
#   ) |> 
#   components() |> 
#   autoplot()
#   
# canadian_gas |> 
#   model(
#     STL(Volume ~ trend() + season(), robust = TRUE),
#   )
# 
# us_retail_employment %>%
#   model(
#     STL(Employed ~ trend(window = 7) + season(window = "periodic"),
#         robust = TRUE)) %>%
#   components() %>%
#   autoplot()
# 
# autoplot(canadian_gas)
# 
# gg_season(canadian_gas)
# 
# gg_subseries(canadian_gas)
# 
# gg_season(AirPassengers)
# 
# model.stl <- canadian_gas |> 
#   model(
#     STL(Volume ~ trend() + season(window = 36), robust = TRUE)
#   ) |> 
#   components()
# 
# gg_subseries(model.stl, season_year)
# 
# autoplot(model.stl)
# 
# 
# 
# 
# 
# 
# 
# 
# feasts::STL()