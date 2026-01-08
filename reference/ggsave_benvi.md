# Save a ggplot with benviplot optimizations

A wrapper around
[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)
with smart defaults optimized for benviplot graphics. Automatically uses
the ragg graphics device for PNG output when available, ensuring
high-quality rendering with proper font support and no DPI issues.

**Key improvements over base ggsave():**

- Uses ragg device for PNG files when available (better quality, no font
  issues)

- Optimized default DPI (300) for publication-quality output

- Consistent rendering across different platforms

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

  DPI to use for raster graphics. Default is 300 for high quality.

- ...:

  Additional arguments passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Value

Invisibly returns the filename.

## See also

[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)

p <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  theme_benvi()

# Save with automatic ragg device (if installed)
ggsave_benvi("my_plot.png", p)

# Save with custom dimensions
ggsave_benvi("my_plot.png", p, width = 10, height = 6)

# Save as PDF (uses default PDF device)
ggsave_benvi("my_plot.pdf", p)
} # }
```
