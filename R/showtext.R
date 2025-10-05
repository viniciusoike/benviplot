.onLoad <- function(libname, pkgname) {

  # Silently attempt to load fonts if packages are available
  if (requireNamespace("sysfonts", quietly = TRUE) &&
      requireNamespace("showtext", quietly = TRUE)) {

    # Try to load Google fonts silently
    tryCatch(
      {
        sysfonts::font_add_google("Poppins", family = "Poppins")
        sysfonts::font_add_google("Roboto", family = "Roboto")
        showtext::showtext_auto()
      },
      error = function(e) {
        # Silent failure - will notify in .onAttach if needed
        invisible(NULL)
      }
    )
  }

}

.onAttach <- function(libname, pkgname) {

  # Check if font packages are missing
  if (!requireNamespace("sysfonts", quietly = TRUE) ||
      !requireNamespace("showtext", quietly = TRUE)) {
    packageStartupMessage(
      "Note: Packages 'sysfonts' and 'showtext' are recommended for custom fonts.\n",
      "Install with: install.packages(c('sysfonts', 'showtext'))"
    )
  }

}
