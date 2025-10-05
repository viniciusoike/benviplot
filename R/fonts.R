#' Import fonts from google to use in charts
#'
#' @note This function requires an internet connection.
#' @importFrom cli cli_abort cli_alert_success cli_alert_info
#' @export
#'
#' @examples
#' \dontrun{
#' import_fonts()
#' }
import_fonts <- function() {

  # Check if required packages are available
  if (!requireNamespace("sysfonts", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg sysfonts} is required to import fonts.",
      "i" = "Install with: {.code install.packages('sysfonts')}"
    ))
  }

  if (!requireNamespace("showtext", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg showtext} is required to use custom fonts.",
      "i" = "Install with: {.code install.packages('showtext')}"
    ))
  }

  # Import fonts with error handling
  fonts_to_import <- list(
    list(name = "Poppins", family = "Poppins"),
    list(name = "Roboto", family = "Roboto"),
    list(name = "Roboto Condensed", family = "RobotoCondensed")
  )

  cli::cli_alert_info("Downloading fonts from Google Fonts...")

  for (font in fonts_to_import) {
    tryCatch(
      {
        sysfonts::font_add_google(name = font$name, family = font$family)
        cli::cli_alert_success("Imported {font$name}")
      },
      error = function(e) {
        cli::cli_abort(c(
          "Failed to import font {.val {font$name}}.",
          "x" = conditionMessage(e),
          "i" = "Check your internet connection and try again."
        ))
      }
    )
  }

  # Enable showtext
  showtext::showtext_auto()
  cli::cli_alert_success("Fonts ready to use!")

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
