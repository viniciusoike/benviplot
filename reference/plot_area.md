# Plot an area chart

Plot an area chart

## Usage

``` r
plot_area(
  data,
  x,
  y,
  fill = NULL,
  zero = TRUE,
  order = TRUE,
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  position = "stack"
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

- fill:

  Fill color for the area. Either a color string (e.g., `"blue"`,
  `"#021841"`) for a single static color, or a bare column name (without
  quotes) to map a grouping variable to fill color.

- zero:

  Whether to draw a horizontal line at `y = 0`.

- order:

  Whether to order stacked areas by size. The default, `TRUE`, places
  the largest groups on top.

- pal_name:

  Name of the palette.

- scale_name:

  Fill legend title.

- scale_label:

  Fill legend labels.

- position:

  Position adjustment passed to
  [`ggplot2::geom_area()`](https://ggplot2.tidyverse.org/reference/geom_ribbon.html).

## Value

A `ggplot` object.

## Examples

``` r
# Simple area chart
sao_paulo <- subset(iqa, name_muni == "São Paulo")
plot_area(data = sao_paulo, x = date, y = index)


# Stacked area chart with fill mapping
total <- subset(iqaiw, rooms == "Total")
plot_area(data = total, x = date, y = index, fill = name_muni)
```
