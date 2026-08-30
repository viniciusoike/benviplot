# Save a ggplot with benviplot defaults

A wrapper around
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)
that uses the `ragg` graphics device for PNG output. Registered fonts
such as the bundled Poppins are only visible to systemfonts-aware
devices, so ragg is what lets
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
render its font in saved files.

If `ragg` is not installed, the function uses the default graphics
device.

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
  graphics device (for example, `".png"`, `".pdf"`, or `".svg"`).

- plot:

  Plot to save. Defaults to the last plot displayed.

- device:

  Graphics device. Uses
  [`ragg::agg_png()`](https://ragg.r-lib.org/reference/agg_png.html) for
  PNG files when `ragg` is installed. Otherwise, uses ggplot2's default
  device.

- width, height:

  Plot size. Defaults to 7 by 5 inches.

- units:

  Units for width and height. Choose `"in"`, `"cm"`, `"mm"`, or `"px"`.
  Defaults to `"in"`.

- dpi:

  DPI to use for raster graphics. Defaults to 300.

- ...:

  Additional arguments passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Value

`filename`, invisibly.

## See also

[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)

## Examples

``` r
p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) + ggplot2::geom_point()
ggsave_benvi(tempfile(fileext = ".png"), plot = p)
#> ✔ Using ragg device for high-quality PNG output
```
