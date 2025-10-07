#' QuintoAndar Index data
#'
#' A subset of data from the QuintoAndar rent index
#'
#' @format ## iqa
#' A data frame
#' \describe{
#'   \item{name_muni}{Name of the municipality (city)}
#'   \item{ts_date}{Date of the observation}
#'   \item{rent_m2}{Observed median rent}
#'   \item{wrent_m2}{Weighted observed median rent}
#'   \item{wgt_inc}{Income weight}
#'   \item{chg}{Monthly percent variation of the index}
#'   \item{acum12m}{12-month acummulated variation of the index}
#'   }
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
#' A data frame with 6 cities across multiple time periods
#' \describe{
#'   \item{date}{Date of the observation}
#'   \item{name_muni}{Name of the municipality. One of: Belo Horizonte, Brasília,
#'     Curitiba, Porto Alegre, Rio de Janeiro, São Paulo}
#'   \item{index}{Rental price index, normalized to 100 at first observation per city}
#'   \item{chg}{Monthly percent variation of the index}
#'   \item{acum12m}{12-month accumulated variation of the index}
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
#'   scale_color_benvi_d(pal_name = "Qual6", name = "City") +
#'   labs(
#'     title = "IQAIW: Rental Price Index",
#'     x = "Date",
#'     y = "Index (base = 100)"
#'   ) +
#'   theme_benvi()
#' }
"iqaiw"
