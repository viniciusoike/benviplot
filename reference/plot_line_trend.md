# Plot the original series plus a trend-line with emphasis on the trendline

Plot the original series plus a trend-line with emphasis on the
trendline

## Usage

``` r
plot_line_trend(
  data,
  x = ts_date,
  y = value,
  name_series = "original",
  name_trend = "trend",
  color = benvi_palette("rio_qual", 1),
  zero = TRUE
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

- name_series:

  String indicating the name of the original series

- name_trend:

  String indicating the name of the trend series

- color:

  Indicates the color of the line. Should only be used in the absence of
  `variable`.

- zero:

  Logical indicating if a horizontal line (y = 0) should be drawn on the
  plot.

## Value

A ggplot2 plot
