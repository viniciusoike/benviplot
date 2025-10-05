#' Plot a histogram chart
#'
#' @param data A data.frame type object
#' @param x <[`data-masked`][ggplot2::aes_eval]> Indicates the numeric variable to be mapped
#' @param color Color of the line of column.
#' @param fill Color of the inner part of the column.
#' @param zero Logical indicating if a horizontal (y = 0) line should be drawn
#' on the plot.
#' @param bins Number of bins.
#' @param method Character indicating an algorithm to compute optimal number of
#' bins. See details. Overriden by bins. Defaults to `method = "fd"`.
#' @param density Logical indicating if density should be plotted on y-axis.
#' @param facet <[`data-masked`][ggplot2::aes_eval]> Optional variable to facet the graphics.
#' @param ... Additional parameters to `facet_wrap()`
#'
#' @return A ggplot2 object
#' @export
#' @importFrom ggplot2 ggplot aes geom_histogram facet_wrap after_stat vars
#' @importFrom cli cli_abort
#'
#' @examples
#' set.seed(5)
#' tbl <- data.frame(x = rnorm(n = 1000))
#'
#' # Default parameters use Freedman-Diaconis
#' plot_histogram(data = tbl, x = x)
#' # Use bins to manually choose number of bins
#' plot_histogram(data = tbl, x = x, bins = 50)
#' # Example of alternative methods: square root and Rice
#' plot_histogram(data = tbl, x = x, method = "sqrt")
#' plot_histogram(data = tbl, x = x, method = "Rice")
#'
#' # To compare multiple groups use facet
#' tbl <- data.frame(
#' city = rep(c("A", "B", "C"), each.out = 500),
#' x = c(rnorm(500), runif(500), rexp(500))
#' )
#' plot_histogram(data = tbl, x = x, facet = city, density = TRUE)
plot_histogram <- function(
    data,
    x,
    color = "#FFFFFF",
    fill = "#3957BD",
    zero = TRUE,
    bins = NULL,
    method = "fd",
    density = FALSE,
    facet = FALSE,
    ...) {

  histBinsMethods <- c("sqrt", "Sturges", "Rice", "Scott", "FD", "fd")

  if (!is.null(bins) && is.numeric(bins)) {

    if (isFALSE(density)) {
      p <-
        ggplot() +
        geom_histogram(
          data = data,
          aes(x = {{x}}),
          color = color,
          fill = fill,
          bins = bins
        )
    } else {
      p <-
        ggplot() +
        geom_histogram(
          data = data,
          aes(x = {{x}}, y = after_stat(density)),
          color = color,
          fill = fill,
          bins = bins
        )
    }

  } else {

    if (is.character(method)) {

      if (!method %in% histBinsMethods) {
        cli::cli_abort(c(
          "{.arg method} must be one of: {.or {histBinsMethods}}.",
          "x" = "You provided: {.val {method}}"
        ))
      }

      if(isFALSE(density)) {

        p <-
          ggplot() +
          geom_histogram(
            data = data,
            aes(x = {{x}}),
            color = color,
            fill = fill,
            binwidth = function(x) get_hist_bw(x, type = method)
          )

      } else {

        p <-
          ggplot() +
          geom_histogram(
            data = data,
            aes(x = {{x}}, y = after_stat(density)),
            color = color,
            fill = fill,
            binwidth = function(x) get_hist_bw(x, type = method)
          )

      }

  }

  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  if (!missing(facet)) {
    p <- p + facet_wrap(vars({{ facet }}), ...)
  }

  p <- p +
    theme_benvi()

  return(p)

}


#' Get width of histogram interval
#'
#' @param x A numeric vector
#' @param type Type of formula used
#'
#' @return An integer
#' @importFrom stats IQR sd
get_hist_bw <- function(x, type = "FD") {

  # Normalize type to uppercase for switch
  type <- toupper(type)

  h <- switch(
    type,
    FD = 2 * IQR(x) / length(x)^(1/3),
    SCOTT = 3 * sd(x) / length(x)^(1/3),
    RICE = {
      k <- ceiling(2 * length(x)^(1/3))
      ceiling((max(x) - min(x)) / k)
    },
    SQRT = {
      k <- ceiling(sqrt(length(x)))
      ceiling((max(x) - min(x)) / k)
    },
    STURGES = {
      k <- ceiling(log(length(x), base = 2))
      ceiling((max(x) - min(x)) / k)
    }
  )

  return(h)

}
