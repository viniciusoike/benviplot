# Display all Benvi palettes

Draws the available Benvi palettes in a grid. The layout follows
[`RColorBrewer::display.brewer.all()`](https://rdrr.io/pkg/RColorBrewer/man/ColorBrewer.html).

## Usage

``` r
show_palettes(type = "all", n = NULL)
```

## Arguments

- type:

  Palette type to display. Choose `"all"` (the default), `"theme"`,
  `"sequential"`, `"qualitative"`, `"diverging"`, `"city"`, or
  `"brand"`.

- n:

  Number of colors to display from each palette. If `NULL` (default),
  displays every color in each palette.

## Value

`NULL`, invisibly. This function is called for its plotting side effect.

## Examples

``` r
# Display all palettes
show_palettes()


# Display only theme palettes
show_palettes("theme")


# Display sequential palettes
show_palettes("sequential")
```
