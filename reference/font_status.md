# Get font installation status and recommendations

Reports the current font setup status, including whether Poppins is
installed, whether ragg is available, and provides actionable
recommendations.

## Usage

``` r
font_status()
```

## Value

Invisibly returns a list with status information. Prints a formatted
report to the console.

## Examples

``` r
font_status()
#> 
#> ── benviplot Font Status ───────────────────────────────────────────────────────
#> ! Poppins font: not installed
#> ℹ Install with: `benviplot::install_poppins()`
#> ✔ ragg package: available
#> 
#> ── Recommendations ──
#> 
#> → Run `setup_benvi_fonts()` for one-command setup
```
