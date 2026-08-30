# Format numbers using Brazilian conventions

Formats numbers with a period as the thousands separator and a comma as
the decimal separator. The result is suitable for labels in tables and
plots.

## Usage

``` r
format_num_br(x, digits = 1, percent = FALSE)
```

## Arguments

- x:

  A numeric vector.

- digits:

  Number of decimal places to include. Can be negative to round to tens,
  hundreds, etc.

- percent:

  Whether to append a percent sign.

## Value

A character vector containing the formatted numbers.

## Details

Brazilian number formatting uses `.` as the thousands separator and `,`
as the decimal separator.

For example, `1234567.89` becomes `"1.234.567,9"` when `digits = 1`.

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
