# Discrete Benvi color scales

Map discrete values to colors from a Benvi palette.

## Usage

``` r
scale_colour_benvi_d(pal_name = "qual_benvi", direction = 1, ...)

scale_color_benvi_d(pal_name = "qual_benvi", direction = 1, ...)

scale_fill_benvi_d(pal_name = "qual_benvi", direction = 1, ...)
```

## Arguments

- pal_name:

  Name of the palette. Defaults to `"qual_benvi"`.

- direction:

  Either `1` or `-1`. Use `-1` to reverse the palette.

- ...:

  Additional arguments passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

## Value

A discrete ggplot2 scale that can be added to a `ggplot` object.

## Examples

``` r
library(ggplot2)
# Discrete color scale with rental index data
iqaiw_total <- subset(iqaiw, rooms == "Total")
ggplot(iqaiw_total, aes(x = date, y = index, colour = name_muni)) +
  geom_line() +
  scale_color_benvi_d("qual_benvi")

```
