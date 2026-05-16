# Changelog

## benviplot 1.1.0 - Modern Font Rendering

**Major update: Eliminated DPI issues with modern font system** 🎉

This release replaces the old showtext-based font system with a modern
systemfonts/ragg stack, **completely eliminating the notorious DPI
mismatch issues** that plagued font rendering in v1.0.0.

### Why This Matters

The old system (v1.0.0) had frustrating DPI problems: - Text rendered at
different sizes in RStudio vs saved plots - Users had to constantly
adjust `showtext_opts(dpi = ...)` settings - Output varied unpredictably
across different devices - No reliable solution

**The new system fixes all of this!** You now get consistent,
high-quality text rendering across all outputs.

### BREAKING CHANGES

#### Font System Migration

❌ **Removed**: - `showtext` and `sysfonts` dependencies (completely
removed) - `import_fonts()` function (replaced with
[`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md)) -
Automatic showtext initialization on package load

✅ **Added**: - `systemfonts` dependency for modern font management -
`ragg` in Suggests for optimal graphics quality

#### New Font Management Functions

- [`install_poppins()`](https://viniciusoike.github.io/benviplot/reference/install_poppins.md) -
  Download and install Poppins system-wide (one-time setup)
- `setup_benvi_fonts()` - Complete one-command setup (installs font +
  provides config guidance)
- [`check_poppins_installed()`](https://viniciusoike.github.io/benviplot/reference/check_poppins_installed.md) -
  Check if Poppins is available
- [`font_status()`](https://viniciusoike.github.io/benviplot/reference/font_status.md) -
  Get detailed font setup status and recommendations
- `get_poppins_variants()` - List available Poppins font weights

#### Automatic Fallback

[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
now automatically falls back to system “sans” font if Poppins isn’t
installed. You’ll see a one-time message suggesting installation, but
all functionality works without Poppins.

### New Features

#### ggsave_benvi()

New wrapper around
[`ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html) with
smart defaults: - Automatically uses ragg device for PNG files (if ragg
is installed) - Default DPI of 300 for high quality - Consistent
rendering across platforms - Falls back gracefully if ragg not available

``` r

# Recommended way to save plots
ggsave_benvi("my_plot.png", plot, width = 8, height = 6)
```

#### Enhanced Documentation

- **New vignette**: `vignette("font-setup")` - Comprehensive font
  installation and troubleshooting guide
- Updated all existing vignettes for the new font system
- Updated README with modern font installation instructions

### Migration from v1.0.0

#### Quick Migration

**Old workflow (v1.0.0):**

``` r

library(benviplot)
library(showtext)
showtext_auto()
# Still had DPI issues...
```

**New workflow (v1.1.0):**

``` r

# One-time setup (once per computer)
benviplot::setup_benvi_fonts()

# Then just use the package
library(benviplot)
# Plots just work - no DPI issues!
```

#### Detailed Steps

1.  **Remove old showtext code** from your scripts:

    ``` r

    # DELETE these lines:
    library(showtext)
    showtext_auto()
    import_fonts()
    ```

2.  **Install Poppins system-wide** (one-time):

    ``` r

    library(benviplot)
    setup_benvi_fonts()  # Or: install_poppins()
    ```

3.  **Optionally install ragg** for best quality:

    ``` r

    install.packages("ragg")
    # Then configure RStudio: Tools > Global Options > General > Graphics > Backend: AGG
    ```

4.  **Update save code** (optional but recommended):

    ``` r

    # Old
    ggsave("plot.png", dpi = 300)

    # New (recommended)
    ggsave_benvi("plot.png")  # Smart defaults
    ```

That’s it! No more DPI headaches.

### Technical Details

#### Updated Dependencies

- **Added to Imports**: `systemfonts` (for modern font discovery and
  management)
- **Removed from Imports**: `showtext` (replaced with systemfonts)
- **Removed from Suggests**: `sysfonts` (no longer needed)
- **Added to Suggests**: `ragg` (optional, for best graphics quality)

#### Internal Changes

- [`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
  now uses
  [`systemfonts::system_fonts()`](https://systemfonts.r-lib.org/reference/system_fonts.html)
  for font detection
- Automatic fallback to “sans” if Poppins not available
- One-time informative messages when fonts aren’t installed
- Removed `.onLoad()` showtext initialization

#### Testing

- Updated all tests to use new font functions
- Removed showtext-specific tests
- Added tests for new font management functions
- Removed `tests/showtext_dpi_issue.R` (problem is solved!)
- All tests passing with modern font system

### Benefits

✅ **No DPI issues** - Text renders correctly at any resolution ✅
**Consistent output** - Same rendering in RStudio, ggsave(), R Markdown
✅ **Better quality** - Superior anti-aliasing with ragg ✅ **Simpler
workflow** - One-time font install, no per-session setup ✅ **Faster** -
Better performance than showtext ✅ **Modern stack** - Actively
maintained by Posit/RStudio team

### Installation

``` r

# Install from GitHub
remotes::install_github("viniciusoike/benviplot")
```

### Getting Help

- **Font setup guide**: `vignette("font-setup")`
- **Check font status**:
  [`font_status()`](https://viniciusoike.github.io/benviplot/reference/font_status.md)
- **Documentation**: <https://viniciusoike.github.io/benviplot/>
- **Issues**: <https://github.com/viniciusoike/benviplot/issues>

------------------------------------------------------------------------

## benviplot 1.0.0 (2025-01-10) - Official Stable Release

**First official stable release** 🎉

benviplot provides color palettes and ggplot2 extensions for creating
quality graphics with a professional, consistent visual style.

### Overview

This package offers: - **36 curated color palettes** organized by
purpose (theme, sequential, qualitative, city-specific, brand) -
**ggplot2 integration** with discrete and continuous scale functions -
**Plot helper functions** for common visualizations - **Custom theme**
with Poppins font support - **Comprehensive documentation** including 4
detailed vignettes and pkgdown website

### What’s New in 1.0.0

#### Major Changes from Pre-Release Versions

**Breaking Changes** (from v0.9.6): - All 36 palettes renamed with
intuitive, descriptive names - Old names like `Set0-7`, `Qual1-9`,
`Seq0-7` replaced with `grays`, `qual_1`, `seq_grays`, etc. - Brand
palettes: `index_blue` → `benvi_blue`, `index_prpl` → `benvi_purple`,
`Basic` → `basic`

**New Utility Functions**: - `benvi_colors()`: Get hex codes for
individual colors or list all color names - `list_palettes(type)`: List
available palettes filtered by type - `list_colors()`: List all color
names - `show_palettes(type, n)`: Visual display of palettes (like
RColorBrewer)

#### Quality & Infrastructure

- **Testing**: 250 tests with 100% pass rate, 72% code coverage
- **Documentation**:
  - 4 comprehensive vignettes (getting-started, color-palettes,
    plot-functions, themes-and-styling)
  - Professional pkgdown website at
    <https://viniciusoike.github.io/benviplot/>
  - All functions fully documented with examples
- **CI/CD**: GitHub Actions for automated testing, coverage tracking,
  and documentation deployment
- **Quality checks**:
  - R CMD check: 0 errors, 0 warnings, 0 notes ✓
  - Spelling check: Clean ✓
  - URL validation: All links verified ✓
  - Compatible with ggplot2 \>= 4.0.0

#### Installation

``` r

# Install from GitHub
remotes::install_github("viniciusoike/benviplot")
```

#### Quick Start

``` r

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

#### Migration from Pre-Release Versions

If upgrading from v0.9.5 or earlier, update palette names:

``` r
# OLD → NEW
benvi_palette("Set0") → benvi_palette("grays")
benvi_palette("Seq3") → benvi_palette("seq_greens")
benvi_palette("Qual5") → benvi_palette("qual_5")
benvi_palette("index_blue") → benvi_palette("benvi_blue")
benvi_palette("Basic") → benvi_palette("basic")
```

#### Legal

**DISCLAIMER**: This is an unofficial, independent project created by
Vinicius Oike and is NOT affiliated with, endorsed by, or connected to
QuintoAndar in any way. Benvi was a former brand of QuintoAndar that was
discontinued in 2024. This package uses publicly available color schemes
from that period for data visualization purposes.

------------------------------------------------------------------------

### benviplot 0.9.6 (2025-01-10) - Breaking Changes for v1.0

**Pre-release version with breaking palette renaming**

#### BREAKING CHANGES

- **Palette Renaming** - All 36 palettes renamed with intuitive,
  descriptive names:
  - Theme palettes: `Set0-7` →
    `grays, browns, yellows, greens, blues, purples, pinks, oranges`
  - Sequential palettes: `Seq0-7` →
    `seq_grays, seq_browns, seq_yellows, seq_greens, seq_blues, seq_purples, seq_pinks, seq_oranges`
  - Qualitative palettes: `Qual1-9` →
    `qual_1, qual_2, qual_3, qual_4, qual_5, qual_6, qual_7, qual_8, qual_9`
  - Brand palettes: `index_blue` → `benvi_blue`, `index_prpl` →
    `benvi_purple`
  - Basic palette: `Basic` → `basic`
  - **Migration guide**: Replace old palette names with new ones in your
    code

#### New Features

- Added utility functions for palette discovery and exploration:
  - `benvi_colors()`: Get hex codes for individual named colors or list
    all color names
  - `list_palettes(type)`: List available palette names (filterable by
    type: “theme”, “sequential”, “qualitative”, “city”, “brand”)
  - `list_colors()`: List all 36 available Benvi color names
  - `show_palettes(type, n)`: Visual display of all palettes (similar to
    RColorBrewer::display.brewer.all())

#### Bug Fixes

- Fixed `print.palette()` S3 method to remove white horizontal line in
  palette visualization
- Fixed internal naming conflict between `benvi_colors()` function and
  `benvi_colors` data object

#### Updated

- All plot function defaults updated to use new palette names
- All documentation and roxygen examples updated
- All 4 vignettes updated with new palette names throughout
- All 250 tests passing (added 54 new tests for utility functions)
- Updated palette data structures in `inst/extdata/` and `R/sysdata.rda`

#### Quality Assurance

- Package passes R CMD check: 0 errors ✔ \| 0 warnings ✔ \| 0 notes ✔
- All vignettes build successfully
- Test coverage maintained

------------------------------------------------------------------------

### benviplot 0.9.5 (2025-10-08) - Phases 5-6 Complete

**Pre-release version preparing for v1.0.0**

#### Infrastructure

- **Phase 5: pkgdown Website**
  - Created comprehensive documentation website at
    <https://viniciusoike.github.io/benviplot/>
  - Added `_pkgdown.yml` configuration with Bootstrap 5 theme and
    Poppins font
  - Organized function reference by category (Palettes, Scales, Plot
    Helpers, Themes, Utilities, Data)
  - All 4 vignettes accessible as articles
  - Custom navigation with home, reference, articles, news, and GitHub
    links
  - Search functionality enabled
- **Phase 6: GitHub Actions CI/CD**
  - Automated R CMD check on 5 platform/version combinations:
    - macOS (R release)
    - Windows (R release)
    - Ubuntu (R devel, release, oldrel-1)
  - Automated pkgdown deployment to GitHub Pages
  - Test coverage tracking with Codecov integration
  - All workflows use <r-lib/actions@v2> for R package CI/CD best
    practices

#### Documentation

- Added CI/CD status badges to README (R-CMD-check, Codecov, pkgdown)
- Repository made public for community access
- GitHub Pages enabled and deployed
- Fixed broken URL in color-palettes vignette

#### Quality Assurance

- Package passes R CMD check on all platforms: 0 errors, 0 warnings, 0
  notes ✓
- All 196 tests passing (100% success rate)
- Test coverage tracked and reported
- Documentation site building automatically on every commit

#### What’s New for Users

- Professional documentation website with searchable reference
- Comprehensive vignettes with examples
- Automated quality checks ensure reliability
- Package tested across multiple platforms and R versions

#### Next Steps

This is a pre-release version. After thorough manual review and testing,
version 1.0.0 will be the official stable release.

------------------------------------------------------------------------

### benviplot 0.9.4 (2025-10-07)

#### New Features

- Added `iqaiw` dataset: QuintoAndar ImovelWeb Rental Index for 6
  Brazilian cities
  - Hedonic double imputed rental price index (2023 onwards)
  - Variables: date, city, index, monthly/annual changes, price per m²
  - Comprehensive documentation with methodology details
  - Data processing script with validation in `data-raw/iqaiw.R`

------------------------------------------------------------------------

### benviplot 0.9.3 (2025-10-07) - Phase 4 Complete

#### Documentation

- Added four comprehensive vignettes:
  - `getting-started`: Installation, setup, and basic usage
  - `color-palettes`: Complete palette gallery (36 palettes) with usage
    guide
  - `plot-functions`: Detailed documentation of all 7 plot helper
    functions
  - `themes-and-styling`: Theme customization and publication-ready
    plots
- All vignettes build successfully and pass R CMD check

------------------------------------------------------------------------

### benviplot 0.9.2 (2025-10-05) - Phase 3 Complete

#### Testing

- Added comprehensive test suite with 196 tests (100% passing):
  - `test-benvi_palette.R`: 14 tests for palette functionality
  - `test-benvi_scales.R`: 16 tests for ggplot2 scales
  - `test-plot_functions.R`: 31 tests for plot helpers
  - `test-theme.R`: 13 tests for theme functionality
  - `test-utils.R`: 22 tests for utility functions
- Verified ggplot2 4.0.0 compatibility across all functions

------------------------------------------------------------------------

### benviplot 0.9.1 (2025-10-05) - Phase 2 Complete

#### Breaking Changes

- Renamed parameter `pal` → `palette` in all plot functions for
  consistency

#### Bug Fixes

- Fixed `plot_line_trend()`: Updated deprecated `size` → `linewidth` for
  ggplot2 4.0.0
- Fixed `plot_line_trend()`: Corrected return value assignment
- Fixed `plot_column_label()`: Corrected `guide_fill` → `fill_guide`
  typo
- Fixed `plot_column_label()`: Fixed label aesthetic for tidy evaluation
- Fixed
  [`plot_area()`](https://viniciusoike.github.io/benviplot/reference/plot_area.md):
  Corrected `label` → `labels` in scale call
- Fixed
  [`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md):
  Replaced `T` with `TRUE`

#### Improvements

- Modernized error handling: Replaced
  [`stop()`](https://rdrr.io/r/base/stop.html) with informative
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html)
  messages
- Enhanced `import_fonts()` with robust error handling and progress
  feedback
- Improved `pretty_number()` with input validation
- Refactored
  [`plot_add_xy()`](https://viniciusoike.github.io/benviplot/reference/plot_add_xy.md)
  and
  [`get_hist_bw()`](https://viniciusoike.github.io/benviplot/reference/get_hist_bw.md)
  to use [`switch()`](https://rdrr.io/r/base/switch.html) statements
- Added case-insensitive method matching in
  [`get_hist_bw()`](https://viniciusoike.github.io/benviplot/reference/get_hist_bw.md)

#### Documentation

- Added `<[data-masked][ggplot2::aes_eval]>` tags to all tidy eval
  parameters
- Updated RoxygenNote: 7.3.2 → 7.3.3
- Fixed global variable bindings (created `R/utils-globals.R`)

#### Internal

- Removed unused `rlang` dependency
- Added development files to `.Rbuildignore`
- Fixed `.onLoad()` / `.onAttach()` pattern per R best practices
- Package passes R CMD check: 0 errors, 0 warnings, 0 notes ✓

------------------------------------------------------------------------

### benviplot 0.9.0 (2025-10-05) - Phase 1 Complete

#### Breaking Changes

- **REMOVED** `iqa_region` dataset (contained sensitive internal data)

#### Legal & Compliance

- Added comprehensive `DISCLAIMER.md` clarifying independence from
  QuintoAndar
- Updated all documentation with legal disclaimers
- Added proper author information and license details

#### Package Metadata

- Updated dependencies:
  - R \>= 4.1.0 (was \>= 2.10)
  - ggplot2 \>= 4.0.0 (for S7 compatibility)
  - dplyr \>= 1.1.0 (modern tidyverse)
  - Added: cli, scales
  - Added to Suggests: testthat (\>= 3.0.0), knitr, rmarkdown
- Set up infrastructure for testing and vignettes

#### Documentation

- Completely rewrote README with disclaimer, badges, and clear examples
- Added pkgdown website URL
- Created `.github/` folder structure for future CI/CD

------------------------------------------------------------------------

### benviplot 0.4.0 (2023-06-22)

#### Features

- Updated index color palettes
- Improved README with better examples
- Enhanced documentation

------------------------------------------------------------------------

### benviplot 0.3.0 (2023-02-01)

#### Features

- Added `ggfittext` integration for better text fitting in plots

------------------------------------------------------------------------

### benviplot 0.2.0 (2023-01-16)

#### Features

- Implemented automatic Google Fonts download on package load
- Added `import_fonts()` function for manual font management
- Updated palette handling to remove accents

------------------------------------------------------------------------

### benviplot 0.1.0 (2023-01-12)

#### Initial Release

- Core color palette system with 36 palettes:
  - 8 Set palettes (4 colors each)
  - 9 Qualitative palettes (8 colors each)
  - 8 Sequential palettes (9 colors each)
  - City-specific palettes (spo, rio, bhe)
  - Index color scales
- ggplot2 scale functions:
  - [`scale_color_benvi_d()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md)
    /
    [`scale_fill_benvi_d()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md)
    (discrete)
  - [`scale_color_benvi_c()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-continuous.md)
    /
    [`scale_fill_benvi_c()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-continuous.md)
    (continuous)
- Plot helper functions:
  - [`plot_line()`](https://viniciusoike.github.io/benviplot/reference/plot_line.md),
    [`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md),
    [`plot_scatter()`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md)
  - [`plot_area()`](https://viniciusoike.github.io/benviplot/reference/plot_area.md),
    [`plot_histogram()`](https://viniciusoike.github.io/benviplot/reference/plot_histogram.md)
  - `plot_line_trend()`, `plot_column_label()`
- Custom theme:
  [`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
  with Poppins font
- Utility functions: `pretty_number()`, `import_fonts()`
- Sample data: `iqa` (QuintoAndar rent index)

------------------------------------------------------------------------

### Roadmap to v1.0.0

#### Still To Do

- **Phase 5**: pkgdown website
  - Create `_pkgdown.yml` configuration
  - Build and deploy documentation site
- **Phase 6**: GitHub Actions CI/CD
  - R CMD check workflow
  - Test coverage workflow
  - pkgdown deployment automation
- **Phase 7**: Final checks and release
  - Run comprehensive quality checks
  - Final documentation review
  - Official v1.0.0 release 🎉

#### Project Information

- **Author**: Vinicius Oike (<viniciusoike@gmail.com>)
- **License**: MIT
- **Disclaimer**: This is an unofficial, independent project not
  affiliated with QuintoAndar
- **Repository**: <https://github.com/viniciusoike/benviplot>
