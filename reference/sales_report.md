# QuintoAndar Sales Report - Zone-Level Rental Data

Rental price data at the zone (region) level for major Brazilian cities.
Contains both listing prices and actual contract prices, allowing
comparison between asking prices and transaction prices.

## Usage

``` r
sales_report
```

## Format

### sales_report

A data frame with 272 observations across multiple cities and zones:

- date:

  Date of the observation (first day of month)

- name_muni:

  Name of the municipality (city). Includes: Belo Horizonte, Rio de
  Janeiro, and São Paulo

- name_zone:

  Name of the zone within the city

- price_m2_listing:

  Median listing price per square meter (R\$/m²)

- price_m2_contract:

  Median contract price per square meter (R\$/m²)

## Source

Benvi (Sales Report 2023-Q3).

## Details

This dataset provides zone-level granularity, showing sales prices for
specific regions within cities. The difference between
`price_m2_listing` and `price_m2_contract` can indicate negotiation
patterns or market dynamics.

## Examples

``` r
if (FALSE) { # \dontrun{
# Compare listing vs contract prices
library(ggplot2)

spo_sales <- subset(sales_report, name_muni == "São Paulo" & date == max(date))

ggplot(spo_sales, aes(x = price_m2_listing, y = price_m2_contract)) +
  geom_point(color = benvi_palette("benvi_blue")[3], size = 2) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  labs(
    title = "Listing vs Contract Prices by Zone",
    subtitle = "São Paulo - Most Recent Month",
    x = "Listing Price (R$/m²)",
    y = "Contract Price (R$/m²)"
  ) +
  theme_benvi()
} # }
```
