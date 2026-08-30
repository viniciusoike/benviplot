# A base theme for Benvi plots

A ggplot2 base theme for Benvi styled plots with clean, professional
styling.

This theme uses the Poppins font if installed on your system. If Poppins
is not available, it falls back to the system's default sans-serif font.

To install Poppins, run
[`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md)
or
[`setup_benvi_fonts()`](https://viniciusoike.github.io/benviplot/reference/setup_benvi_fonts.md).

## Usage

``` r
theme_benvi()
```

## Value

A ggplot2 theme object

## See also

[`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md),
[`setup_benvi_fonts()`](https://viniciusoike.github.io/benviplot/reference/setup_benvi_fonts.md),
[`font_status()`](https://viniciusoike.github.io/benviplot/reference/font_status.md)

## Examples

``` r
library(ggplot2)

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  labs(title = "Car weight vs MPG") +
  theme_benvi()
```
