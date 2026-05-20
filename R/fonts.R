#' Check if Poppins font is available
#'
#' @description
#' Checks whether the Poppins font family is available, either registered from
#' the bundled copies (via `.onLoad`) or installed system-wide. Returns `FALSE`
#' silently if the `systemfonts` package is not installed.
#'
#' @return Logical: `TRUE` if Poppins is available, `FALSE` otherwise.
#' @keywords internal
check_poppins_installed <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    return(FALSE)
  }
  system_fonts <- systemfonts::system_fonts()
  registry_fonts <- systemfonts::registry_fonts()

  has_system <- any(grepl("Poppins", system_fonts$family, ignore.case = TRUE))
  has_registry <- nrow(registry_fonts) > 0 &&
    any(grepl("Poppins", registry_fonts$family, ignore.case = TRUE))

  has_system || has_registry
}

#' Install Poppins font system-wide from Google Fonts
#'
#' @description
#' Downloads and installs the Poppins font family from Google Fonts for
#' system-wide use. This is optional — `benviplot` already bundles Poppins and
#' registers it automatically on package load.
#'
#' Requires an internet connection. After a system-wide installation, the font
#' is available outside of R as well.
#'
#' @return Invisibly returns `TRUE` if installation succeeds, throws an error otherwise.
#' @export
#'
#' @examples
#' \dontrun{
#' install_poppins()
#' }
install_poppins <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    cli::cli_abort(c(
      "Package {.pkg systemfonts} is required to install fonts.",
      "i" = "Install with: {.code install.packages('systemfonts')}"
    ))
  }

  if (check_poppins_installed()) {
    cli::cli_alert_success("Poppins is already available.")
    return(invisible(TRUE))
  }

  cli::cli_alert_info("Downloading and installing Poppins from Google Fonts...")

  tryCatch(
    {
      systemfonts::get_from_google_fonts(
        "Poppins",
        weights = c(
          "regular",
          "italic",
          "500",
          "500italic",
          "600",
          "600italic",
          "700",
          "700italic"
        )
      )
      cli::cli_alert_success("Poppins installed successfully!")
      invisible(TRUE)
    },
    error = function(e) {
      cli::cli_abort(c(
        "Failed to install Poppins font.",
        "x" = conditionMessage(e),
        "i" = "Check your internet connection and try again."
      ))
    }
  )
}

#' Report benviplot font status
#'
#' @description
#' Reports whether Poppins is available and whether the `ragg` graphics device
#' is installed.
#'
#' @return Invisibly returns a list with `poppins_installed` and `ragg_available`.
#' @export
#'
#' @examples
#' font_status()
font_status <- function() {
  systemfonts_available <- requireNamespace("systemfonts", quietly = TRUE)
  poppins_available <- check_poppins_installed()
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  cli::cli_h1("benviplot Font Status")

  if (poppins_available) {
    cli::cli_alert_success("Poppins font: {.strong registered} (bundled)")
    cli::cli_alert_info(
      "Enable with: {.code options(theme_benvi.font_family = 'Poppins')}"
    )
  } else if (!systemfonts_available) {
    cli::cli_alert_warning("Poppins font: {.strong not available}")
    cli::cli_alert_info(
      "Install {.pkg systemfonts} to enable the bundled Poppins font:"
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
    cli::cli_alert_success("Your setup is optimal for benviplot!")
  }

  invisible(list(
    poppins_installed = poppins_available,
    ragg_available = ragg_available
  ))
}
