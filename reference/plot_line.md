# Title

Title

## Usage

``` r
plot_line(
  data,
  x,
  y,
  color = NULL,
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

  Color of the line. Either a color string (e.g., `"blue"`, `"#021841"`)
  for a single static color, or a bare column name (without quotes) to
  map a grouping variable to color.

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
# Single series
sao_paulo <- subset(iqa, name_muni == "S\u00e3o Paulo")
plot_line(data = sao_paulo, x = date, y = index)


# Multiple series with color mapping
total <- subset(iqaiw, rooms == "Total")
plot_line(data = total, x = date, y = index, color = name_muni)
```
