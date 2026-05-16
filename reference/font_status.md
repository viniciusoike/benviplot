# Report benviplot font status

Reports whether Poppins is installed and whether the `ragg` graphics
device is available, with actionable recommendations for each.

## Usage

``` r
font_status()
```

## Value

Invisibly returns a list with `poppins_installed` and `ragg_available`.

## Examples

``` r
font_status()
#> 
#> ── benviplot Font Status ───────────────────────────────────────────────────────
#> ! Poppins font: not installed
#> ℹ Install with: `benviplot::install_poppins()`
#> ✔ ragg package: available
```
