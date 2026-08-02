# Format numbers using Brazilian conventions

Formats numbers using Brazilian locale conventions: period (.) as
thousands separator and comma (,) as decimal separator. This is a
convenient wrapper to both the `format` and `round` base functions to
convert numeric vectors into character labels for tables or plots.

## Usage

``` r
format_num_br(x, digits = 1, percent = FALSE)
```

## Arguments

- x:

  A numeric vector

- digits:

  Number of decimal places to include. Can be negative to round to tens,
  hundreds, etc.

- percent:

  Logical indicating if % symbol should be appended

## Value

A character vector with formatted numbers

## Details

Brazilian number formatting uses:

- Thousands separator: `.` (period)

- Decimal separator: `,` (comma)

For example, 1234567.89 becomes "1.234.567,9" (with digits = 1).

## Examples

``` r
# Basic formatting
x <- 1235134.123
format_num_br(x)
#> [1] "1.235.134"

# Different decimal places
format_num_br(x, digits = 3)
#> [1] "1.235.134"
format_num_br(x, digits = 0)
#> [1] "1.235.134"

# With percentage
format_num_br(12.5, digits = 1, percent = TRUE)
#> [1] "12,5%"

# Negative digits round to tens, hundreds, etc.
format_num_br(1234567, digits = -3)
#> [1] "1.235.000"

# Works with vectors
format_num_br(c(100, 1000, 10000))
#> [1] "100"    "1.000"  "10.000"
```
