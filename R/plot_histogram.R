#' Plot a histogram chart
#'
#' @param data A data frame.
#' @param x <[`data-masked`][ggplot2::aes_eval]> Numeric variable mapped to the
#'   x-axis.
#' @param color Color of the column border. Defaults to `"#FFFFFF"` (white).
#' @param fill Fill color for the columns. Either a color string (e.g., `"blue"`,
#'   `"#021841"`) for a single static color, or a bare column name (without
#'   quotes) to map a grouping variable to fill color.
#' @param pal_name Name of the palette used when `fill` maps a variable.
#' @param scale_name Fill legend title.
#' @param zero Whether to draw a horizontal line at `y = 0`.
#' @param bins Number of bins. When specified, overrides `method`.
#' @param method Binning method. Choose `"fd"` (the default), `"FD"`, `"Scott"`,
#'   `"Sturges"`, `"Rice"`, or `"sqrt"`. See Details. Ignored when `bins` is
#'   specified.
#' @param density Whether to map density to the y-axis.
#' @param facet <[`data-masked`][ggplot2::aes_eval]> Optional variable to facet
#'   the plot. `NULL` (the default) draws a single panel.
#' @param ... Additional arguments passed to [ggplot2::facet_wrap()].
#'
#' @details
#' ## Binning methods
#'
#' The `method` parameter controls how the function computes the bin width.
#'
#' \describe{
#'   \item{`"fd"` or `"FD"`}{Freedman-Diaconis rule. Uses the interquartile
#'     range: \eqn{2 * IQR / n^{1/3}}.}
#'   \item{`"Scott"`}{Scott's rule. The formula uses the standard deviation,
#'     \eqn{3 * sd / n^{1/3}}.}
#'   \item{`"Sturges"`}{Sturges' formula. Uses
#'     \eqn{k = \lceil log_2(n) \rceil} bins.}
#'   \item{`"Rice"`}{Rice rule. Uses
#'     \eqn{k = \lceil 2n^{1/3} \rceil} bins.}
#'   \item{`"sqrt"`}{Square-root rule. Uses
#'     \eqn{k = \lceil \sqrt{n} \rceil} bins.}
#' }
#'
#' @return A `ggplot` object.
#' @export
#' @encoding UTF-8
#' @importFrom ggplot2 ggplot aes geom_histogram facet_wrap after_stat vars
#' @importFrom rlang enquo
#' @importFrom cli cli_abort
#'
#' @examples
#' \dontshow{.op <- options(theme_benvi.font_family = "sans")}
#' # Default parameters use Freedman-Diaconis
#' plot_histogram(data = mtcars, x = mpg)
#' # Use bins to manually choose number of bins
#' plot_histogram(data = mtcars, x = mpg, bins = 10)
#' # Example of alternative methods: square root and Rice
#' plot_histogram(data = mtcars, x = mpg, method = "sqrt")
#' plot_histogram(data = mtcars, x = mpg, method = "Rice")
#'
#' # Facet by rooms category
#' spo <- subset(iqaiw, name_muni == "São Paulo" & rooms != "Total")
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
  facet = NULL,
  ...
) {
  histBinsMethods <- c("sqrt", "Sturges", "Rice", "Scott", "FD", "fd")

  facet_quo <- rlang::enquo(facet)
  # FALSE was the former default and is still honoured as "no faceting"
  has_facet <- !rlang::quo_is_null(facet_quo) &&
    !identical(rlang::quo_get_expr(facet_quo), FALSE)

  fill_quo <- rlang::enquo(fill)
  fill_type <- detect_aesthetic_type(fill_quo, "fill", data)
  static_fill <- if (fill_type$type == "static_color") {
    fill_type$value
  } else {
    "#021841"
  }

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
  base_args <- c(
    list(data = data, mapping = hist_mapping, color = color),
    bw_args
  )
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

  if (has_facet) {
    p <- p + facet_wrap(vars(!!facet_quo), ...)
  }

  p <- p + theme_benvi()

  return(p)
}


#' Get width of histogram interval
#'
#' @param x A numeric vector
#' @param type Type of formula used
#'
#' @return An integer
#' @importFrom stats IQR sd
#' @noRd
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
