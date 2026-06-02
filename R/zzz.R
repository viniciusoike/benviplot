.onLoad <- function(libname, pkgname) {
  if (requireNamespace("systemfonts", quietly = TRUE)) {
    register_bundled_poppins(pkgname)
  }
}

register_bundled_poppins <- function(pkgname = "benviplot") {
  font_dir <- system.file("fonts", package = pkgname)
  if (!nzchar(font_dir)) return(invisible(NULL))

  f <- function(name) file.path(font_dir, name)

  tryCatch(
    systemfonts::register_font(
      name = "Poppins",
      plain = f("Poppins-Regular.ttf"),
      bold = f("Poppins-Bold.ttf"),
      italic = f("Poppins-Italic.ttf"),
      bolditalic = f("Poppins-BoldItalic.ttf")
    ),
    error = function(e) NULL
  )

  invisible(NULL)
}

poppins_is_registered <- function() {
  tryCatch(
    {
      if (!requireNamespace("systemfonts", quietly = TRUE)) return(FALSE)
      if (!requireNamespace("ragg", quietly = TRUE)) return(FALSE)

      registry <- systemfonts::registry_fonts()
      if (nrow(registry) > 0 &&
          any(grepl("Poppins", registry$family, ignore.case = TRUE))) {
        return(TRUE)
      }

      sys <- systemfonts::system_fonts()
      any(grepl("Poppins", sys$family, ignore.case = TRUE))
    },
    error = function(e) FALSE
  )
}
