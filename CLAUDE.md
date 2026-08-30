# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

# How to perform tasks

When asked to perform tasks related to this repository, please follow
these guidelines:

- Make step-by-step detailed plans before writing code.
- Go through each task methodically, don’t skip steps, don’t cut
  corners.
- When writing code, remember to check claude/coding_guidelines.md for
  best practices.
- When writing code, remember to consider all other necessary changes:
  function documentation, examples, tests, vignettes, README, etc.
- After making changes, run devtools::check() to ensure everything
  works. If there are errors, fix them. If everything is OK, commit and
  push to GitHub.

## Overview

`benviplot` is an R package that provides ggplot2 extensions with
standardized color palettes and plotting functions for Benvi
(QuintoAndar Group). It includes custom color palettes, themes, and
helper plot functions.

## Development Commands

### Package Development

``` r

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

``` r

# Render README
rmarkdown::render("README.Rmd")
```

## Architecture

### Color System

The package uses a centralized color palette system stored in
`inst/extdata/`: - `benvi_colors.rds`: Named color definitions (e.g.,
“AzulQuinto”, “Floresta”, “Violeta”) - `benvi_palette.rds`: Pre-built
palette collections

**Palette Generation** (`data-raw/cols_to_palette.R`): - Converts named
colors to hex values via `get_colors()` and `get_hex()` functions -
Creates palette sets organized by type: - **Theme palettes** (4 colors):
grays, browns, yellows, greens, blues, purples, pinks, oranges -
**Qualitative palettes** (8 colors): qual_1, qual_2, qual_3, qual_4,
qual_5, qual_6, qual_7, qual_8, qual_9 - **Sequential palettes** (9
colors): seq_grays, seq_browns, seq_yellows, seq_greens, seq_blues,
seq_purples, seq_pinks, seq_oranges - **City-specific palettes**:
spo_seq, spo_div, spo_qual, rio_seq, rio_div, rio_qual, bhe_seq,
bhe_div - **Brand palettes**: benvi_blue, benvi_purple, basic

### Core Functions

**R/benvi_palette.R**: - `benvi_palette(pal_name, n, direction, type)`:
Main palette accessor - Returns hex colors from named palettes -
Supports discrete (exact colors) and continuous (interpolated) modes -
Can reverse palettes with `direction = -1` - `pal_pal()`: Factory
function for creating palette generators - `print.palette()`: S3 method
for visualizing palettes

**R/palette_utils.R**: - `benvi_colors(color_names)`: Get hex codes for
individual named colors or list all color names - `list_palettes(type)`:
List available palette names, filterable by type (“all”, “theme”,
“sequential”, “qualitative”, “city”, “brand”) -
[`list_colors()`](https://viniciusoike.github.io/benviplot/reference/list_colors.md):
List all 36 available Benvi color names - `show_palettes(type, n)`:
Visual display of all palettes (like RColorBrewer::display.brewer.all())

**R/benvi_scales.R**: - Discrete scales:
[`scale_color_benvi_d()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md),
[`scale_fill_benvi_d()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md) -
Continuous scales:
[`scale_color_benvi_c()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-continuous.md),
[`scale_fill_benvi_c()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-continuous.md) -
Both use British/American spelling variants (color/colour)

**R/theme_benvi.R**: -
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md):
Custom ggplot2 theme with Poppins font - White background, minimal grid
lines, legend on top - Uses `showtext` package for custom font rendering

\*\*R/plot\_\*.R\*\*: - Wrapper functions:
[`plot_line()`](https://viniciusoike.github.io/benviplot/reference/plot_line.md),
[`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md),
[`plot_scatter()`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md),
[`plot_area()`](https://viniciusoike.github.io/benviplot/reference/plot_area.md),
[`plot_histogram()`](https://viniciusoike.github.io/benviplot/reference/plot_histogram.md) -
Each accepts a `variable` argument to map to color/fill aesthetics -
Some include helper features (e.g.,
[`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md)
has `text = TRUE` to show values)

### Font Management

The package depends on `showtext` and optionally `sysfonts` for the
Poppins font: - `R/fonts.R`: Contains `import_fonts()` function -
`R/showtext.R`: Auto-loads showtext on package load - Font must be
available via Google Fonts or installed locally

### Internal Data

- `R/data.R`: Documents exported dataset (`iqa`)
- `R/sysdata.rda`: Contains internal `palette` object used by
  [`benvi_palette()`](https://viniciusoike.github.io/benviplot/reference/benvi_palette.md)

## Key Design Patterns

1.  **Palette lookup**: All palettes reference the internal `palette`
    object (loaded from `sysdata.rda`)
2.  **Color interpolation**: Sequential palettes use
    [`colorRampPalette()`](https://rdrr.io/r/grDevices/colorRamp.html)
    to create 9-step gradients
3.  **ggplot2 integration**: Scale functions use `discrete_scale()` and
    `scale_*_gradientn()` with custom palette generators
4.  **Error handling**: Validates palette names, color counts, and
    direction parameters
