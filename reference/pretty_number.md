# Format a number as a label (Deprecated)

**\[deprecated\]**

`pretty_number()` has been renamed to
[`format_num_br()`](https://viniciusoike.github.io/benviplot/reference/format_num_br.md)
for clarity. The new name better reflects that this function uses
Brazilian number formatting conventions.

## Usage

``` r
pretty_number(x, digits = 1, percent = FALSE)
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

## Examples

``` r
# Use format_num_br() instead
x <- 1235134.123
format_num_br(x)
#> [1] "1.235.134"
```
