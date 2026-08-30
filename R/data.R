#' QuintoAndar Index (IQA) - Rental Price Index
#'
#' Historical rental price index data from QuintoAndar. This is the legacy IQA
#' index, which has been superseded by the IQAIW (see \code{\link{iqaiw}}).
#'
#' @format
#' A data frame with 96 observations and 6 variables.
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality (city)}
#'   \item{index}{Rental price index, normalized to 100 at first observation}
#'   \item{chg}{Monthly percent variation of the index (decimal form)}
#'   \item{acum12m}{12-month accumulated variation of the index (decimal form)}
#'   \item{price_m2}{Estimated rental price per square meter (R$/m²)}
#' }
#' @source QuintoAndar
#' @encoding UTF-8
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
#'     title = "IQA: Rental Price Index",
#'     x = "Date",
#'     y = "Index (base = 100)"
#'   ) +
#'   theme_benvi(base_family = "sans")
"iqa"

#' QuintoAndar ImovelWeb Rental Index (IQAIW)
#'
#' The IQAIW (Índice QuintoAndar ImovelWeb) is a rental index for major Brazilian
#' cities. The index is based on both new rental contracts (managed by QuintoAndar)
#' and online listings published by QuintoAndar and ImovelWeb.
#'
#' The IQAIW was developed in 2023 and replaced the former IQA index. Given the
#' change in methodology and data sources, the IQAIW is not directly comparable to
#' the IQA index.
#'
#' @section Methodology:
#' The index uses double imputation with a hedonic model. A generalized additive
#' model (GAM) controls for property characteristics and location. The sample
#' combines new rental contracts with online listings, so the index does not
#' measure either source in isolation.
#'
#' @format
#' A data frame with 1,660 observations across six cities and multiple periods.
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality. Values include Belo Horizonte,
#'     Brasília, Curitiba, Porto Alegre, Rio de Janeiro, and São Paulo}
#'   \item{rooms}{Number of rooms in the property, or "Total" for city-level aggregate}
#'   \item{index}{Rental price index, normalized to 100 at first observation per city}
#'   \item{chg}{Monthly percent variation of the index (decimal form)}
#'   \item{acum12m}{12-month accumulated variation of the index (decimal form)}
#'   \item{price_m2}{Estimated rental price per square meter (R$/m²)}
#' }
#'
#' @source \url{https://publicfiles.data.quintoandar.com.br/indice_quintoandar_imovelweb/index_quintoandar_imovelweb_serie.csv}
#' @encoding UTF-8
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
#'     title = "IQAIW: 12-month rental price change",
#'     x = "Date",
#'     y = "12-month change (decimal)"
#'   ) +
#'   theme_benvi(base_family = "sans")
#'
"iqaiw"

#' QuintoAndar sales report
#'
#' Contract prices per square meter at the zone level for major Brazilian
#' cities.
#'
#' @format A data frame with 272 observations across multiple cities and zones.
#' \describe{
#'   \item{date}{Date of the observation (first day of month)}
#'   \item{name_muni}{Name of the municipality. Values include Belo Horizonte,
#'     Rio de Janeiro, and São Paulo}
#'   \item{name_zone}{Name of the zone within the city}
#'   \item{price_m2}{Median contract price per square meter (R$/m²)}
#' }
#'
#' @source QuintoAndar (Sales Report 2020-Q1/2023-Q3). \url{https://publicfiles.data.quintoandar.com.br/sale_report/RelatorioCV_4T_2022.pdf}
#' @encoding UTF-8
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
#'   geom_col(fill = benvi_palette("benvi_blue")[3]) +
#'   labs(x = "Median price per m² (R$)", y = NULL) +
#'   theme_benvi(base_family = "sans")
"sales_report"
