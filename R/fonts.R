#' Report benviplot font status
#'
#' @description
#' Reports whether Poppins is available and whether the `ragg` graphics device
#' is installed.
#'
#' @return Invisibly returns a list with `poppins_available` and `ragg_available`.
#' @export
#'
#' @examples
#' font_status()
font_status <- function() {
  systemfonts_available <- requireNamespace("systemfonts", quietly = TRUE)

  poppins_source <- "none"
  if (systemfonts_available) {
    tryCatch({
      registry <- systemfonts::registry_fonts()
      if (nrow(registry) > 0 &&
          any(grepl("Poppins", registry$family, ignore.case = TRUE))) {
        poppins_source <- "registered"
      } else {
        sys <- systemfonts::system_fonts()
        if (any(grepl("Poppins", sys$family, ignore.case = TRUE))) {
          poppins_source <- "system"
        }
      }
    }, error = function(e) NULL)
  }

  poppins_available <- poppins_source != "none"
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  cli::cli_h1("benviplot Font Status")

  if (poppins_source == "registered") {
    cli::cli_alert_success("Poppins font: {.strong registered} (bundled)")
  } else if (poppins_source == "system") {
    cli::cli_alert_success("Poppins font: {.strong available} (system)")
  } else if (!systemfonts_available) {
    cli::cli_alert_warning("Poppins font: {.strong not available}")
    cli::cli_alert_info(
      "Install {.pkg systemfonts} to enable the bundled Poppins font"
    )
    cli::cli_alert_info("{.code install.packages('systemfonts')}")
  } else {
    cli::cli_alert_warning("Poppins font: {.strong not registered}")
    cli::cli_alert_info(
      "Try reloading the package: {.code library(benviplot)}"
    )
  }

  if (ragg_available) {
    cli::cli_alert_success("ragg package: {.strong available}")
  } else {
    cli::cli_alert_info(
      "ragg package: not installed (optional but recommended)"
    )
    cli::cli_alert_info("Install with: {.code install.packages('ragg')}")
  }

  if (poppins_available && ragg_available) {
    cli::cli_alert_success(
      "{.fn theme_benvi} will use Poppins automatically with ragg devices."
    )
  } else if (poppins_available && !ragg_available) {
    cli::cli_alert_info(
      "Poppins is registered but only works with ragg devices."
    )
    cli::cli_alert_info("Install ragg: {.code install.packages('ragg')}")
  }

  invisible(list(
    poppins_available = poppins_available,
    ragg_available = ragg_available
  ))
}
