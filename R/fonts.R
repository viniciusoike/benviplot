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
  poppins_registered <- tryCatch({
    if (!systemfonts_available) return(FALSE)
    registry <- systemfonts::registry_fonts()
    has_registry <- nrow(registry) > 0 &&
      any(grepl("Poppins", registry$family, ignore.case = TRUE))
    if (has_registry) return(TRUE)
    sys <- systemfonts::system_fonts()
    any(grepl("Poppins", sys$family, ignore.case = TRUE))
  }, error = function(e) FALSE)
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  cli::cli_h1("benviplot Font Status")

  if (poppins_registered) {
    cli::cli_alert_success("Poppins font: {.strong registered} (bundled)")
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

  if (poppins_registered && ragg_available) {
    cli::cli_alert_success(
      "{.fn theme_benvi} will use Poppins automatically with ragg devices."
    )
  } else if (poppins_registered && !ragg_available) {
    cli::cli_alert_info(
      "Poppins is registered but only works with ragg devices."
    )
    cli::cli_alert_info("Install ragg: {.code install.packages('ragg')}")
  }

  invisible(list(
    poppins_available = poppins_registered,
    ragg_available = ragg_available
  ))
}
