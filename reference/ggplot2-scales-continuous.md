# Continuous scales to use for ggplot2

These functions provide the option to use Benvi colors inside continuous
palettes with the `ggplot2` package.

## Usage

``` r
scale_colour_benvi_c(pal_name, direction = 1, ...)

scale_color_benvi_c(pal_name, direction = 1, ...)

scale_fill_benvi_c(pal_name, direction = 1, ...)
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

if (require('ggplot2')) {

  ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Petal.Length)) +
    geom_point() +
    scale_colour_benvi_c("qual_9")
}
#> Loading required package: ggplot2

```
