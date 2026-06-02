default_font_family <- function() {
  if (poppins_is_registered()) "Poppins" else "sans"
}

#' A theme for Benvi styled plots
#'
#' @description
#' A ggplot2 base theme for Benvi styled plots.
#'
#' The Poppins font is bundled with the package and registered automatically on
#' load when `systemfonts` is installed. When both `systemfonts` and `ragg` are
#' available, the theme uses Poppins by default. Otherwise it falls back to the
#' system's default sans-serif font.
#'
#' Registered fonts only work with systemfonts-aware devices (e.g.
#' [ragg::agg_png]). Base R devices (PDF, PostScript) cannot render them. If you
#' see font warnings when saving to PDF, pass `base_family = "sans"` or set
#' `options(theme_benvi.font_family = "sans")`. See [font_status()] to check
#' your setup.
#'
#' @param base_family Argument passed to [ggplot2::theme_minimal()]. Defaults
#'   to `"Poppins"` when the bundled font is registered and `ragg` is available,
#'   `"sans"` otherwise. Override globally with
#'   `options(theme_benvi.font_family = ...)`.
#' @param base_size Argument passed to [ggplot2::theme_minimal()]. Defaults to 10.
#' @param background Logical. Adds an offwhite (creme) background to the plot.
#'
#' @return A ggplot2 theme object
#' @importFrom ggplot2 %+replace% theme_minimal theme element_blank
#' element_line element_rect element_text margin rel
#' @export
#'
#' @examples
#' library(ggplot2)
#' series <- subset(iqaiw, name_muni == "S\u00e3o Paulo" & rooms == "Total")
#'
#' # Base theme (using "sans" for portability)
#' ggplot(series, aes(date, index)) +
#'   geom_line(color = benvi_palette("benvi_blue")[1], lwd = 1) +
#'   labs(x = NULL, y = "Index (base = 100)", title = "IQAIW") +
#'   theme_benvi(base_family = "sans")
#'
#' # Optional offwhite (creme) background
#' ggplot(series, aes(date, index)) +
#'   geom_line(color = benvi_palette("benvi_blue")[1], lwd = 1) +
#'   labs(x = NULL, y = "Index (base = 100)", title = "IQAIW") +
#'   theme_benvi(base_family = "sans", background = TRUE)
#'
#' \dontrun{
#' # Use Poppins with a ragg device (requires systemfonts and ragg)
#' ggplot(series, aes(date, index)) +
#'   geom_line(color = benvi_palette("benvi_blue")[1], lwd = 1) +
#'   labs(x = NULL, y = "Index (base = 100)", title = "IQAIW") +
#'   theme_benvi(base_family = "Poppins")
#' }
theme_benvi <- function(
  base_family = getOption("theme_benvi.font_family", default_font_family()),
  base_size = 10,
  background = FALSE
) {
  font_family <- if (is.null(base_family)) {
    getOption("theme_benvi.font_family", default_font_family())
  } else {
    base_family
  }

  bg <- ifelse(background, "#fbf5e7", "#FFFFFF")

  theme_minimal(base_family = font_family, base_size = base_size) %+replace%
    theme(
      # Remove minor panel grid lines
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "#e2e2e2"),

      # Background colors
      panel.background = element_rect(fill = bg, colour = bg),
      plot.background = element_rect(fill = bg, colour = bg),

      # Small legend always on top
      legend.position = "top",
      legend.box.margin = margin(0),
      legend.margin = margin(0),

      # Text elements
      text = element_text(
        family = font_family,
        color = "gray15"
      ),
      # Title
      plot.title = element_text(
        size = rel(1.27),
        color = "#000000",
        hjust = 0,
        margin = margin(0, 0, 5.5, 0)
      ),
      # Subtitle
      plot.subtitle = element_text(
        size = rel(0.91),
        color = "gray30",
        hjust = 0,
        vjust = 1,
        margin = margin(0, 0, 5.5, 0)
      ),
      # Caption
      plot.caption = element_text(
        size = rel(0.73),
        color = "gray30",
        hjust = 1,
        margin = margin(5.5, 0, 0, 0)
      ),

      # Plot margins
      plot.margin = margin(10, 10, 10, 10)
    )
}
