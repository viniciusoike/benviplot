# Discrete scales to use for ggplot2

Functions to use `ggplot2` scales with Benvi colors.

## Usage

``` r
scale_colour_benvi_d(pal_name = "qual_benvi", direction = 1, ...)

scale_color_benvi_d(pal_name = "qual_benvi", direction = 1, ...)

scale_fill_benvi_d(pal_name = "qual_benvi", direction = 1, ...)
```

## Arguments

- pal_name:

  Name of the palette.

- direction:

  Either `1` or `-1`. If `-1` the palette will be reversed.

- ...:

  additional arguments to pass to discrete_scale

## Examples

``` r
if (FALSE) { # \dontrun{
if (require('ggplot2')) {
  # Discrete color scale with rental index data
  iqaiw_total <- subset(iqaiw, rooms == "Total")
  ggplot(iqaiw_total, aes(x = date, y = index, colour = name_muni)) +
    geom_line() +
    scale_color_benvi_d("qual_benvi")
}
} # }
```
