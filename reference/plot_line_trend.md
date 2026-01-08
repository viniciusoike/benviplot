# Plot the original series plus a trend-line with emphasis on the trendline (Deprecated)

**\[deprecated\]**

`plot_line_trend()` has been deprecated due to its inflexible data
format requirements. Use standard ggplot2 with
[`geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)
or manual trend calculations instead.

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

## Details

### Migration Guide

The functionality can be easily replicated with standard ggplot2:

    # Instead of plot_line_trend():
    library(ggplot2)

    # Automatic smooth trend:
    ggplot(df, aes(x = date, y = value)) +
      geom_line(alpha = 0.5, color = benvi_palette("blues")[3]) +
      geom_smooth(method = "loess", se = FALSE, linewidth = 1,
                  color = benvi_palette("blues")[4]) +
      theme_benvi()

    # Or with manual trend data:
    ggplot() +
      geom_line(data = original, aes(x = date, y = value),
                alpha = 0.5, color = benvi_palette("blues")[3]) +
      geom_line(data = trend, aes(x = date, y = value),
                linewidth = 1, color = benvi_palette("blues")[4]) +
      theme_benvi()
