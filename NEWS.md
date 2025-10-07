# benviplot (development)

## benviplot 0.9.4 (2025-10-07)

### New Features

* Added `iqaiw` dataset: QuintoAndar ImovelWeb Rental Index for 6 Brazilian cities
  * Hedonic double imputed rental price index (2023 onwards)
  * Variables: date, city, index, monthly/annual changes, price per m²
  * Comprehensive documentation with methodology details
  * Data processing script with validation in `data-raw/iqaiw.R`

---

## benviplot 0.9.3 (2025-10-07) - Phase 4 Complete

### Documentation

* Added four comprehensive vignettes:
  * `getting-started`: Installation, setup, and basic usage
  * `color-palettes`: Complete palette gallery (36 palettes) with usage guide
  * `plot-functions`: Detailed documentation of all 7 plot helper functions
  * `themes-and-styling`: Theme customization and publication-ready plots
* All vignettes build successfully and pass R CMD check

---

## benviplot 0.9.2 (2025-10-05) - Phase 3 Complete

### Testing

* Added comprehensive test suite with 196 tests (100% passing):
  * `test-benvi_palette.R`: 14 tests for palette functionality
  * `test-benvi_scales.R`: 16 tests for ggplot2 scales
  * `test-plot_functions.R`: 31 tests for plot helpers
  * `test-theme.R`: 13 tests for theme functionality
  * `test-utils.R`: 22 tests for utility functions
* Verified ggplot2 4.0.0 compatibility across all functions

---

## benviplot 0.9.1 (2025-10-05) - Phase 2 Complete

### Breaking Changes

* Renamed parameter `pal` → `palette` in all plot functions for consistency

### Bug Fixes

* Fixed `plot_line_trend()`: Updated deprecated `size` → `linewidth` for ggplot2 4.0.0
* Fixed `plot_line_trend()`: Corrected return value assignment
* Fixed `plot_column_label()`: Corrected `guide_fill` → `fill_guide` typo
* Fixed `plot_column_label()`: Fixed label aesthetic for tidy evaluation
* Fixed `plot_area()`: Corrected `label` → `labels` in scale call
* Fixed `plot_column()`: Replaced `T` with `TRUE`

### Improvements

* Modernized error handling: Replaced `stop()` with informative `cli::cli_abort()` messages
* Enhanced `import_fonts()` with robust error handling and progress feedback
* Improved `pretty_number()` with input validation
* Refactored `plot_add_xy()` and `get_hist_bw()` to use `switch()` statements
* Added case-insensitive method matching in `get_hist_bw()`

### Documentation

* Added `<[data-masked][ggplot2::aes_eval]>` tags to all tidy eval parameters
* Updated RoxygenNote: 7.3.2 → 7.3.3
* Fixed global variable bindings (created `R/utils-globals.R`)

### Internal

* Removed unused `rlang` dependency
* Added development files to `.Rbuildignore`
* Fixed `.onLoad()` / `.onAttach()` pattern per R best practices
* Package passes R CMD check: 0 errors, 0 warnings, 0 notes ✓

---

## benviplot 0.9.0 (2025-10-05) - Phase 1 Complete

### Breaking Changes

* **REMOVED** `iqa_region` dataset (contained sensitive internal data)

### Legal & Compliance

* Added comprehensive `DISCLAIMER.md` clarifying independence from QuintoAndar
* Updated all documentation with legal disclaimers
* Added proper author information and license details

### Package Metadata

* Updated dependencies:
  * R >= 4.1.0 (was >= 2.10)
  * ggplot2 >= 4.0.0 (for S7 compatibility)
  * dplyr >= 1.1.0 (modern tidyverse)
  * Added: cli, scales
  * Added to Suggests: testthat (>= 3.0.0), knitr, rmarkdown
* Set up infrastructure for testing and vignettes

### Documentation

* Completely rewrote README with disclaimer, badges, and clear examples
* Added pkgdown website URL
* Created `.github/` folder structure for future CI/CD

---

## benviplot 0.4.0 (2023-06-22)

### Features

* Updated index color palettes
* Improved README with better examples
* Enhanced documentation

---

## benviplot 0.3.0 (2023-02-01)

### Features

* Added `ggfittext` integration for better text fitting in plots

---

## benviplot 0.2.0 (2023-01-16)

### Features

* Implemented automatic Google Fonts download on package load
* Added `import_fonts()` function for manual font management
* Updated palette handling to remove accents

---

## benviplot 0.1.0 (2023-01-12)

### Initial Release

* Core color palette system with 36 palettes:
  * 8 Set palettes (4 colors each)
  * 9 Qualitative palettes (8 colors each)
  * 8 Sequential palettes (9 colors each)
  * City-specific palettes (spo, rio, bhe)
  * Index color scales
* ggplot2 scale functions:
  * `scale_color_benvi_d()` / `scale_fill_benvi_d()` (discrete)
  * `scale_color_benvi_c()` / `scale_fill_benvi_c()` (continuous)
* Plot helper functions:
  * `plot_line()`, `plot_column()`, `plot_scatter()`
  * `plot_area()`, `plot_histogram()`
  * `plot_line_trend()`, `plot_column_label()`
* Custom theme: `theme_benvi()` with Poppins font
* Utility functions: `pretty_number()`, `import_fonts()`
* Sample data: `iqa` (QuintoAndar rent index)

---

## Roadmap to v1.0.0

### Still To Do

* **Phase 5**: pkgdown website
  * Create `_pkgdown.yml` configuration
  * Build and deploy documentation site
* **Phase 6**: GitHub Actions CI/CD
  * R CMD check workflow
  * Test coverage workflow
  * pkgdown deployment automation
* **Phase 7**: Final checks and release
  * Run comprehensive quality checks
  * Final documentation review
  * Official v1.0.0 release 🎉

### Project Information

* **Author**: Vinicius Oike (viniciusoike@gmail.com)
* **License**: MIT
* **Disclaimer**: This is an unofficial, independent project not affiliated with QuintoAndar
* **Repository**: https://github.com/viniciusoike/benviplot
