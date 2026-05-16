# Install Poppins font from Google Fonts

Downloads and installs the Poppins font family from Google Fonts. This
is a one-time operation that makes the font available to all R sessions
and graphics devices.

Requires the `systemfonts` package and an internet connection. After
installation,
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
will automatically use Poppins.

## Usage

``` r
install_poppins()
```

## Value

Invisibly returns `TRUE` if installation succeeds, throws an error
otherwise.

## Examples

``` r
if (FALSE) { # \dontrun{
install_poppins()
} # }
```
