#' Get Benvi colors by name
#'
#' Access individual Benvi colors by their names. When called without arguments,
#' returns all available color names.
#'
#' @param color_names Character vector of color names. If not provided, returns
#'   all available color names.
#'
#' @return A character vector of hex color codes (when `color_names` is provided),
#'   or a character vector of all available color names (when called without arguments).
#'
#' @export
#' @importFrom cli cli_abort
#'
#' @examples
#' # Get all available color names
#' benvi_colors()
#'
#' # Get specific colors
#' benvi_colors("Floresta")
#' benvi_colors(c("Floresta", "Violeta", "AzulQuinto"))
benvi_colors <- function(color_names) {

  if (missing(color_names)) {
    return(benvi_colors_data$name)
  }

  # Validate color names
  invalid <- color_names[!color_names %in% benvi_colors_data$name]

  if (length(invalid) > 0) {
    available_colors <- paste(benvi_colors_data$name, collapse = ", ")
    cli::cli_abort(c(
      "Color{?s} not found: {.val {invalid}}",
      "i" = "Available colors: {available_colors}"
    ))
  }

  # Return hex values
  idx <- match(color_names, benvi_colors_data$name)
  return(benvi_colors_data$hex[idx])

}

#' List available palette names
#'
#' Returns a character vector of available palette names, optionally filtered by type.
#'
#' @param type Character string specifying the palette type to filter. One of:
#'   * `"all"` (default): All palettes
#'   * `"theme"`: Theme palettes (grays, browns, yellows, etc.)
#'   * `"sequential"`: Sequential palettes (seq_*)
#'   * `"qualitative"`: Qualitative palettes (qual_*)
#'   * `"city"`: City-specific palettes (spo_*, rio_*, bhe_*)
#'   * `"brand"`: Brand palettes (basic, benvi_blue, benvi_purple)
#'
#' @return A character vector of palette names.
#'
#' @export
#' @importFrom cli cli_abort
#'
#' @examples
#' # List all palettes
#' list_palettes()
#'
#' # List theme palettes
#' list_palettes("theme")
#'
#' # List sequential palettes
#' list_palettes("sequential")
list_palettes <- function(type = "all") {

  all_names <- names(palette)

  result <- switch(
    type,
    all = all_names,
    theme = c("grays", "browns", "yellows", "greens", "blues", "purples", "pinks", "oranges"),
    sequential = c("seq_grays", "seq_browns", "seq_yellows", "seq_greens",
                   "seq_blues", "seq_purples", "seq_pinks", "seq_oranges"),
    qualitative = paste0("qual_", 1:9),
    city = c("spo_seq", "spo_div", "spo_qual", "rio_seq", "rio_div", "rio_qual", "bhe_seq", "bhe_div"),
    brand = c("basic", "benvi_blue", "benvi_purple"),
    {
      cli::cli_abort(c(
        "{.arg type} must be one of: {.val all}, {.val theme}, {.val sequential}, {.val qualitative}, {.val city}, or {.val brand}.",
        "x" = "You provided: {.val {type}}"
      ))
    }
  )

  return(result)

}

#' List available color names
#'
#' Returns a character vector of all available Benvi color names.
#'
#' @return A character vector of color names.
#'
#' @export
#'
#' @examples
#' list_colors()
list_colors <- function() {
  return(benvi_colors_data$name)
}

#' Display all Benvi palettes
#'
#' Visually displays all available Benvi palettes in a grid layout, similar to
#' `RColorBrewer::display.brewer.all()`. Optionally filter by palette type.
#'
#' @param type Character string specifying the palette type to display. One of:
#'   `"all"` (default), `"theme"`, `"sequential"`, `"qualitative"`, `"city"`, or `"brand"`.
#'   See [list_palettes()] for details.
#' @param n Number of colors to display from each palette. If `NULL` (default),
#'   shows all colors in each palette.
#'
#' @return Invisibly returns `NULL`. Called for its side effect of creating a plot.
#'
#' @export
#' @importFrom graphics par plot text rect
#'
#' @examples
#' # Display all palettes
#' show_palettes()
#'
#' # Display only theme palettes
#' show_palettes("theme")
#'
#' # Display sequential palettes
#' show_palettes("sequential")
show_palettes <- function(type = "all", n = NULL) {

  pal_names <- list_palettes(type)
  n_palettes <- length(pal_names)

  # Set up plotting area
  old_par <- par(mar = c(0.5, 5, 0.5, 0.5))
  on.exit(par(old_par))

  plot(0, 0, type = "n", xlim = c(0, 1), ylim = c(0, n_palettes),
       xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  # Draw each palette
  for (i in seq_along(pal_names)) {
    pal_name <- pal_names[i]
    colors <- if (is.null(n)) {
      benvi_palette(pal_name)
    } else {
      benvi_palette(pal_name, n = n, type = "continuous")
    }
    n_colors <- length(colors)

    # Draw color rectangles
    y_pos <- n_palettes - i + 0.5
    for (j in seq_len(n_colors)) {
      x_left <- (j - 1) / n_colors
      x_right <- j / n_colors
      rect(x_left, y_pos - 0.4, x_right, y_pos + 0.4,
           col = colors[j], border = NA)
    }

    # Add palette name
    text(-0.02, y_pos, labels = pal_name, adj = 1, cex = 0.8)
  }

  invisible(NULL)

}
