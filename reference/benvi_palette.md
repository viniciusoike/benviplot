# Get the colors of a Benvi palette

Returns the hex codes of a named Benvi palette. Use
[`show_palettes()`](https://viniciusoike.github.io/benviplot/reference/show_palettes.md)
to see the available palettes. The interface follows the
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

  Name of the palette. Defaults to `"qual_2"`.

- n:

  Number of colors to return. Defaults to the number of colors in the
  selected palette.

- direction:

  Either `1` or `-1`. Use `-1` to reverse the palette.

- type:

  Either `"discrete"` or `"continuous"`. Continuous palettes interpolate
  between the available colors.

## Value

A `palette` object containing hexadecimal color values.

## Examples

``` r
# Use default palette
benvi_palette()


# Specify palette name
benvi_palette("greens")

benvi_palette("greens", n = 20, type = "continuous")

benvi_palette("greens", n = 2, type = "discrete")
```
