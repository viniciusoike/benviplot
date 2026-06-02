# A theme for Benvi styled plots

A ggplot2 base theme for Benvi styled plots.

Poppins is bundled with the package and registered automatically on load
(requires the `systemfonts` package). When Poppins is registered, the
theme uses it by default. If `systemfonts` is not installed, the theme
falls back to the system's default sans-serif font. Override the default
by setting `options(theme_benvi.font_family = "sans")` or passing
`base_family` directly.

## Usage

``` r
theme_benvi(
  base_family = getOption("theme_benvi.font_family", default_font_family()),
  base_size = 10,
  background = FALSE
)
```

## Arguments

- base_family:

  Argument passed to
  [`ggplot2::theme_minimal()`](https://ggplot2.tidyverse.org/reference/ggtheme.html).
  Defaults to `"Poppins"` when the bundled font is registered, `"sans"`
  otherwise.

- base_size:

  Argument passed to
  [`ggplot2::theme_minimal()`](https://ggplot2.tidyverse.org/reference/ggtheme.html).
  Defaults to 10.

- background:

  Logical. Adds an offwhite (creme) background to the plot.

## Value

A ggplot2 theme object

## Examples

``` r
library(ggplot2)
# Single series for example
series <- subset(iqaiw, name_muni == "S\u00e3o Paulo" & rooms == "Total")

# Base theme
ggplot(series, aes(date, index)) +
  geom_line(color = benvi_palette("benvi_blue")[1], lwd = 1) +
  labs(x = NULL, y = "Index (base = 100)", title = "IQAIW") +
  theme_benvi()


# Optional offwhite (creme) background
ggplot(series, aes(date, index)) +
  geom_line(color = benvi_palette("benvi_blue")[1], lwd = 1) +
  labs(x = NULL, y = "Index (base = 100)", title = "IQAIW") +
  theme_benvi(background = TRUE)
```
