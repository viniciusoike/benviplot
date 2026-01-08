# QuintoAndar Index (IQA) - Rental Price Index

Historical rental price index data from QuintoAndar. This is the legacy
IQA index, which has been superseded by the IQAIW (see
[`iqaiw`](https://viniciusoike.github.io/benviplot/reference/iqaiw.md)).

## Usage

``` r
iqa
```

## Format

### iqa

A data frame with 96 observations and 6 variables:

- date:

  Date of the observation (first day of month)

- name_muni:

  Name of the municipality (city)

- index:

  Rental price index, normalized to 100 at first observation

- chg:

  Monthly percent variation of the index (decimal form)

- acum12m:

  12-month accumulated variation of the index (decimal form)

- price_m2:

  Estimated rental price per square meter (R\$/m²)

## Source

Benvi
