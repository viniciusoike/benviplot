#' Check if Poppins font is installed on the system
#'
#' @description
#' Checks whether the Poppins font family is available on the system by querying
#' installed system fonts.
#'
#' @return Logical value: `TRUE` if Poppins is installed, `FALSE` otherwise.
#' @export
#'
#' @examples
#' check_poppins_installed()
check_poppins_installed <- function() {
  fonts <- systemfonts::system_fonts()
  any(grepl("Poppins", fonts$family, ignore.case = TRUE))
}

#' Install Poppins font from Google Fonts
#'
#' @description
#' Downloads and installs the Poppins font family from Google Fonts to your
#' system. This is a one-time operation that makes the font available to all
#' R sessions and graphics devices.
#'
#' **Note:** This function requires an internet connection and may require
#' administrative privileges on some systems.
#'
#' @return Invisibly returns `TRUE` if installation succeeds, throws an error otherwise.
#' @export
#'
#' @examples
#' \dontrun{
#' # Install Poppins font (requires internet connection)
#' install_poppins()
#' }
install_poppins <- function() {

  # Check if already installed
  if (check_poppins_installed()) {
    cli::cli_alert_success("Poppins is already installed on your system")
    return(invisible(TRUE))
  }

  cli::cli_alert_info("Downloading and installing Poppins font from Google Fonts...")

  # Try to install the font using systemfonts
  tryCatch(
    {
      # Download and register Poppins from Google Fonts
      systemfonts::get_from_google_fonts(
        "Poppins",
        weights = c("regular", "italic", "500", "500italic", "600", "600italic", "700", "700italic")
      )

      cli::cli_alert_success("Poppins font installed successfully!")
      cli::cli_alert_info("The font is now available for all R graphics")

      invisible(TRUE)
    },
    error = function(e) {
      cli::cli_abort(c(
        "Failed to install Poppins font",
        "x" = conditionMessage(e),
        "i" = "Check your internet connection and try again",
        "i" = "You can also install Poppins manually from {.url https://fonts.google.com/specimen/Poppins}"
      ))
    }
  )
}

#' Get font installation status and recommendations
#'
#' @description
#' Reports the current font setup status, including whether Poppins is installed,
#' whether ragg is available, and provides actionable recommendations.
#'
#' @return Invisibly returns a list with status information. Prints a formatted
#'   report to the console.
#' @export
#'
#' @examples
#' font_status()
font_status <- function() {

  # Check Poppins installation
  poppins_installed <- check_poppins_installed()

  # Check if ragg is available
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  # Create status report
  cli::cli_h1("benviplot Font Status")

  # Poppins status
  if (poppins_installed) {
    cli::cli_alert_success("Poppins font: {.strong installed}")
  } else {
    cli::cli_alert_warning("Poppins font: {.strong not installed}")
    cli::cli_alert_info("Install with: {.code benviplot::install_poppins()}")
  }

  # ragg status
  if (ragg_available) {
    cli::cli_alert_success("ragg package: {.strong available}")
  } else {
    cli::cli_alert_info("ragg package: {.strong not installed (optional)}")
    cli::cli_alert_info("Install for better graphics: {.code install.packages('ragg')}")
  }

  # Recommendations
  cli::cli_h2("Recommendations")

  if (!poppins_installed) {
    cli::cli_alert("Run {.code setup_benvi_fonts()} for one-command setup")
  } else if (!ragg_available) {
    cli::cli_alert("Consider installing ragg for optimal output quality")
  } else {
    cli::cli_alert_success("Your setup is optimal for using benviplot!")
    cli::cli_alert_info("Configure RStudio to use ragg device in Global Options > General > Graphics")
  }

  # Return invisibly
  invisible(list(
    poppins_installed = poppins_installed,
    ragg_available = ragg_available
  ))
}

#' One-command setup for benviplot fonts
#'
#' @description
#' Performs a complete font setup for benviplot in one command:
#' 1. Checks if Poppins is installed
#' 2. Installs Poppins if missing
#' 3. Provides guidance for RStudio configuration
#'
#' This is the recommended way to set up fonts for benviplot.
#'
#' @return Invisibly returns `TRUE` on success.
#' @export
#'
#' @examples
#' \dontrun{
#' # Complete font setup (requires internet connection)
#' setup_benvi_fonts()
#' }
setup_benvi_fonts <- function() {

  cli::cli_h1("Setting up benviplot fonts")

  # Step 1: Install Poppins
  cli::cli_h2("Step 1: Installing Poppins font")
  install_poppins()  # This will skip if already installed

  # Step 2: Check ragg
  cli::cli_h2("Step 2: Checking graphics device")
  ragg_available <- requireNamespace("ragg", quietly = TRUE)

  if (ragg_available) {
    cli::cli_alert_success("ragg package is installed")
  } else {
    cli::cli_alert_warning("ragg package is not installed")
    cli::cli_alert_info("For best results, install ragg:")
    cli::cli_code("install.packages('ragg')")
  }

  # Step 3: RStudio configuration
  cli::cli_h2("Step 3: RStudio configuration (optional)")
  cli::cli_alert_info("To use ragg device in RStudio:")
  cli::cli_ol(c(
    "Go to {.strong Tools > Global Options > General > Graphics}",
    "Set {.strong Backend} to {.strong AGG}",
    "Restart RStudio"
  ))

  cli::cli_h2("Setup complete!")
  cli::cli_alert_success("You're ready to create beautiful plots with benviplot")

  invisible(TRUE)
}

#' Get available Poppins font variants
#'
#' @description
#' Lists all available Poppins font variants (weights and styles) installed on
#' the system. Useful for advanced font customization.
#'
#' @return A character vector of available Poppins variants, or `NULL` if
#'   Poppins is not installed.
#' @export
#'
#' @examples
#' \dontrun{
#' # List available Poppins variants
#' get_poppins_variants()
#' }
get_poppins_variants <- function() {

  if (!check_poppins_installed()) {
    cli::cli_alert_warning("Poppins is not installed")
    return(NULL)
  }

  fonts <- systemfonts::system_fonts()
  poppins_fonts <- fonts[grepl("Poppins", fonts$family, ignore.case = TRUE), ]

  variants <- unique(paste(poppins_fonts$style, poppins_fonts$weight))

  if (length(variants) > 0) {
    cli::cli_alert_info("Available Poppins variants:")
    cli::cli_ul(variants)
  }

  invisible(variants)
}
