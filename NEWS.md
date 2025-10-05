# benviplot 1.0.0 (Development)

## Major Changes - Phase 1 Complete ✓

### Data Cleanup & Legal Compliance

* **BREAKING**: Removed `iqa_region` dataset (contained sensitive internal data)
* Added comprehensive DISCLAIMER.md clarifying package independence from QuintoAndar
* Updated all package metadata with proper author information
* Added legal notices throughout documentation

### Package Metadata

* Updated DESCRIPTION with complete author details (Vinicius Oike)
* Bumped version to 1.0.0 for initial public release
* Updated dependencies:
  - R >= 4.1.0 (was >= 2.10)
  - ggplot2 >= 4.0.0 (updated for compatibility with ggplot2 4.0.0 S7 migration)
  - dplyr >= 1.1.0 (modern tidyverse)
  - Added: cli, rlang >= 1.1.0
  - Added to Suggests: testthat >= 3.0.0, knitr, rmarkdown
* Updated RoxygenNote: 7.2.3 → 7.3.2

### Documentation

* Completely rewrote README with:
  - Prominent disclaimer at top
  - Professional badges
  - Clear installation instructions
  - Comprehensive feature overview
  - Updated examples
  - Author and license information
* Updated CLAUDE.md to remove iqa_region references
* Added pkgdown website URL: https://viniciusoike.github.io/benviplot/

### Infrastructure

* Created .github/ folder structure for future GitHub Actions
* Prepared for pkgdown website deployment
* Set up for testthat testing framework (Config/testthat/edition: 3)
* Added VignetteBuilder: knitr for future vignettes

## Existing Features (Carried Forward)

### Color Palettes

* 8 Set palettes (4 colors each): Set0-Set7
* 9 Qualitative palettes (8 colors each): Qual1-Qual9
* 8 Sequential palettes (9 colors each): Seq0-Seq7
* City-specific palettes: spo_*, rio_*, bhe_*
* Index color scales: index_blue, index_prpl

### ggplot2 Scales

* `scale_color_benvi_d()` / `scale_fill_benvi_d()` - Discrete scales
* `scale_color_benvi_c()` / `scale_fill_benvi_c()` - Continuous scales
* British/American spelling variants supported

### Plot Helper Functions

* `plot_line()` - Line charts
* `plot_column()` - Column/bar charts with optional text labels
* `plot_scatter()` - Scatter plots with optional regression lines
* `plot_area()` - Area charts
* `plot_histogram()` - Histograms
* `plot_line_trend()` - Line charts with trend indicators
* `plot_column_label()` - Specialized column charts with labels
* `plot_add_xy()` - Helper for adding axis lines

### Themes

* `theme_benvi()` - Custom ggplot2 theme with Poppins font

### Utilities

* `import_fonts()` - Download and setup Google Fonts
* `pretty_number()` - Format numbers for Brazilian locale

### Data

* `iqa` - QuintoAndar rent index sample data (public aggregate data)

## Major Changes - Phase 2 Complete ✓

### Critical Bug Fixes

* **Fixed** `plot_line_trend()`: Updated deprecated `size` → `linewidth` for ggplot2 4.0.0 compatibility
* **Fixed** `plot_line_trend()`: Corrected return value assignment bug
* **Fixed** `plot_column_label()`: Corrected `guide_fill` → `fill_guide` typo
* **Fixed** `plot_area()`: Corrected `label` → `labels` in scale call
* **Fixed** `plot_column()`: Replaced `T` with `TRUE` for proper logical constant

### Breaking Changes

* **BREAKING**: Renamed parameter `pal` → `palette` in all plot functions:
  - `plot_area()`
  - `plot_column()`
  - `plot_column_label()`
  - `plot_scatter()`
  - All other plotting functions now use consistent `palette` parameter

### Error Handling Modernization

* Replaced all `stop()` with informative `cli::cli_abort()` messages:
  - `benvi_palette()`: Direction validation, palette existence, color count limits
  - `scale_*_benvi_*()`: Package dependency checks (4 functions)
  - `plot_scatter()`: Zero parameter validation
  - `plot_histogram()`: Method parameter validation
* Added input validation to `pretty_number()`:
  - Type checking for x (numeric), digits (numeric), percent (logical)
  - Informative error messages for invalid inputs
* Enhanced `import_fonts()`:
  - Package availability checks
  - Network error handling with informative messages
  - Progress feedback with `cli::cli_alert_*()`
* Added robust error handling to `.onLoad()`:
  - Package availability checks
  - Graceful font loading failure handling

### Code Quality Improvements

* Refactored `plot_add_xy()` to use `switch()` instead of multiple if statements
* Refactored `get_hist_bw()`:
  - Replaced multiple if statements with `switch()`
  - Fixed assignment operators: `=` → `<-`
  - Case-insensitive method matching via `toupper()`

### Documentation

* Added `<[data-masked][ggplot2::aes_eval]>` tags to all tidy evaluation parameters:
  - `plot_column()`: x, y, variable
  - `plot_line()`: x, y, variable
  - `plot_histogram()`: x, facet
  - `plot_column_label()`: x, y, variable, label
  - Inherited by all functions using `@inheritParams`
* Updated RoxygenNote: 7.3.2 → 7.3.3
* Regenerated all .Rd documentation files

### R CMD Check Fixes

* **Fixed** `plot_column_label()`: Corrected label aesthetic handling for tidy evaluation
* **Fixed** Global variable bindings: Declared all data-masking variables in `R/utils-globals.R`
* **Fixed** `.onLoad()` / `.onAttach()` pattern: Moved user messages to `.onAttach()` per R best practices
* **Removed** unused `rlang` dependency from DESCRIPTION
* **Added** `.claude/`, `claude/`, `temp/`, `CLAUDE.md`, `DISCLAIMER.md` to `.Rbuildignore`
* **Verified**: Package passes `R CMD check` with 0 errors, 0 warnings, 0 notes ✓

## Coming in Future Versions

See `claude/release_plan_v1.0.0.md` for planned improvements:

* Phase 3: Testing infrastructure (comprehensive test suite)
* Phase 4: Vignettes (getting started, color palettes, plot functions, themes)
* Phase 5: pkgdown website
* Phase 6: GitHub Actions CI/CD
* Phase 7: Final quality checks and release

## Notes

* This is a complete repackaging and modernization of the original internal functions
* All code is original work by the package author
* Uses publicly available color schemes for visualization purposes
* Not affiliated with QuintoAndar in any way

---

*Phase 1 completed: October 5, 2025*
*Phase 2 completed: October 5, 2025*
