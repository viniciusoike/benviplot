# benviplot 1.0.0 (2025-01-10) - Official Stable Release

**First official stable release** 🎉

benviplot provides color palettes and ggplot2 extensions for creating quality graphics with a professional, consistent visual style.

## Overview

This package offers:
- **36 curated color palettes** organized by purpose (theme, sequential, qualitative, city-specific, brand)
- **ggplot2 integration** with discrete and continuous scale functions
- **Plot helper functions** for common visualizations
- **Custom theme** with Poppins font support
- **Comprehensive documentation** including 4 detailed vignettes and pkgdown website

## What's New in 1.0.0

### Major Changes from Pre-Release Versions

**Breaking Changes** (from v0.9.6):
- All 36 palettes renamed with intuitive, descriptive names
- Old names like `Set0-7`, `Qual1-9`, `Seq0-7` replaced with `grays`, `qual_1`, `seq_grays`, etc.
- Brand palettes: `index_blue` → `benvi_blue`, `index_prpl` → `benvi_purple`, `Basic` → `basic`

**New Utility Functions**:
- `benvi_colors()`: Get hex codes for individual colors or list all color names
- `list_palettes(type)`: List available palettes filtered by type
- `list_colors()`: List all color names
- `show_palettes(type, n)`: Visual display of palettes (like RColorBrewer)

### Quality & Infrastructure

- **Testing**: 250 tests with 100% pass rate, 72% code coverage
- **Documentation**:
  - 4 comprehensive vignettes (getting-started, color-palettes, plot-functions, themes-and-styling)
  - Professional pkgdown website at https://viniciusoike.github.io/benviplot/
  - All functions fully documented with examples
- **CI/CD**: GitHub Actions for automated testing, coverage tracking, and documentation deployment
- **Quality checks**:
  - R CMD check: 0 errors, 0 warnings, 0 notes ✓
  - Spelling check: Clean ✓
  - URL validation: All links verified ✓
  - Compatible with ggplot2 >= 4.0.0

### Installation

```r
# Install from GitHub
remotes::install_github("viniciusoike/benviplot")
```

### Quick Start

```r
library(ggplot2)
library(benviplot)

# View a palette
benvi_palette("qual_2")

# Use in a plot
ggplot(mtcars, aes(x = wt, y = mpg, color = as.factor(cyl))) +
  geom_point() +
  scale_color_benvi_d(pal_name = "qual_2", name = "Cylinders") +
  theme_benvi()
```

### Migration from Pre-Release Versions

If upgrading from v0.9.5 or earlier, update palette names:

```r
# OLD → NEW
benvi_palette("Set0") → benvi_palette("grays")
benvi_palette("Seq3") → benvi_palette("seq_greens")
benvi_palette("Qual5") → benvi_palette("qual_5")
benvi_palette("index_blue") → benvi_palette("benvi_blue")
benvi_palette("Basic") → benvi_palette("basic")
```

### Legal

**DISCLAIMER**: This is an unofficial, independent project created by Vinicius Oike and is NOT affiliated with, endorsed by, or connected to QuintoAndar in any way. Benvi was a former brand of QuintoAndar that was discontinued in 2024. This package uses publicly available color schemes from that period for data visualization purposes.

---

## benviplot 0.9.6 (2025-01-10) - Breaking Changes for v1.0

**Pre-release version with breaking palette renaming**

### BREAKING CHANGES

* **Palette Renaming** - All 36 palettes renamed with intuitive, descriptive names:
  * Theme palettes: `Set0-7` → `grays, browns, yellows, greens, blues, purples, pinks, oranges`
  * Sequential palettes: `Seq0-7` → `seq_grays, seq_browns, seq_yellows, seq_greens, seq_blues, seq_purples, seq_pinks, seq_oranges`
  * Qualitative palettes: `Qual1-9` → `qual_1, qual_2, qual_3, qual_4, qual_5, qual_6, qual_7, qual_8, qual_9`
  * Brand palettes: `index_blue` → `benvi_blue`, `index_prpl` → `benvi_purple`
  * Basic palette: `Basic` → `basic`
  * **Migration guide**: Replace old palette names with new ones in your code

### New Features

* Added utility functions for palette discovery and exploration:
  * `benvi_colors()`: Get hex codes for individual named colors or list all color names
  * `list_palettes(type)`: List available palette names (filterable by type: "theme", "sequential", "qualitative", "city", "brand")
  * `list_colors()`: List all 36 available Benvi color names
  * `show_palettes(type, n)`: Visual display of all palettes (similar to RColorBrewer::display.brewer.all())

### Bug Fixes

* Fixed `print.palette()` S3 method to remove white horizontal line in palette visualization
* Fixed internal naming conflict between `benvi_colors()` function and `benvi_colors` data object

### Updated

* All plot function defaults updated to use new palette names
* All documentation and roxygen examples updated
* All 4 vignettes updated with new palette names throughout
* All 250 tests passing (added 54 new tests for utility functions)
* Updated palette data structures in `inst/extdata/` and `R/sysdata.rda`

### Quality Assurance

* Package passes R CMD check: 0 errors ✔ | 0 warnings ✔ | 0 notes ✔
* All vignettes build successfully
* Test coverage maintained

---

## benviplot 0.9.5 (2025-10-08) - Phases 5-6 Complete

**Pre-release version preparing for v1.0.0**

### Infrastructure

* **Phase 5: pkgdown Website**
  * Created comprehensive documentation website at https://viniciusoike.github.io/benviplot/
  * Added `_pkgdown.yml` configuration with Bootstrap 5 theme and Poppins font
  * Organized function reference by category (Palettes, Scales, Plot Helpers, Themes, Utilities, Data)
  * All 4 vignettes accessible as articles
  * Custom navigation with home, reference, articles, news, and GitHub links
  * Search functionality enabled

* **Phase 6: GitHub Actions CI/CD**
  * Automated R CMD check on 5 platform/version combinations:
    - macOS (R release)
    - Windows (R release)
    - Ubuntu (R devel, release, oldrel-1)
  * Automated pkgdown deployment to GitHub Pages
  * Test coverage tracking with Codecov integration
  * All workflows use r-lib/actions@v2 for R package CI/CD best practices

### Documentation

* Added CI/CD status badges to README (R-CMD-check, Codecov, pkgdown)
* Repository made public for community access
* GitHub Pages enabled and deployed
* Fixed broken URL in color-palettes vignette

### Quality Assurance

* Package passes R CMD check on all platforms: 0 errors, 0 warnings, 0 notes ✓
* All 196 tests passing (100% success rate)
* Test coverage tracked and reported
* Documentation site building automatically on every commit

### What's New for Users

* Professional documentation website with searchable reference
* Comprehensive vignettes with examples
* Automated quality checks ensure reliability
* Package tested across multiple platforms and R versions

### Next Steps

This is a pre-release version. After thorough manual review and testing,
version 1.0.0 will be the official stable release.

---

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
