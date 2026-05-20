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
