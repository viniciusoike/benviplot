# Report benviplot font status

Reports whether Poppins, `systemfonts`, and the `ragg` graphics device
are available.

## Usage

``` r
font_status()
```

## Value

A list with `poppins_available` and `ragg_available`, invisibly.

## Examples

``` r
font_status()
#> 
#> ── benviplot Font Status ───────────────────────────────────────────────────────
#> ✔ Poppins font: registered (bundled)
#> ✔ ragg package: available
#> ✔ `theme_benvi()` will use Poppins automatically with ragg devices.
```
