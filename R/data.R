#' QuintoAndar Index (IQA) - Rental Price Index
#'
#' Historical rental price index data from QuintoAndar. This is the legacy IQA
#' index, which has been superseded by the IQAIW (see \code{\link{iqaiw}}).
#'
#' @format
#' A data frame with 96 observations and 6 variables:
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality (city)}
#'   \item{index}{Rental price index, normalized to 100 at first observation}
#'   \item{chg}{Monthly percent variation of the index (decimal form)}
#'   \item{acum12m}{12-month accumulated variation of the index (decimal form)}
#'   \item{price_m2}{Estimated rental price per square meter (R$/m²)}
#' }
#' @source QuintoAndar
#' @examples
#' # To visualize the dataset
#' head(iqa)
#' str(iqa)
#'
#' # Plot index over time for all cities
#' library(ggplot2)
#' ggplot(iqa, aes(x = date, y = index, color = name_muni)) +
#'   geom_line() +
#'   scale_color_benvi_d(pal_name = "qual_9", name = "City") +
#'   labs(
#'     title = "IQAIW: Rental Price Index",
#'     x = "Date",
#'     y = "Index (base = 100)"
#'   ) +
#'   theme_benvi()
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
#' @format
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
#'
#' # To visualize the dataset
#' head(iqaiw)
#' str(iqaiw)
#'
#' # Plot index over time for all cities
#' library(ggplot2)
#'
#' iqaiw_rooms <- subset(iqaiw, rooms != "Total" & !is.na(acum12m))
#'
#' ggplot(iqaiw_rooms, aes(x = date, y = acum12m, color = rooms)) +
#'   geom_line(lwd = 0.5) +
#'   geom_hline(yintercept = 0) +
#'   scale_color_benvi_d(pal_name = "qual_6", name = "Rooms") +
#'   facet_wrap(vars(name_muni), ncol = 3, scales = "free") +
#'   labs(
#'     title = "IQAIW: Rental Price Index",
#'     x = "Date",
#'     y = "Index (base = 100)"
#'   ) +
#'   theme_benvi()
#'
"iqaiw"

#' QuintoAndar Sales Report
#'
#' Sales price data at a region level for major Brazilian cities.
#' Contains contract prices per square meter, allowing comparison across cities
#' and zones.
#'
#' @format ## sales_report
#' A data frame with 272 observations across multiple cities and zones:
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality (city). Includes: Belo Horizonte,
#'     Rio de Janeiro, and São Paulo}
#'   \item{name_zone}{Name of the zone within the city}
#'   \item{price_m2}{Median contract price per square meter (R$/m²)}
#' }
#'
#' @details
#' This dataset provides zone-level granularity, showing sales prices for
#' specific regions within cities.
#'
#' @source QuintoAndar (Sales Report 2020-Q1/2023-Q3). \url{https://publicfiles.data.quintoandar.com.br/sale_report/RelatorioCV_4T_2022.pdf}
#'
#' @examples
#' # Compare contract prices across zones
#' library(ggplot2)
#'
#' bhe_sales <- subset(sales_report, name_muni == "Belo Horizonte" & date == max(date))
#'
#' bhe_sales$name_zone <- factor(
#'   bhe_sales$name_zone,
#'   levels = bhe_sales$name_zone[order(bhe_sales$price_m2)]
#' )
#'
#' ggplot(bhe_sales, aes(x = price_m2, y = name_zone)) +
#' geom_col(fill = benvi_palette("benvi_blue")[3]) +
#' theme_benvi()
"sales_report"
