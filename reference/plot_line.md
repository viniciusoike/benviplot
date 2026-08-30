# Title

Title

## Usage

``` r
plot_line(
  data,
  x,
  y,
  color,
  variable,
  zero = TRUE,
  point = FALSE,
  pal_name,
  scale_name = "",
  scale_label = ggplot2::waiver(),
  ...
)
```

## Arguments

- data:

  A data.frame type object.

- x:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be mapped on the x-axis.

- y:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be mapped on the y-axis.

- color:

  Indicates the color of the line. Should only be used in the absence of
  `variable`.

- variable:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Indicates the grouping variable for color groups.

- zero:

  Logical indicating if a horizontal line (y = 0) should be drawn on the
  plot.

- point:

  Logical indicating if points should be drawn on top of line.

- pal_name:

  String indicating which color palette to use.

- scale_name:

  String indicating color legend title.

- scale_label:

  String indicating color legend labels.

- ...:

  Other arguments to ggplot2 function.

## Value

A ggplot2 plot

## Examples

``` r
sales <- data.frame(time = 2000:2005, value = c(10, 5, 6, 8, 11, 4))
plot_line(data = sales, x = time, y = value)
```
