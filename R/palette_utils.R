#' Display all Benvi palettes
#'
#' Visually displays all available Benvi palettes in a grid layout, modelled on
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
#' @importFrom graphics axis par plot rect
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
    all         = all_names,
    theme       = c("grays", "browns", "yellows", "greens", "blues", "purples", "pinks", "oranges"),
    sequential  = c("seq_grays", "seq_browns", "seq_yellows", "seq_greens",
                    "seq_blues", "seq_purples", "seq_pinks", "seq_oranges"),
    qualitative = paste0("qual_", 1:9),
    city        = c("spo_seq", "spo_div", "spo_qual", "rio_seq", "rio_div", "rio_qual", "bhe_seq", "bhe_div"),
    brand       = c("basic", "benvi_blue", "benvi_purple"),
    cli::cli_abort(c(
      "{.arg type} must be one of: {.val all}, {.val theme}, {.val sequential}, {.val qualitative}, {.val city}, or {.val brand}.",
      "x" = "You provided: {.val {type}}"
    ))
  )

  n_palettes  <- length(pal_names)
  left_margin <- max(5, ceiling(max(nchar(pal_names)) * 0.65) + 1)

  old_par <- par(mar = c(0.5, left_margin, 0.5, 0.5))
  on.exit(par(old_par))

  plot(c(0, 1), c(0, n_palettes),
       type = "n", axes = FALSE, xlab = "", ylab = "", bty = "n")

  for (i in seq_along(pal_names)) {
    pal_name <- pal_names[i]
    colors   <- if (is.null(n)) {
      benvi_palette(pal_name)
    } else {
      benvi_palette(pal_name, n = n, type = "continuous")
    }
    n_colors <- length(colors)
    y_bottom <- n_palettes - i
    y_top    <- y_bottom + 0.9

    for (j in seq_len(n_colors)) {
      rect((j - 1) / n_colors, y_bottom, j / n_colors, y_top,
           col = colors[j], border = NA)
    }
  }

  # Labels drawn via axis() so they render in the margin without clipping
  axis(2,
       at     = seq(n_palettes - 0.5, 0.5, by = -1),
       labels = pal_names,
       las    = 2,
       tick   = FALSE,
       cex.axis = 0.75)

  invisible(NULL)
}
