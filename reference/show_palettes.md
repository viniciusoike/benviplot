# Display all Benvi palettes

Visually displays all available Benvi palettes in a grid layout, similar
to
[`RColorBrewer::display.brewer.all()`](https://rdrr.io/pkg/RColorBrewer/man/ColorBrewer.html).
Optionally filter by palette type.

## Usage

``` r
show_palettes(type = "all", n = NULL)
```

## Arguments

- type:

  Character string specifying the palette type to display. One of:
  `"all"` (default), `"theme"`, `"sequential"`, `"qualitative"`,
  `"city"`, or `"brand"`. See
  [`list_palettes()`](https://viniciusoike.github.io/benviplot/reference/list_palettes.md)
  for details.

- n:

  Number of colors to display from each palette. If `NULL` (default),
  shows all colors in each palette.

## Value

Invisibly returns `NULL`. Called for its side effect of creating a plot.

## Examples

``` r
# Display all palettes
show_palettes()


# Display only theme palettes
show_palettes("theme")


# Display sequential palettes
show_palettes("sequential")
```
