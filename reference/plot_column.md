# Plot a column chart

Plot a column chart

## Usage

``` r
plot_column(
  data,
  x,
  y,
  fill,
  variable,
  zero = TRUE,
  flip = FALSE,
  text = FALSE,
  text_inside = FALSE,
  text_place = NULL,
  text_padding = NULL,
  palette = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  digits = 0,
  percent = FALSE,
  text_color = "gray20",
  text_family = "Poppins",
  text_size = 3,
  position_col = "stack",
  position_text = position_col,
  ...
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

- text:

  Logical indicating if text labels should be plotted on column bars

- text_inside:

  Logical indicating if text labels should be placed inside bars (using
  ggfittext). When TRUE, text is auto-sized to fit inside bars. When
  FALSE (default), text appears above/beside bars at fixed size.

- text_place:

  Placement of inside text. One of "top", "bottom", "left", "right",
  "centre"/"center". Only used when text_inside = TRUE. Defaults to
  "centre" for vertical bars or "right" for flipped bars.

- text_padding:

  Padding around inside text as grid::unit(). Only used when text_inside
  = TRUE. Defaults to 1mm.

- palette:

  String indicating the name of which palette to use.

- scale_name:

  String indicating fill legend title.

- scale_label:

  String indicating fill legend labels.

- digits:

  Number of digits to show in text labels.

- percent:

  Logical indicating if a % should be appended to text labels

- text_color:

  Color of the text label. Default is `"gray20"`.

- text_family:

  Font of the text label. Default is `"Poppins"`.

- text_size:

  Size of the text label. Default is `3`.

- position_col:

  Argument passed on to `position` in `geom_col`.

- position_text:

  Argument passed on to `position` in `geom_text`.

- ...:

  Further arguments for `geom_text`

## Value

A ggplot2 plot

## Examples

``` r
if (FALSE) { # \dontrun{
# Basic column chart
df <- data.frame(cat = factor(c("A", "B", "C")), value = c(5, 7, 3))
plot_column(data = df, x = cat, y = value)

# With text labels above bars
plot_column(data = df, x = cat, y = value, text = TRUE)

# With text labels inside bars (auto-sized)
plot_column(data = df, x = cat, y = value, text = TRUE, text_inside = TRUE)
} # }
```
