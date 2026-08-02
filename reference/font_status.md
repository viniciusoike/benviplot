# Report benviplot font status

Reports whether Poppins is available and whether the `ragg` graphics
device is installed.

## Usage

``` r
font_status()
```

## Value

Invisibly returns a list with `poppins_available` and `ragg_available`.

## Examples

``` r
font_status()
#> 
#> ── benviplot Font Status ───────────────────────────────────────────────────────
#> ✔ Poppins font: registered (bundled)
#> ✔ ragg package: available
#> ✔ `theme_benvi()` will use Poppins automatically with ragg devices.
```
