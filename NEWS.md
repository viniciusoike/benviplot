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

## Coming in Future Versions

See `claude/release_plan_v1.0.0.md` for planned improvements:

* Phase 2: Code modernization (native pipe |>, modern tidyverse patterns)
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
