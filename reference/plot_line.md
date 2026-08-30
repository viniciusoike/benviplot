# Plot a line chart

Plot a line chart

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

  A data frame.

- x:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable mapped to the x-axis.

- y:

  \<[`data-masked`](https://ggplot2.tidyverse.org/reference/aes_eval.html)\>
  Variable mapped to the y-axis.

- color:

  Color of the line. Either a color string (e.g., `"blue"`, `"#021841"`)
  for a single static color, or a bare column name (without quotes) to
  map a grouping variable to color.

- zero:

  Whether to draw a horizontal line at `y = 0`.

- point:

  Whether to draw points over the line.

- pal_name:

  Name of the color palette.

- scale_name:

  Color legend title.

- scale_label:

  Color legend labels.

- ...:

  Additional arguments passed to
  [`ggplot2::labs()`](https://ggplot2.tidyverse.org/reference/labs.html).

## Value

A `ggplot` object.

## Examples

``` r
# Single series
sao_paulo <- subset(iqa, name_muni == "S\u00e3o Paulo")
plot_line(data = sao_paulo, x = date, y = index)


# Multiple series with color mapping
total <- subset(iqaiw, rooms == "Total")
plot_line(data = total, x = date, y = index, color = name_muni)
```
