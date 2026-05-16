# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# How to perform tasks

When asked to perform tasks related to this repository, please follow these guidelines:

- Make step-by-step detailed plans before writing code.
- Go through each task methodically, don't skip steps, don't cut corners.
- When writing code, remember to check claude/coding_guidelines.md for best practices.
- When writing code, remember to consider all other necessary changes: function documentation, examples, tests, vignettes, README, etc.
- After making changes, run devtools::check() to ensure everything works. If there are errors, fix them. If everything is OK, commit and push to GitHub.

## Overview

`benviplot` is an R package that provides ggplot2 extensions with standardized color palettes and plotting functions. It uses color schemes from the discontinued Benvi brand (QuintoAndar Group, 2024). Current version: **1.2.0**.

## Writing documentation

This applies to vignettes, examples and tutorial-material. General guidelines:

- Avoid piping into ggplot or plot calls.
- Use `subset` when possible to avoid the need to call `dplyr`.
- Make examples as simple as possible. Leave complex use cases for vignettes.
- Always use datasets shipped with this package (`iqa`, `iqaiw`, `sales_report`) or default R datasets (`mtcars`, `iris`).
- Add comments to code but be terse and always comment above the code (never to the right).
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

**Palette Generation** (`data-raw/cols_to_palette.R`):
- Converts named colors to hex values via `get_colors()` and `get_hex()` functions
- Creates palette sets organized by type:
  - **Theme palettes** (4 colors): grays, browns, yellows, greens, blues, purples, pinks, oranges
  - **Qualitative palettes** (8 colors): qual_1 through qual_9
  - **Sequential palettes** (9 colors): seq_grays, seq_browns, seq_yellows, seq_greens, seq_blues, seq_purples, seq_pinks, seq_oranges
  - **City-specific palettes**: spo_seq, spo_div, spo_qual, rio_seq, rio_div, rio_qual, bhe_seq, bhe_div
  - **Brand palettes**: benvi_blue, benvi_purple, basic

### Core Functions

**R/benvi_palette.R**:
- `benvi_palette(pal_name, n, direction, type)`: Main palette accessor
  - Returns hex colors from named palettes
  - Supports discrete (exact colors) and continuous (interpolated) modes
  - Can reverse palettes with `direction = -1`
- `pal_pal()`: Internal factory function for creating palette generators
- `print.palette()`: S3 method for visualizing palettes

**R/palette_utils.R**:
- `benvi_colors(color_names)`: Get hex codes for individual named colors or list all color names
- `list_palettes(type)`: List available palette names, filterable by type ("all", "theme", "sequential", "qualitative", "city", "brand")
- `list_colors()`: List all 36 available Benvi color names
- `show_palettes(type, n)`: Visual display of all palettes (like RColorBrewer::display.brewer.all())

**R/benvi_scales.R**:
- Discrete scales: `scale_color_benvi_d()`, `scale_fill_benvi_d()`
- Continuous scales: `scale_color_benvi_c()`, `scale_fill_benvi_c()`
- Both use British/American spelling variants (color/colour)

**R/theme_benvi.R**:
- `get_benvi_font_family()`: Internal — checks if Poppins is installed, falls back to "sans"
- `theme_custom()`: Internal base theme
- `theme_benvi()`: Exported custom ggplot2 theme with Poppins font (falls back to sans)

**R/fonts-modern.R** (font management):
- `check_poppins_installed()`: Internal — checks if Poppins is available via `systemfonts` (returns `FALSE` if systemfonts not installed)
- `install_poppins()`: Downloads and installs Poppins from Google Fonts (requires `systemfonts` and internet)
- `font_status()`: Reports Poppins and ragg availability with recommendations

**R/save-plot.R**:
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

**R/plot_scatter.R** also exports:
- `plot_add_xy()`: Helper to add axis lines to a plot

### Internal Data

- `R/data.R`: Documents exported datasets (`iqa`, `iqaiw`, `sales_report`)
- `R/sysdata.rda`: Internal `palette` and `benvi_colors_data` objects used throughout

### Datasets

- `iqa`: QuintoAndar Rental Price Index (legacy, 96 rows, 6 columns)
- `iqaiw`: IQAIW rental index for 6 cities, multiple rooms categories (1,660 rows)
- `sales_report`: Zone-level rental data with listing vs contract prices (272 rows)

## Key Design Patterns

1. **Palette lookup**: All palettes reference the internal `palette` object (loaded from `sysdata.rda`)
2. **Color interpolation**: Sequential palettes use `colorRampPalette()` to create 9-step gradients
3. **ggplot2 integration**: Scale functions use `discrete_scale()` and `scale_*_gradientn()` with custom palette generators
4. **Font fallback**: `theme_benvi()` automatically falls back to "sans" if Poppins is not installed
5. **Error handling**: Validates palette names, color counts, and direction parameters via `cli::cli_abort()`

## Dependencies

**Imports** (hard): cli, dplyr (>= 1.1.0), ggplot2 (>= 4.0.0), graphics

**Suggests** (optional): curl, ggfittext, knitr, pkgdown, ragg, rmarkdown, systemfonts, testthat (>= 3.0.0)

Note: `ggfittext` is only needed for `plot_column(text_inside = TRUE)`. `systemfonts` is only needed for `install_poppins()` and `font_status()`.
