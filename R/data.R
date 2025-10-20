#' QuintoAndar Index (IQA) - Rental Price Index
#'
#' Historical rental price index data from QuintoAndar. This is the legacy IQA
#' index, which has been superseded by the IQAIW (see \code{\link{iqaiw}}).
#'
#' @format ## iqa
#' A data frame with 96 observations and 6 variables:
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality (city)}
#'   \item{index}{Rental price index, normalized to 100 at first observation}
#'   \item{chg}{Monthly percent variation of the index (decimal form)}
#'   \item{acum12m}{12-month accumulated variation of the index (decimal form)}
#'   \item{price_m2}{Estimated rental price per square meter (R$/m²)}
#' }
#' @source Benvi
"iqa"

#' QuintoAndar ImovelWeb Rental Index (IQAIW)
#'
#' The IQAIW (Índice QuintoAndar ImovelWeb) is a rental index for major Brazilian
#' cities. The index is based on both new rental contracts (managed by QuintoAndar)
#' and online listings from QuintoAndar's listings (including ImovelWeb).
#'
#' The IQAIW was developed in 2023 and replaced the former IQA index. Given the
#' change in methodology and data sources, the IQAIW is not directly comparable to
#' the IQA index.
#'
#' @section Methodology:
#' Formally, the index is a hedonic double imputed index, controlling for quality
#' changes using a flexible GAM specification with location variables. In this
#' sense, the IQAIW is more theoretically sound than median stratified indices
#' like FipeZap or the former IQA. The mixture of listings and contracts, however,
#' lacks theoretical support and seems to be mainly driven by branding purposes.
#'
#' The ImovelWeb brand was purchased by QuintoAndar in 2021-22 and the IQAIW
#' symbolizes the merging of both brands. In other words, the original IQA could've
#' been improved simply by adopting a hedonic methodology, without the need to
#' mix data sources.
#'
#' @format ## iqaiw
#' A data frame with 1,660 observations across 6 cities and multiple time periods:
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality. One of: Belo Horizonte, Brasília,
#'     Curitiba, Porto Alegre, Rio de Janeiro, São Paulo}
#'   \item{rooms}{Number of rooms in the property, or "Total" for city-level aggregate}
#'   \item{index}{Rental price index, normalized to 100 at first observation per city}
#'   \item{chg}{Monthly percent variation of the index (decimal form)}
#'   \item{acum12m}{12-month accumulated variation of the index (decimal form)}
#'   \item{price_m2}{Estimated rental price per square meter (R$/m²)}
#' }
#'
#' @source \url{https://publicfiles.data.quintoandar.com.br/indice_quintoandar_imovelweb/index_quintoandar_imovelweb_serie.csv}
#'
#' @examples
#' \dontrun{
#' # Plot index over time for all cities
#' library(ggplot2)
#' ggplot(iqaiw, aes(x = date, y = index, color = name_muni)) +
#'   geom_line() +
#'   scale_color_benvi_d(pal_name = "qual_6", name = "name_muni") +
#'   labs(
#'     title = "IQAIW: Rental Price Index",
#'     x = "Date",
#'     y = "Index (base = 100)"
#'   ) +
#'   theme_benvi()
#' }
"iqaiw"

#' QuintoAndar Sales Report - Zone-Level Rental Data
#'
#' Rental price data at the zone (region) level for major Brazilian cities.
#' Contains both listing prices and actual contract prices, allowing comparison
#' between asking prices and transaction prices.
#'
#' @format ## sales_report
#' A data frame with 272 observations across multiple cities and zones:
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality (city). Includes: Belo Horizonte,
#'     Rio de Janeiro, and São Paulo}
#'   \item{name_zone}{Name of the zone within the city}
#'   \item{price_m2_listing}{Median listing price per square meter (R$/m²)}
#'   \item{price_m2_contract}{Median contract price per square meter (R$/m²)}
#' }
#'
#' @details
#' This dataset provides zone-level granularity, showing sales prices for
#' specific regions within cities. The difference between
#' \code{price_m2_listing} and \code{price_m2_contract} can indicate
#' negotiation patterns or market dynamics.
#'
#' @source Benvi (Sales Report 2023-Q3).
#'
#' @examples
#' \dontrun{
#' # Compare listing vs contract prices
#' library(ggplot2)
#'
#' spo_sales <- subset(sales_report, name_muni == "São Paulo" & date == max(date))
#'
#' ggplot(spo_sales, aes(x = price_m2_listing, y = price_m2_contract)) +
#'   geom_point(color = benvi_palette("benvi_blue")[3], size = 2) +
#'   geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
#'   labs(
#'     title = "Listing vs Contract Prices by Zone",
#'     subtitle = "São Paulo - Most Recent Month",
#'     x = "Listing Price (R$/m²)",
#'     y = "Contract Price (R$/m²)"
#'   ) +
#'   theme_benvi()
#' }
"sales_report"
