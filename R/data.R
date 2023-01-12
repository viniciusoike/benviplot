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

#' QuintoAndar Index region data
#'
#' A subset of data from the QuintoAndar rent index disaggregated by regions
#'
#' @format ## iqa
#' A `tibble` with 3.827 rows and 11 columns
#' \describe{
#'   \item{sk_region}{Numeric identifier of each region}
#'   \item{ts_date}{Date of the observation}
#'   \item{rent_m2}{Observed median rent}
#'   \item{wrent_m2}{Weighted observed median rent}
#'   \item{wgt_inc}{Income weight}
#'   \item{name_region}{Name of the region}
#'   \item{name_muni}{Name of the municipality}
#'   \item{macro_name}{Name of the macro-region}
#'   \item{city_group}{Name of the city group}
#'   \item{chg}{Monthly percent variation of the index}
#'   \item{acum12m}{12-month acummulated variation of the index}
#'   }
#' @source Benvi
"iqa_region"
