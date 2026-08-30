# Plot a histogram chart

Plot a histogram chart

## Usage

``` r
plot_histogram(
  data,
  x,
  color = "#FFFFFF",
  fill = "#3957BD",
  zero = TRUE,
  bins = NULL,
  method = "fd",
  density = FALSE,
  facet = FALSE,
  ...
)
```

## Arguments

- data:

  A data.frame type object

- x:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Indicates the numeric variable to be mapped

- color:

  Color of the line of column.

- fill:

  Color of the inner part of the column.

- zero:

  Logical indicating if a horizontal (y = 0) line should be drawn on the
  plot.

- bins:

  Number of bins.

- method:

  Character indicating an algorithm to compute optimal number of bins.
  See details. Overridden by bins. Defaults to `method = "fd"`.

- density:

  Logical indicating if density should be plotted on y-axis.

- facet:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Optional variable to facet the graphics.

- ...:

  Additional parameters to
  [`facet_wrap()`](https://ggplot2.tidyverse.org/reference/facet_wrap.html)

## Value

A ggplot2 object

## Examples

``` r
set.seed(5)
tbl <- data.frame(x = rnorm(n = 1000))

# Default parameters use Freedman-Diaconis
plot_histogram(data = tbl, x = x)

# Use bins to manually choose number of bins
plot_histogram(data = tbl, x = x, bins = 50)

# Example of alternative methods: square root and Rice
plot_histogram(data = tbl, x = x, method = "sqrt")

plot_histogram(data = tbl, x = x, method = "Rice")


# To compare multiple groups use facet
tbl <- data.frame(
city = rep(c("A", "B", "C"), each.out = 500),
x = c(rnorm(500), runif(500), rexp(500))
)
plot_histogram(data = tbl, x = x, facet = city, density = TRUE)
```
