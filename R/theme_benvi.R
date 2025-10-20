#' Get the font family to use for benviplot themes
#'
#' @description
#' Determines which font family to use based on system font availability.
#' Prefers Poppins if installed, otherwise falls back to "sans".
#'
#' Shows a one-time message if Poppins is not installed, suggesting installation.
#'
#' @return Character string with font family name
#' @keywords internal
get_benvi_font_family <- function() {
  # Check if Poppins is installed
  poppins_available <- check_poppins_installed()

  if (poppins_available) {
    return("Poppins")
  }

  # Show message only once per session
  if (!isTRUE(getOption("benviplot.font_message_shown"))) {
    cli::cli_alert_info(
      "Poppins font not found. Using system default font instead."
    )
    cli::cli_alert_info(
      "Install Poppins with: {.code benviplot::install_poppins()}"
    )
    options(benviplot.font_message_shown = TRUE)
  }

  return("sans")
}

#' A base custom theme for ggplot plots
#'
#' @description A base theme for ggplot plots in a Benvi style. Called by
#' `theme_benvi`.
#'
#' @param ... Further arguments to `theme_minimal`
#' @keywords internal
#'
#' @importFrom ggplot2 %+replace% theme_minimal theme element_blank element_rect
#' element_text margin rel
theme_custom <- function(...) {
  # Get font family (Poppins or fallback to sans)
  font_family <- get_benvi_font_family()

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
        family = font_family,
        size = 11,
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

#' A base theme for Benvi plots
#'
#' @description
#' A ggplot2 base theme for Benvi styled plots with clean, professional styling.
#'
#' This theme uses the Poppins font if installed on your system. If Poppins is
#' not available, it falls back to the system's default sans-serif font.
#'
#' To install Poppins, run [install_poppins()] or [setup_benvi_fonts()].
#'
#' @return A ggplot2 theme object
#' @export
#'
#' @seealso [install_poppins()], [setup_benvi_fonts()], [font_status()]
#'
#' @examples
#' library(ggplot2)
#'
#' # Simple scatter plot with benvi theme
#' spo_sales <- subset(sales_report, name_muni == "São Paulo" & date == max(date))
#' ggplot(spo_sales, aes(price_m2_listing, price_m2_contract)) +
#'   geom_point() +
#'   labs(title = "Listing vs Contract Prices") +
#'   theme_benvi()
theme_benvi <- function() {
  theme_custom()
}
