# A color palette for Benvi.

Construction of the package is inspired by the
[ghibli](https://github.com/ewenme/ghibli) package.

## Usage

``` r
benvi_palette(
  pal_name = "qual_2",
  n,
  direction = 1,
  type = c("discrete", "continuous")
)
```

## Arguments

- pal_name:

  Name of the palette. Defaults to "qual_2".

- n:

  Number of colors desired. Sets have 4 colors, Qual have 8 colors.

- direction:

  Either `1` or `-1`. If `-1` the palette will be reversed.

- type:

  Either "continuous" or "discrete". Continuous automatically
  interpolates between the colors.

## Value

A vector of characters with color attribute

## Examples

``` r
# Use default palette
benvi_palette()


# Specify palette name
benvi_palette("greens")

benvi_palette("greens", n = 20, type = "continuous")

benvi_palette("greens", n = 2, type = "discrete")
```
