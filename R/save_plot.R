#' Save a ggplot with benviplot optimizations
#'
#' @description
#' A wrapper around [ggplot2::ggsave()] with smart defaults optimized for
#' benviplot graphics. Automatically uses the ragg graphics device for PNG
#' output when available, ensuring high-quality rendering with proper font
#' support and no DPI issues.
#'
#' If ragg is not installed, falls back to the default graphics device.
#'
#' @param filename File name to create on disk. The file extension determines
#'   the graphics device (e.g., ".png", ".pdf", ".svg").
#' @param plot Plot to save. Defaults to the last plot displayed.
#' @param device Device to use. Defaults to "ragg" for PNG files if ragg package
#'   is installed, otherwise uses ggplot2's default device selection.
#' @param width,height Plot size in units. Defaults to 7 x 5 inches.
#' @param units Units for width and height ("in", "cm", "mm", "px"). Default is "in".
#' @param dpi DPI to use for raster graphics. Default is 300 for high quality.
#' @param ... Additional arguments passed to [ggplot2::ggsave()].
#'
#' @return Invisibly returns the filename.
#' @export
#'
#' @seealso [ggplot2::ggsave()]
#'
#' @examples
#' p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) + ggplot2::geom_point()
#' ggsave_benvi(tempfile(fileext = ".png"), plot = p)
#'
#' @importFrom ggplot2 ggsave
ggsave_benvi <- function(
  filename,
  plot = ggplot2::last_plot(),
  device = NULL,
  width = 7,
  height = 5,
  units = "in",
  dpi = 300,
  ...
) {
  # Determine file extension
  ext <- tolower(tools::file_ext(filename))

  # Use ragg device for PNG if available
  if (is.null(device) && ext == "png") {
    if (requireNamespace("ragg", quietly = TRUE)) {
      device <- ragg::agg_png
      if (!isTRUE(getOption("benviplot.ragg_message_shown"))) {
        cli::cli_alert_success("Using ragg device for high-quality PNG output")
        options(benviplot.ragg_message_shown = TRUE)
      }
    } else {
      if (!isTRUE(getOption("benviplot.ragg_suggest_shown"))) {
        cli::cli_alert_info(
          "Install ragg for better PNG quality: {.code install.packages('ragg')}"
        )
        options(benviplot.ragg_suggest_shown = TRUE)
      }
    }
  }

  # Call ggsave with our parameters
  ggplot2::ggsave(
    filename = filename,
    plot = plot,
    device = device,
    width = width,
    height = height,
    units = units,
    dpi = dpi,
    ...
  )

  invisible(filename)
}
