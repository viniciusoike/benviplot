#' Plot a histogram chart
#'
#' @param data A data.frame type object
#' @param x <[`data-masked`][ggplot2::aes_eval]> Indicates the numeric variable to be mapped
#' @param color Color of the column border. Defaults to `"#FFFFFF"` (white).
#' @param fill Fill color for the columns. Either a color string (e.g., `"blue"`,
#'   `"#021841"`) for a single static color, or a bare column name (without
#'   quotes) to map a grouping variable to fill color.
#' @param pal_name String indicating the name of which palette to use when
#'   `fill` is a variable mapping.
#' @param scale_name String indicating fill legend title.
#' @param zero Logical indicating if a horizontal (y = 0) line should be drawn
#' on the plot.
#' @param bins Number of bins. When specified, overrides `method`.
#' @param method Character specifying the binning algorithm. Must be one of:
#'   `"fd"` (default), `"FD"`, `"Scott"`, `"Sturges"`, `"Rice"`, or `"sqrt"`.
#'   See Details for algorithm descriptions. Ignored when `bins` is specified.
#' @param density Logical indicating if density should be plotted on y-axis.
#' @param facet <[`data-masked`][ggplot2::aes_eval]> Optional variable to facet the graphics.
#' @param ... Additional parameters to `facet_wrap()`
#'
#' @details
#' ## Binning Methods
#'
#' The `method` parameter controls which algorithm is used to compute the optimal
#' bin width. Available methods:
#'
#' \describe{
#'   \item{`"fd"` or `"FD"`}{**Freedman-Diaconis rule** (default). Robust to
#'     outliers, uses IQR. Formula: \eqn{2 * IQR / n^{1/3}}. Best for most
#'     distributions.}
#'   \item{`"Scott"`}{**Scott's rule**. Uses standard deviation. Formula:
#'     \eqn{3 * sd / n^{1/3}}. Works well for normal-like distributions.}
#'   \item{`"Sturges"`}{**Sturges' formula**. Simple logarithmic rule. Formula:
#'     \eqn{k = \lceil log_2(n) \rceil} bins. Good for roughly normal data.}
#'   \item{`"Rice"`}{**Rice rule**. Cube root based. Formula:
#'     \eqn{k = \lceil 2n^{1/3} \rceil} bins. General purpose rule.}
#'   \item{`"sqrt"`}{**Square root rule**. Formula: \eqn{k = \lceil \sqrt{n} \rceil}
#'     bins. Simple, tends to oversmooth.}
#' }
#'
#' When in doubt, use the default `"fd"` (Freedman-Diaconis), which is robust
#' and works well across different distributions.
#'
#' @return A ggplot2 object
#' @export
#' @importFrom ggplot2 ggplot aes geom_histogram facet_wrap after_stat vars
#' @importFrom rlang enquo
#' @importFrom cli cli_abort
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
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
#' # Facet by rooms category
#' spo <- subset(iqaiw, name_muni == "S\u00e3o Paulo" & rooms != "Total")
#' plot_histogram(data = spo, x = index, facet = rooms)
#' \dontshow{options(.op)}
plot_histogram <- function(
  data,
  x,
  color = "#FFFFFF",
  fill = NULL,
  pal_name = "qual_benvi",
  scale_name = "",
  zero = TRUE,
  bins = NULL,
  method = "fd",
  density = FALSE,
  facet = FALSE,
  ...
) {
  histBinsMethods <- c("sqrt", "Sturges", "Rice", "Scott", "FD", "fd")

  fill_quo <- rlang::enquo(fill)
  fill_type <- detect_aesthetic_type(fill_quo, "fill", data)
  static_fill <- if (fill_type$type == "static_color") fill_type$value else "#021841"

  # Build aes mapping
  if (fill_type$type == "variable_mapping") {
    hist_mapping <- if (isTRUE(density)) {
      aes(x = {{ x }}, y = ggplot2::after_stat(density), fill = !!fill_quo)
    } else {
      aes(x = {{ x }}, fill = !!fill_quo)
    }
  } else {
    hist_mapping <- if (isTRUE(density)) {
      aes(x = {{ x }}, y = ggplot2::after_stat(density))
    } else {
      aes(x = {{ x }})
    }
  }

  # Build binning arguments
  if (!is.null(bins) && is.numeric(bins)) {
    bw_args <- list(bins = bins)
  } else {
    if (!method %in% histBinsMethods) {
      cli::cli_abort(c(
        "{.arg method} must be one of: {.or {histBinsMethods}}.",
        "x" = "You provided: {.val {method}}"
      ))
    }
    bw_args <- list(binwidth = function(x) get_hist_bw(x, type = method))
  }

  # Build geom args and construct plot
  base_args <- c(list(data = data, mapping = hist_mapping, color = color), bw_args)
  if (fill_type$type != "variable_mapping") {
    base_args$fill <- static_fill
  }

  p <- ggplot2::ggplot() + do.call(geom_histogram, base_args)

  if (fill_type$type == "variable_mapping") {
    p <- p + scale_fill_benvi_d(pal_name = pal_name, name = scale_name)
  }

  if (isTRUE(zero)) {
    p <- p + geom_hline(yintercept = 0)
  }

  if (!missing(facet)) {
    p <- p + facet_wrap(vars({{ facet }}), ...)
  }

  p <- p + theme_benvi()

  return(p)
}


#' Get width of histogram interval
#'
#' @param x A numeric vector
#' @param type Type of formula used
#' @keywords internal
#'
#' @return An integer
#' @importFrom stats IQR sd
get_hist_bw <- function(x, type = "FD") {
  # Normalize type to uppercase for switch
  type <- toupper(type)

  h <- switch(
    type,
    FD = 2 * IQR(x) / length(x)^(1 / 3),
    SCOTT = 3 * sd(x) / length(x)^(1 / 3),
    RICE = {
      k <- ceiling(2 * length(x)^(1 / 3))
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
