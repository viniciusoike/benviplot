# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`benviplot` is an R package that provides ggplot2 extensions with standardized color palettes and plotting functions for Benvi (QuintoAndar Group). It includes custom color palettes, themes, and helper plot functions.

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
# Render README
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
  - **Sets (Set0-Set7)**: 4-color themed collections
  - **Quals (Qual1-Qual9)**: 8-color qualitative palettes for categorical data
  - **Sequential (Seq0-Seq7)**: 9-color gradients via interpolation
  - **City-specific**: spo_*, rio_*, bhe_* palettes
  - **Index colors**: index_blue, index_prpl

### Core Functions

**R/benvi_palette.R**:
- `benvi_palette(pal_name, n, direction, type)`: Main palette accessor
  - Returns hex colors from named palettes
  - Supports discrete (exact colors) and continuous (interpolated) modes
  - Can reverse palettes with `direction = -1`
- `pal_pal()`: Factory function for creating palette generators
- `print.palette()`: S3 method for visualizing palettes

**R/benvi_scales.R**:
- Discrete scales: `scale_color_benvi_d()`, `scale_fill_benvi_d()`
- Continuous scales: `scale_color_benvi_c()`, `scale_fill_benvi_c()`
- Both use British/American spelling variants (color/colour)

**R/theme_benvi.R**:
- `theme_benvi()`: Custom ggplot2 theme with Poppins font
- White background, minimal grid lines, legend on top
- Uses `showtext` package for custom font rendering

**R/plot_*.R**:
- Wrapper functions: `plot_line()`, `plot_column()`, `plot_scatter()`, `plot_area()`, `plot_histogram()`
- Each accepts a `variable` argument to map to color/fill aesthetics
- Some include helper features (e.g., `plot_column()` has `text = TRUE` to show values)

### Font Management

The package depends on `showtext` and optionally `sysfonts` for the Poppins font:
- `R/fonts.R`: Contains `import_fonts()` function
- `R/showtext.R`: Auto-loads showtext on package load
- Font must be available via Google Fonts or installed locally

### Internal Data

- `R/data.R`: Documents exported dataset (`iqa`)
- `R/sysdata.rda`: Contains internal `palette` object used by `benvi_palette()`

## Key Design Patterns

1. **Palette lookup**: All palettes reference the internal `palette` object (loaded from `sysdata.rda`)
2. **Color interpolation**: Sequential palettes use `colorRampPalette()` to create 9-step gradients
3. **ggplot2 integration**: Scale functions use `discrete_scale()` and `scale_*_gradientn()` with custom palette generators
4. **Error handling**: Validates palette names, color counts, and direction parameters
