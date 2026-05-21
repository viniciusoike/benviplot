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
#> [1] "#C5C9BA" "#816242" "#F2C037" "#009850" "#466795" "#9A75B4" "#EA4E58"
#> [8] "#C64729"
#> attr(,"class")
#> [1] "palette"
#> attr(,"pal_name")
#> [1] "qual_2"

# Specify palette name
benvi_palette("greens")
#> [1] "#245825" "#009850" "#A3C7A1" "#46777A"
#> attr(,"class")
#> [1] "palette"
#> attr(,"pal_name")
#> [1] "greens"
benvi_palette("greens", n = 20, type = "continuous")
#>  [1] "#245825" "#1E622B" "#186C32" "#127639" "#0D8040" "#078A46" "#01944D"
#>  [8] "#119C58" "#2AA465" "#44AB72" "#5EB37E" "#78BA8B" "#91C298" "#9EC29E"
#> [15] "#8FB698" "#80A992" "#729C8C" "#639086" "#548380" "#46777A"
#> attr(,"class")
#> [1] "palette"
#> attr(,"pal_name")
#> [1] "greens"
benvi_palette("greens", n = 2, type = "discrete")
#> [1] "#245825" "#009850"
#> attr(,"class")
#> [1] "palette"
#> attr(,"pal_name")
#> [1] "greens"
```
