# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Overview

`benviplot` is an R package that provides ggplot2 extensions with standardized color palettes and plotting functions. It uses color schemes from the Benvi brand (QuintoAndar Group). Current version: **1.2.1**.

## Guidelines for writting
These apply when writting text for documentation like README.md or vignettes.

- Avoid ending sentences with a colon.
- Avoid emojis (e.g 🎯, 📊, etc.)

## Writing documentation

This applies to vignettes, examples and tutorial-material.

- Always use UTF-8 encoding in documentation and inside datasets. Avoid UTF-8 and convert only inside actual code.
- Avoid piping into ggplot or plot calls.
- When writing short examples, use `subset` when possible to avoid the need to call `dplyr`.
- Make examples as simple as possible. Leave complex use cases for vignettes.
- Add comments to code but be terse and always comment above the code (never to the right).
- Always use datasets shipped with this package (`iqa`, `iqaiw`, `sales_report`) or default R datasets (`mtcars`, `iris`).
- When writing long-form content like vignettes, reuse the same dataset several times. This makes it easier for the user to focus on the visualizations and not on data manipulation.

## Development Commands

### Package Development
```r
# Load package for development
devtools::load_all()

# Build and check package
devtools::check()

# Document functions (generates NAMESPACE and .Rd files)
devtools::document()

# Install package locally
devtools::install()

# Run tests
devtools::test()
```

### Building README
The README.md is generated from README.Rmd:
```r
rmarkdown::render("README.Rmd")
```

## Architecture

### Color System

The package uses a centralized color palette system stored in `inst/extdata/`:
- `benvi_colors.rds`: Named color definitions (e.g., "AzulQuinto", "Floresta", "Violeta")
- `benvi_palette.rds`: Pre-built palette collections

**`inst/fonts/`**: Poppins font (4 weights: Regular, Bold, Italic, BoldItalic) bundled with the package. Registered automatically on load when `systemfonts` is available. `theme_benvi()` defaults to `"Poppins"` when both `systemfonts` and `ragg` are available, `"sans"` otherwise. All runnable examples use `base_family = "sans"` or `\dontshow{options(theme_benvi.font_family = "sans")}` for CRAN compatibility. See `dev/font-management.md` for details on font management in R packages.

**Palette Generation** (`data-raw/cols_to_palette.R`):
- Converts named colors to hex values via `get_colors()` and `get_hex()` functions
- Creates palette sets organized by type:
  - **Theme palettes** (4 colors): grays, browns, yellows, greens, blues, purples, pinks, oranges
  - **Qualitative palettes** (8 colors): qual_1 through qual_9, plus qual_benvi (6 colors), the default for every scale and `plot_*()` helper
  - **Sequential palettes** (9 colors): seq_grays, seq_browns, seq_yellows, seq_greens, seq_blues, seq_purples, seq_pinks, seq_oranges
  - **Diverging palettes**: div_blue_muted, div_purple_muted
  - **City-specific palettes**: spo_seq, spo_div, spo_qual, rio_seq, rio_div, rio_qual, bhe_seq, bhe_div
  - **Brand palettes**: benvi_blue, benvi_purple, basic

`show_palettes()` groups `div_*` under `type = "diverging"`; the city `*_div` palettes stay under `type = "city"`.

### Core Functions

**R/benvi_palette.R**:
- `benvi_palette(pal_name, n, direction, type)`: Main palette accessor
  - Returns hex colors from named palettes
  - Supports discrete (exact colors) and continuous (interpolated) modes
  - Can reverse palettes with `direction = -1`
- `pal_pal()`: Internal factory function for creating palette generators
- `print.palette()`: S3 method for visualizing palettes

**R/palette_utils.R**:
- `show_palettes(type, n)`: Visual display of all palettes (like RColorBrewer::display.brewer.all()). `type` is one of `"all"`, `"theme"`, `"sequential"`, `"qualitative"`, `"diverging"`, `"city"`, `"brand"`.

**R/benvi_scales.R**:
- Discrete scales: `scale_color_benvi_d()`, `scale_fill_benvi_d()`
- Continuous scales: `scale_color_benvi_c()`, `scale_fill_benvi_c()`
- Both use British/American spelling variants (color/colour)

**R/theme_benvi.R**:
- `theme_benvi()`: Exported custom ggplot2 theme; uses Poppins when registered, falls back to `"sans"`. Override via `options(theme_benvi.font_family = ...)` or `base_family` argument.

**R/fonts.R** (font management):
- `font_status()`: Reports Poppins and ragg availability with recommendations

**R/zzz.R**:
- `.onLoad()`: Auto-registers the bundled Poppins font via `systemfonts::register_font()` when `systemfonts` is installed
- `register_bundled_poppins()`: Internal — resolves font paths from `inst/fonts/` and registers the font

**R/save_plot.R**:
- `ggsave_benvi()`: Wrapper around `ggplot2::ggsave()` that uses ragg device for PNG when available

**R/plot_*.R** — wrapper functions (active):
- `plot_line()`: Line chart
- `plot_column()`: Column/bar chart (includes text labels, inside text via ggfittext)
- `plot_scatter()`: Scatter plot with optional regression line
- `plot_area()`: Area chart
- `plot_histogram()`: Histogram

**R/utils.R**:
- `format_num_br()`: Format numbers with Brazilian locale (period thousands, comma decimal)

**R/utils-globals.R**: Global variable bindings for tidy eval (suppresses R CMD check notes)

**R/plot_scatter.R** also contains:
- `plot_add_xy()`: Internal — helper to add axis lines to a plot

### Internal Data

- `R/data.R`: Documents exported datasets (`iqa`, `iqaiw`, `sales_report`)
- `R/sysdata.rda`: Internal `palette` and `benvi_colors_data` objects used throughout

### Datasets

- `iqa`: QuintoAndar Rental Price Index (legacy, 96 rows, 6 columns)
- `iqaiw`: IQAIW rental index for 6 cities, multiple rooms categories (1,660 rows)
- `sales_report`: Zone-level median sale price per m² for 3 cities (272 rows)

## Key Design Patterns

1. **Palette lookup**: All palettes reference the internal `palette` object (loaded from `sysdata.rda`)
2. **Color interpolation**: Sequential palettes use `colorRampPalette()` to create 9-step gradients
3. **ggplot2 integration**: Scale functions use `discrete_scale()` and `scale_*_gradientn()` with custom palette generators
4. **Font activation**: Poppins is bundled and auto-registered on load (requires `systemfonts`). `theme_benvi()` uses Poppins by default when both `systemfonts` and `ragg` are available; falls back to `"sans"` otherwise. All examples force `"sans"` for CRAN compatibility since `R CMD check` uses base R devices that cannot render registered fonts
5. **Error handling**: Validates palette names, color counts, and direction parameters via `cli::cli_abort()`

## Dependencies

**Imports** (hard): cli, dplyr (>= 1.1.0), ggplot2 (>= 4.0.0), graphics, rlang

**Suggests** (optional): ggfittext, knitr, pkgdown, ragg, rmarkdown, systemfonts, testthat (>= 3.0.0)

Note: `ggfittext` is only needed for `plot_column(text_inside = TRUE)`. `systemfonts` is needed for auto-registering the bundled Poppins font on load; without it the theme defaults to "sans".
