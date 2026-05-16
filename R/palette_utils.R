#' Display all Benvi palettes
#'
#' Visually displays all available Benvi palettes in a grid layout, similar to
#' `RColorBrewer::display.brewer.all()`. Optionally filter by palette type.
#'
#' @param type Character string specifying the palette type to display. One of:
#'   `"all"` (default), `"theme"`, `"sequential"`, `"qualitative"`, `"city"`, or `"brand"`.
#' @param n Number of colors to display from each palette. If `NULL` (default),
#'   shows all colors in each palette.
#'
#' @return Invisibly returns `NULL`. Called for its side effect of creating a plot.
#'
#' @export
#' @importFrom graphics par plot text rect
#' @importFrom cli cli_abort
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
  all_names <- names(palette)

  pal_names <- switch(
    type,
    all = all_names,
    theme = c(
      "grays",
      "browns",
      "yellows",
      "greens",
      "blues",
      "purples",
      "pinks",
      "oranges"
    ),
    sequential = c(
      "seq_grays",
      "seq_browns",
      "seq_yellows",
      "seq_greens",
      "seq_blues",
      "seq_purples",
      "seq_pinks",
      "seq_oranges"
    ),
    qualitative = paste0("qual_", 1:9),
    city = c(
      "spo_seq",
      "spo_div",
      "spo_qual",
      "rio_seq",
      "rio_div",
      "rio_qual",
      "bhe_seq",
      "bhe_div"
    ),
    brand = c("basic", "benvi_blue", "benvi_purple"),
    cli::cli_abort(c(
      "{.arg type} must be one of: {.val all}, {.val theme}, {.val sequential}, {.val qualitative}, {.val city}, or {.val brand}.",
      "x" = "You provided: {.val {type}}"
    ))
  )

  n_palettes <- length(pal_names)

  left_margin <- max(5, ceiling(max(nchar(pal_names)) * 0.6) + 1)
  old_par <- par(mar = c(0.5, left_margin, 0.5, 0.5))
  on.exit(par(old_par))

  plot(
    0,
    0,
    type = "n",
    xlim = c(0, 1),
    ylim = c(0, n_palettes),
    xlab = "",
    ylab = "",
    xaxt = "n",
    yaxt = "n",
    bty = "n"
  )

  for (i in seq_along(pal_names)) {
    pal_name <- pal_names[i]
    colors <- if (is.null(n)) {
      benvi_palette(pal_name)
    } else {
      benvi_palette(pal_name, n = n, type = "continuous")
    }
    n_colors <- length(colors)

    y_pos <- n_palettes - i + 0.5
    for (j in seq_len(n_colors)) {
      x_left <- (j - 1) / n_colors
      x_right <- j / n_colors
      rect(
        x_left,
        y_pos - 0.4,
        x_right,
        y_pos + 0.4,
        col = colors[j],
        border = NA
      )
    }

    text(-0.04, y_pos, labels = pal_name, adj = 1, cex = 0.8)
  }

  invisible(NULL)
}
