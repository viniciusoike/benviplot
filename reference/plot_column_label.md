# Column plot with text labels (Deprecated)

**\[deprecated\]**

`plot_column_label()` has been deprecated in favor of enhanced
[`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md).
Use `plot_column(text = TRUE, text_inside = TRUE, flip = TRUE)` instead.

## Usage

``` r
plot_column_label(
  data,
  x,
  y,
  label,
  fill,
  variable,
  zero = TRUE,
  flip = TRUE,
  fill_guide = "none",
  palette = "qual_benvi",
  text_color = "white",
  text_family = "sans",
  text_size = 4,
  scale_name = "",
  scale_label = waiver()
)
```

## Arguments

- data:

  A data.frame type object

- x:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be mapped in the x-axis.

- y:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be mapped in the y-axis.

- label:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Text label to mapped onto the column. Defaults to y variable.

- fill:

  Color for the columns. Should only be used if `variable` is missing.

- variable:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be used as grouping for the color groups. Should only be
  used if `fill` is missing.

- zero:

  Logical indicating whether a horizontal line crossing the y = 0 axis
  should be plotted.

- flip:

  Logical indicating if plot should be flipped

- fill_guide:

  Optional indicating if fill guide should be suppressed.

- palette:

  String indicating the name of which palette to use.

- text_color:

  Color of the text label. Default is `"gray20"`.

- text_family:

  Font of the text label. Default is `"Poppins"`.

- text_size:

  Size of the text label. Default is `3`.

- scale_name:

  String indicating fill legend title.

- scale_label:

  String indicating fill legend labels.

## Value

A ggplot2 plot

## Details

### Migration Guide

The functionality of `plot_column_label()` is now available in
[`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md)
with the `text_inside` parameter:

    # Old (deprecated):
    plot_column_label(df, x = category, y = value, flip = TRUE)

    # New (recommended):
    plot_column(df, x = category, y = value,
                text = TRUE, text_inside = TRUE, flip = TRUE)

## Examples

``` r
if (FALSE) { # \dontrun{
# Use plot_column() instead
df <- data.frame(
  cat = c("A", "B", "C"),
  value = c(11257, 9874, 8991)
)
plot_column(df, x = cat, y = value, text = TRUE, text_inside = TRUE, flip = TRUE)
} # }
```
