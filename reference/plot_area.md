# Plot an area chart

Plot an area chart

## Usage

``` r
plot_area(
  data,
  x,
  y,
  fill,
  variable,
  zero = TRUE,
  order = TRUE,
  palette = "qual_9",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  text = FALSE,
  text_color = "gray20",
  text_family = "Poppins",
  text_size = 3,
  position = "stack",
  position_text = "identity"
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

  Color for the area underneath the line

- variable:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable to be used as grouping for the color groups. Should only be
  used if `fill` is missing.

- zero:

  Logical indicating whether a horizontal line crossing the y = 0 axis
  should be plotted.

- order:

  Logical indicating if the stacked areas should be ordered. Default
  behavior (`TRUE`) stacks the largest groups on top.

- palette:

  String indicating the name of which palette to use.

- scale_name:

  String indicating fill legend title.

- scale_label:

  String indicating fill legend labels.

- text:

  Logical indicating if text labels should be plotted above column bars

- text_color:

  Color of the text label. Default is `"gray20"`.

- text_family:

  Font of the text label. Default is `"Poppins"`.

- text_size:

  Size of the text label. Default is `3`.

- position:

  Argument passed to `geom_area`.

- position_text:

  Argument passed on to `position` in `geom_text`.

## Value

A ggplot2 plot
