# Install Poppins font system-wide from Google Fonts

Downloads and installs the Poppins font family from Google Fonts for
system-wide use. This is optional — `benviplot` already bundles Poppins
and registers it automatically on package load.

Requires an internet connection. After a system-wide installation, the
font is available outside of R as well.

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
