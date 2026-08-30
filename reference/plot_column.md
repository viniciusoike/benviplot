# Plot a column chart

Plot a column chart

## Usage

``` r
plot_column(
  data,
  x,
  y,
  fill = NULL,
  zero = TRUE,
  text = FALSE,
  text_inside = FALSE,
  text_place = NULL,
  text_padding = NULL,
  pal_name = "qual_benvi",
  scale_name = "",
  scale_label = ggplot2::waiver(),
  digits = 0,
  percent = FALSE,
  text_color = "gray20",
  text_family = getOption("theme_benvi.font_family", "sans"),
  text_size = 3,
  position_col = "stack",
  position_text = position_col,
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

- fill:

  Fill color for the columns. Either a color string (e.g., `"blue"`,
  `"#021841"`) for a single static color, or a bare column name (without
  quotes) to map a grouping variable to fill color.

- zero:

  Whether to draw a horizontal line at `y = 0`.

- text:

  Whether to add value labels to the columns.

- text_inside:

  Whether to place labels inside the columns with `ggfittext`. When
  `FALSE` (the default), labels use a fixed size and appear above or
  beside the columns.

- text_place:

  Placement of labels inside the columns. Choose `"top"`, `"bottom"`,
  `"left"`, `"right"`, `"centre"`, or `"center"`. Defaults to `"centre"`
  and applies only when `text_inside = TRUE`.

- text_padding:

  Padding around inside labels, supplied as a
  [`grid::unit()`](https://rdrr.io/r/grid/unit.html) object. Defaults to
  1 mm and applies only when `text_inside = TRUE`.

- pal_name:

  Name of the palette.

- scale_name:

  Fill legend title.

- scale_label:

  Fill legend labels.

- digits:

  Number of digits to show in text labels.

- percent:

  Whether to append a percent sign to text labels.

- text_color:

  Color of the text label. Default is `"gray20"`.

- text_family:

  Font family for the text label. Defaults to
  `getOption("theme_benvi.font_family", "sans")`.

- text_size:

  Size of the text label. Default is `3`.

- position_col:

  Position adjustment passed to
  [`ggplot2::geom_col()`](https://ggplot2.tidyverse.org/reference/geom_bar.html).

- position_text:

  Position adjustment passed to
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html).

- ...:

  Additional arguments passed to
  [`ggplot2::geom_col()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)
  or
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html).

## Value

A `ggplot` object.

## Examples

``` r
# Column chart by city at the latest date
latest <- subset(iqa, date == max(iqa$date))
plot_column(data = latest, x = name_muni, y = index)


# With text labels above bars
plot_column(data = latest, x = name_muni, y = index, text = TRUE)


# With text labels inside bars
latest <- subset(iqa, date == max(iqa$date))
plot_column(data = latest, x = name_muni, y = index, text = TRUE, text_inside = TRUE)
```
