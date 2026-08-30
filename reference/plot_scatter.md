# Plot a scatter chart

Plot a scatter chart

## Usage

``` r
plot_scatter(
  data,
  x,
  y,
  color = NULL,
  fit = FALSE,
  fit_variable = FALSE,
  fit_method = "auto",
  fit_formula = NULL,
  fit_color = NULL,
  fit_ci = FALSE,
  zero = "none",
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  ...
)
```

## Arguments

- data:

  A data frame.

- x:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable mapped to the x-axis.

- y:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable mapped to the y-axis.

- color:

  Color of the points. Either a color string (e.g., `"blue"`,
  `"#021841"`) for a single static color, or a bare column name (without
  quotes) to map a grouping variable to color. Continuous numeric
  variables automatically use a continuous color scale.

- fit:

  Whether to draw a fitted line over the points.

- fit_variable:

  Whether to fit separate lines for groups mapped to `color`. Defaults
  to `FALSE`.

- fit_method:

  Smoothing method passed to
  [`ggplot2::geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html).
  Defaults to `"auto"`.

- fit_formula:

  Formula passed to
  [`ggplot2::geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html).

- fit_color:

  Color of the fitted regression line. Only applied when
  `fit_variable = FALSE`. When `NULL` (default), uses automatic color
  selection. When `fit_variable = TRUE`, the fit line colors are
  inherited from the grouping variable and this parameter is ignored.

- fit_ci:

  Whether to draw the confidence interval around fitted lines. Defaults
  to `FALSE`.

- zero:

  Axis lines to draw. Choose `"x"`, `"y"`, `"both"`, or `"none"` (the
  default).

- pal_name:

  Name of the palette.

- scale_name:

  Fill legend title.

- scale_label:

  Fill legend labels.

- ...:

  Additional arguments passed to
  [`ggplot2::geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A `ggplot` object.

## Examples

``` r
plot_scatter(data = mtcars, x = wt, y = mpg)


# With regression line
plot_scatter(data = mtcars, x = wt, y = mpg, fit = TRUE)
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```
