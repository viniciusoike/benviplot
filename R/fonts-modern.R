#' Check if Poppins font is installed on the system
#'
#' @description
#' Checks whether the Poppins font family is available on the system. Returns
#' `FALSE` silently if the `systemfonts` package is not installed.
#'
#' @return Logical: `TRUE` if Poppins is installed, `FALSE` otherwise.
#' @keywords internal
check_poppins_installed <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    return(FALSE)
  }
  fonts <- systemfonts::system_fonts()
  any(grepl("Poppins", fonts$family, ignore.case = TRUE))
}

#' Install Poppins font from Google Fonts
#'
#' @description
#' Downloads and installs the Poppins font family from Google Fonts. This is a
#' one-time operation that makes the font available to all R sessions and
#' graphics devices.
#'
#' Requires the `systemfonts` package and an internet connection. After
#' installation, `theme_benvi()` will automatically use Poppins.
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
    cli::cli_alert_success("Poppins is already installed on your system.")
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
        "i" = "Check your internet connection and try again.",
        "i" = "You can also install Poppins manually from {.url https://fonts.google.com/specimen/Poppins}"
      ))
    }
  )
}

#' Report benviplot font status
#'
#' @description
#' Reports whether Poppins is installed and whether the `ragg` graphics device
#' is available, with actionable recommendations for each.
#'
#' @return Invisibly returns a list with `poppins_installed` and `ragg_available`.
#' @export
#'
#' @examples
#' font_status()
font_status <- function() {
  poppins_installed <- check_poppins_installed()
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  cli::cli_h1("benviplot Font Status")

  if (poppins_installed) {
    cli::cli_alert_success("Poppins font: {.strong installed}")
  } else {
    cli::cli_alert_warning("Poppins font: {.strong not installed}")
    cli::cli_alert_info("Install with: {.code benviplot::install_poppins()}")
  }

  if (ragg_available) {
    cli::cli_alert_success("ragg package: {.strong available}")
  } else {
    cli::cli_alert_info(
      "ragg package: not installed (optional but recommended)"
    )
    cli::cli_alert_info("Install with: {.code install.packages('ragg')}")
  }

  if (poppins_installed && ragg_available) {
    cli::cli_alert_success("Your setup is optimal for benviplot!")
  }

  invisible(list(
    poppins_installed = poppins_installed,
    ragg_available = ragg_available
  ))
}
