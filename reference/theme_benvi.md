# A base theme for Benvi plots

A ggplot2 base theme for Benvi styled plots with clean, professional
styling.

This theme uses the Poppins font if installed on your system. If Poppins
is not available, it falls back to the system's default sans-serif font.

To install Poppins, run
[`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md).

## Usage

``` r
theme_benvi()
```

## Value

A ggplot2 theme object

## See also

[`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md),
[`font_status()`](https://viniciusoike.github.io/benviplot/reference/font_status.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)

# Simple scatter plot with benvi theme
spo_sales <- subset(sales_report, name_muni == "São Paulo" & date == max(date))
ggplot(spo_sales, aes(price_m2_listing, price_m2_contract)) +
  geom_point() +
  labs(title = "Listing vs Contract Prices") +
  theme_benvi()
} # }
```
