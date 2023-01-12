

# font_add("Poppins",
#          regular = "Poppins-Regular.ttf",
#          bold = "Poppins-Bold.ttf",
#          italic = "Poppins-Italic.ttf")
# font_add("Roboto",
#          regular = "Roboto-Regular.ttf",
#          bold = "Roboto-Bold.ttf",
#          italic = "Roboto-Italic.ttf")
# font_add("Helvetica", "Helvetica.ttc")

theme_benvi <- ggplot2::theme_minimal() +
  ggplot2::theme(
    panel.grid.minor = ggplot2::element_blank(),

    panel.background = ggplot2::element_rect(fill = "#FFFFFF", colour = "#FFFFFF"),
    plot.background = ggplot2::element_rect(fill = "#FFFFFF", colour = "#FFFFFF"),

    legend.position = "top",
    legend.box.margin = ggplot2::margin(0),
    legend.margin = ggplot2::margin(0),

    text = ggplot2::element_text(family = "Helvetica", size = 10, color = "gray15"),
    plot.title = ggplot2::element_text(size = 12, color = "#000000"),
    plot.subtitle = ggplot2::element_text(size = 8, color = "gray30"),
    plot.caption  = ggplot2::element_text(size = 6, color = "gray30"),
    axis.text.x = ggplot2::element_text(angle = 90)
  )
