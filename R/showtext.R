.onLoad <- function(libname, pkgname) {

  # import_pop <- sysfonts::font_add(
  #   "Poppins",
  #   regular = "Poppins-Regular.ttf",
  #   bold = "Poppins-Bold.ttf",
  #   italic = "Poppins-Italic.ttf")
  #
  # sysfonts::font_add(
  #   "Roboto",
  #   regular = "Roboto-Regular.ttf",
  #   bold = "Roboto-Bold.ttf",
  #   italic = "Roboto-Italic.ttf")

  sysfonts::font_add_google("Poppins", family = "Poppins")
  sysfonts::font_add_google("Roboto", family = "Roboto")

  showtext::showtext_auto()

}
