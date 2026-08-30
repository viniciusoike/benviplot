# Format a number as a label

This is a convenient wrapper to both the `format` and the `round` base
functions to convert a numeric vector into a character of labels for
tables or plots.

## Usage

``` r
pretty_number(x, digits = 1, percent = FALSE)
```

## Arguments

- x:

  A numeric vector

- digits:

  Number of decimal cases to include

- percent:

  Logical indicating if % should be pasted

## Value

A character vector

## Examples

``` r
x <- 1235134.123
pretty_number(x)
#> [1] "1.235.134"
pretty_number(x, digits = 3)
#> [1] "1.235.134"
pretty_number(x, digits = 1, percent = TRUE)
#> [1] "1.235.134%"
```
