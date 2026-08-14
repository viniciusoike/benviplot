# Save a ggplot with benviplot optimizations

A wrapper around
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)
that uses the ragg graphics device for PNG output. Registered fonts such
as the bundled Poppins are only visible to systemfonts-aware devices, so
ragg is what lets
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
render its font in saved files.

If ragg is not installed, falls back to the default graphics device.

## Usage

``` r
ggsave_benvi(
  filename,
  plot = ggplot2::last_plot(),
  device = NULL,
  width = 7,
  height = 5,
  units = "in",
  dpi = 300,
  ...
)
```

## Arguments

- filename:

  File name to create on disk. The file extension determines the
  graphics device (e.g., ".png", ".pdf", ".svg").

- plot:

  Plot to save. Defaults to the last plot displayed.

- device:

  Device to use. Defaults to "ragg" for PNG files if ragg package is
  installed, otherwise uses ggplot2's default device selection.

- width, height:

  Plot size in units. Defaults to 7 x 5 inches.

- units:

  Units for width and height ("in", "cm", "mm", "px"). Default is "in".

- dpi:

  DPI to use for raster graphics. Defaults to 300.

- ...:

  Additional arguments passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Value

Invisibly returns the filename.

## See also

[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)

## Examples

``` r
p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) + ggplot2::geom_point()
ggsave_benvi(tempfile(fileext = ".png"), plot = p)
#> ✔ Using ragg device for high-quality PNG output
```
