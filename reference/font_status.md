# Report benviplot font status

Reports whether Poppins is available and whether the `ragg` graphics
device is installed.

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
#> ✔ Poppins font: registered (bundled)
#> ℹ Enable with: `options(theme_benvi.font_family = 'Poppins')`
#> ✔ ragg package: available
#> ✔ Your setup is optimal for benviplot!
```
