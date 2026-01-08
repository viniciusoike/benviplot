# Continuous scales to use for ggplot2

These functions provide the option to use Benvi colors inside continuous
palettes with the `ggplot2` package.

## Usage

``` r
scale_colour_benvi_c(pal_name = "benvi_blue", direction = 1, ...)

scale_color_benvi_c(pal_name = "benvi_blue", direction = 1, ...)

scale_fill_benvi_c(pal_name = "benvi_blue", direction = 1, ...)
```

## Arguments

- pal_name:

  Name of the palette. Defaults to "qual_2".

- direction:

  Either `1` or `-1`. If `-1` the palette will be reversed.

- ...:

  Arguments to pass on to
  [`ggplot2::scale_colour_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)
  or
  [`ggplot2::scale_fill_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)

## Value

A `ScaleContinuous` object that can be added to a `ggplot` object

## Examples

``` r
if (FALSE) { # \dontrun{
if (require('ggplot2')) {
  # Continuous color scale with sales data
  ggplot(sales_report, aes(x = price_m2_listing,
                           y = price_m2_contract,
                           colour = price_m2_listing)) +
    geom_point() +
    scale_colour_benvi_c("benvi_blue")
}
} # }
```
