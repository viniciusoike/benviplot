#' A base custom theme for ggplot plots
#'
#' @description A base theme for ggplot plots in a Benvi style. Called by
#' `theme_benvi`.
#'
#' @param ... Further arguments to `theme_minimal`
#'
#' @importFrom ggplot2 %+replace% theme_minimal theme element_blank element_rect
#' element_text margin
theme_custom <- function(...) {
  theme_minimal(...) %+replace%
    theme(
      # Remove minor panel grid lines
      panel.grid.minor = element_blank(),

      # Background colors
      panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"),
      plot.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"),

      # Small legend always on top
      legend.position = "top",
      legend.box.margin = margin(0),
      legend.margin = margin(0),

      # Text elements
      text = element_text(
        family = "Poppins",
        size = 10,
        color = "gray15"),
      # Title
      plot.title = element_text(
        size = 12,
        color = "#000000",
        hjust = 0),
      # Subtitle
      plot.subtitle = element_text(
        size = 8,
        color = "gray30",
        hjust = 0,
        vjust = 1,
        margin = margin(2.5, 0, 5, 0, unit = "pt")),
      # Caption
      plot.caption  = element_text(
        size = 6,
        color = "gray30",
        hjust = 1)
    )
}

#' A base theme for Benvi plots
#'
#' @description A ggplot2 base theme for Benvi styled plots.
#' @export
theme_benvi <- function() {
  theme_custom()
}
