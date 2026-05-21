# Check if Poppins font is available

Checks whether the Poppins font family is available, either registered
from the bundled copies (via `.onLoad`) or installed system-wide.
Returns `FALSE` silently if the `systemfonts` package is not installed.

## Usage

``` r
check_poppins_installed()
```

## Value

Logical: `TRUE` if Poppins is available, `FALSE` otherwise.
