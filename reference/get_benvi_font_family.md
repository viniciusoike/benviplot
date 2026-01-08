# Get the font family to use for benviplot themes

Determines which font family to use based on system font availability.
Prefers Poppins if installed, otherwise falls back to "sans".

Shows a one-time message if Poppins is not installed, suggesting
installation.

## Usage

``` r
get_benvi_font_family()
```

## Value

Character string with font family name
