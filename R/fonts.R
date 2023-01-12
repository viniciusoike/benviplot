#' Import fonts from google to use in charts
#'
#' @note This function requires an internet connection.
#' @export
#'
#' @examples
#' import_fonts()
import_fonts <- function() {
  import_poppins()
  import_roboto()
  import_roboto_condensed()
}

import_poppins <- function() {

  sysfonts::font_add_google(name = "Poppins", family = "Poppins")

}

import_roboto <- function() {

  sysfonts::font_add_google(name = "Roboto", family = "Roboto")

}

import_roboto_condensed <- function() {

  sysfonts::font_add_google(name = "Roboto Condensed", family = "RobotoCondensed")

}
