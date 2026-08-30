# Continuous Benvi color scales

Map continuous values to colors interpolated from a Benvi palette.

## Usage

``` r
scale_colour_benvi_c(pal_name = "benvi_blue", direction = 1, ...)

scale_color_benvi_c(pal_name = "benvi_blue", direction = 1, ...)

scale_fill_benvi_c(pal_name = "benvi_blue", direction = 1, ...)
```

## Arguments

- pal_name:

  Name of the palette. Defaults to `"benvi_blue"`.

- direction:

  Either `1` or `-1`. Use `-1` to reverse the palette.

- ...:

  Additional arguments passed to
  [`ggplot2::scale_colour_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html)
  or
  [`ggplot2::scale_fill_gradientn()`](https://ggplot2.tidyverse.org/reference/scale_gradient.html).

## Value

A continuous ggplot2 scale that can be added to a `ggplot` object.

## Examples

``` r
library(ggplot2)

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point() +
  scale_color_benvi_c("benvi_blue")

```
