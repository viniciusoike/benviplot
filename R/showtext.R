.onLoad <- function(libname, pkgname) {

  sysfonts::font_add("Poppins",
           regular = "Poppins-Regular.ttf",
           bold = "Poppins-Bold.ttf",
           italic = "Poppins-Italic.ttf")
  sysfonts::font_add("Roboto",
           regular = "Roboto-Regular.ttf",
           bold = "Roboto-Bold.ttf",
           italic = "Roboto-Italic.ttf")

  showtext::showtext_auto()

}
