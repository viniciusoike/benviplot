# benviplot 1.2.1

## Breaking Changes

- Removed the unimplemented `text`, `text_color`, `text_family`, `text_size`, and
  `position_text` arguments from `plot_area()`. They were accepted and ignored.

## Bug Fixes

- Registered the `print()` method for palette objects. `benvi_palette("greens")`
  printed hex codes and attributes at the console; it now draws the color swatches.
- `plot_histogram()` no longer facets when `facet` is left at its default.
  Passing the documented default explicitly built a panel for the literal `FALSE`.

## Documentation

- Installation instructions point at R-universe. The README offered a CRAN install
  for a package that is not on CRAN.

---

# benviplot 1.2.0

## Breaking Changes

- Removed functions deprecated since v1.1.x: `plot_line_trend()`, `plot_column_label()`,
  `pretty_number()`, `setup_benvi_fonts()`, and `get_poppins_variants()`.
- Removed utility functions `benvi_colors()`, `list_colors()`, and `list_palettes()`.
  Use `show_palettes()` for palette exploration.
- Removed `install_poppins()` and `check_poppins_installed()`. Poppins is now bundled
  with the package and registered automatically on load, so no manual setup is needed.
  Use `font_status()` to check availability.
- Reduced hard dependencies: `ggfittext` and `systemfonts` moved to Suggests; `forcats`,
  `lifecycle`, and `scales` removed from Imports.

## New Features

- `show_palettes()` gains a `"diverging"` type and pattern-based name filtering.
- Scale functions now have a sensible default palette.

## Bug Fixes

- `format_num_br()` no longer returns scientific notation for large values.
  `format_num_br(1e5)` returned `"1e+05"` and now returns `"100.000"`.
- `format_num_br()` no longer left-pads results with spaces when given a vector.
  `format_num_br(c(100, 1000))` returned `c("  100", "1.000")` and now returns
  `c("100", "1.000")`.

## Documentation

- Reduced to a single vignette (`getting-started`); removed color-palettes, plot-functions,
  themes-and-styling, and font-setup vignettes.
- Updated README with simplified examples.

---

# benviplot 1.1.2

## Breaking Changes

- Renamed `pretty_number()` to `format_num_br()`. The old name is soft-deprecated and
  will be removed in a future release.

## New Features

- `plot_column()` gains three new parameters: `text_inside` (renders labels inside bars
  via ggfittext), `text_place`, and `text_padding`.
- `plot_column_label()` deprecated. Use `plot_column(text_inside = TRUE)` instead.
- `plot_line_trend()` deprecated. Use `geom_smooth()` or manual trend lines instead.

---

# benviplot 1.1.1

## New Features

- New dataset `sales_report`: zone-level median sale price per square meter for
  Belo Horizonte, Rio de Janeiro, and São Paulo (272 rows).
- `plot_scatter()` gains a `fit_color` parameter for custom trend line colors.
- `theme_benvi()` now uses relative font sizes and adds plot margins for better spacing.

## Data

- `iqa` updated: added `index` column; renamed columns for consistency.
- `iqaiw` updated: added `rooms` column.

---

# benviplot 1.1.0

Replaced the showtext-based font system with a systemfonts/ragg stack, eliminating
DPI mismatch issues in font rendering.

## Breaking Changes

- Removed `showtext` and `sysfonts` dependencies.
- Removed `import_fonts()`.
- Removed automatic showtext initialization on package load.

## New Features

- `font_status()`: report font setup status and recommendations.
- `ggsave_benvi()`: wrapper around `ggsave()` that uses the ragg device for PNG files
  when available; defaults to 300 DPI.
- `theme_benvi()` automatically falls back to "sans" if Poppins is not installed.

---

# benviplot 1.0.0 (2025-01-10)

First official stable release.

## Overview

- Added color palettes organized by type (theme, sequential, qualitative, city, brand).
- Added ggplot2 scale functions `scale_color_benvi_d()`, `scale_fill_benvi_d()`,
  `scale_color_benvi_c()`, and `scale_fill_benvi_c()`.
- Added plot helpers `plot_line()`, `plot_column()`, `plot_scatter()`, `plot_area()`,
  and `plot_histogram()`.
- Added the `theme_benvi()` theme with Poppins font support.
- Added the `iqa` and `iqaiw` datasets.

## Breaking Changes (from v0.9.x)

All palettes were renamed with descriptive names. Selected renames:

| Old            | New           |
|----------------|---------------|
| `Set0`         | `grays`       |
| `Seq3`         | `seq_greens`  |
| `Qual5`        | `qual_5`      |
| `index_blue`   | `benvi_blue`  |
| `Basic`        | `basic`       |

---

# benviplot 0.9.x (pre-release, October 2025)

- **0.9.6**: Breaking palette renaming (`Set0-7`, `Seq0-7`, `Qual1-9` replaced with
  descriptive names). Added `benvi_colors()`, `list_palettes()`, `show_palettes()`.
- **0.9.5**: pkgdown website and GitHub Actions CI/CD pipelines.
- **0.9.4**: Added `iqaiw` dataset.
- **0.9.3**: Added four vignettes (getting-started, color-palettes, plot-functions,
  themes-and-styling).
- **0.9.2**: Added test suite (196 tests).
- **0.9.1**: Modernized error handling with cli; renamed `pal` parameter to `palette`
  in all plot functions.
- **0.9.0**: Removed `iqa_region` dataset; added legal disclaimers; updated dependencies.

---

# benviplot 0.4.0 (2023-06-22)

- Updated index color palettes.
- Improved README and documentation.

---

# benviplot 0.3.0 (2023-02-01)

- Added `ggfittext` integration for text fitting in plots.

---

# benviplot 0.2.0 (2023-01-16)

- Added automatic Google Fonts download on package load.
- Added `import_fonts()` for manual font management.

---

# benviplot 0.1.0 (2023-01-12)

Initial release with core color palette system, ggplot2 scales, plot helpers, and
`theme_benvi()`.
