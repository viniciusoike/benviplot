# benviplot 1.0.0 Release Plan

**Target Release**: benviplot 1.0.0
**Author**: Vinicius Oike (viniciusoike@gmail.com)
**Status**: Phase 1 Complete ✓ | Phase 2 In Progress
**Last Updated**: October 5, 2025

---

## Project Disclaimer

**IMPORTANT**: This is an unofficial, independent project created by Vinicius Oike and is not affiliated with, endorsed by, or connected to QuintoAndar in any way.

Benvi was a former brand of QuintoAndar that was discontinued in 2024. This package uses publicly available color schemes from that period for data visualization purposes. All code in this repository is original work by the package author.

---

## Release Goals

1. **Remove sensitive internal data** before public release
2. **Modernize codebase** following current R best practices (2025)
3. **Ensure ggplot2 4.0.0 compatibility**
4. **Create comprehensive documentation** (vignettes + pkgdown website)
5. **Establish professional package infrastructure** for ongoing maintenance

---

## Phase 1: Data Cleanup & Legal Compliance ✅ COMPLETE

**Status**: ✅ Completed October 5, 2025

### 1.1 Remove Sensitive Data ✅
- [x] **Delete** `data/iqa_region.rda` (contains internal QuintoAndar regional data)
- [x] **Delete** `man/iqa_region.Rd` (documentation)
- [x] **Edit** `R/data.R`: Remove `iqa_region` documentation (lines 19-39)
- [x] **Decision**: Keep `data/iqa.rda` (verified as public aggregate data)
- [x] **Update** `CLAUDE.md`: Remove iqa_region mention

### 1.2 Add Legal Documentation ✅
- [x] **Create** `DISCLAIMER.md` in root directory with full disclaimer text
- [x] **Update** `README.md`: Add disclaimer section at the top
- [x] **Update** `DESCRIPTION`: Add disclaimer in Description field
- [x] **Verify** `LICENSE`: MIT license confirmed appropriate
- [x] **Create** `.github/` folder structure

### 1.3 Update Package Metadata ✅
- [x] **DESCRIPTION file**:
  ```r
  Package: benviplot
  Title: Color Palettes and ggplot2 Extensions for Data Visualization
  Version: 1.0.0
  Authors@R:
      person("Vinicius", "Oike",
             email = "viniciusoike@gmail.com",
             role = c("aut", "cre"),
             comment = c(ORCID = "XXXX-XXXX-XXXX-XXXX"))  # Add if available
  Description: Provides color palettes and ggplot2 extensions for creating
      quality graphics. This package uses color schemes from the discontinued
      Benvi brand (2024) for data visualization purposes. This is an
      unofficial, independent project not affiliated with QuintoAndar.
  License: MIT + file LICENSE
  URL: https://github.com/viniciusoike/benviplot, https://viniciusoike.github.io/benviplot/
  BugReports: https://github.com/viniciusoike/benviplot/issues
  Depends:
      R (>= 4.1.0)
  Imports:
      dplyr (>= 1.1.0),
      ggplot2 (>= 4.0.0),
      rlang (>= 1.1.0),
      scales,
      cli
  Suggests:
      sysfonts,
      showtext,
      knitr,
      rmarkdown,
      testthat (>= 3.0.0)
  Config/testthat/edition: 3
  Encoding: UTF-8
  Roxygen: list(markdown = TRUE)
  RoxygenNote: 7.3.2
  LazyData: true
  VignetteBuilder: knitr
  ```

- [x] **Update** `README.Rmd`:
  - [x] Add disclaimer at top
  - [x] Update author information
  - [x] Add installation from GitHub
  - [x] Update examples and sections
  - [x] Add badges (license, R version, lifecycle)
  - [x] Re-knit to generate `README.md`
- [x] **Create** `NEWS.md` with Phase 1 changelog

---

## Phase 2: Code Modernization

**Goal**: Align with `claude/coding_guidelines.md` and modern R practices

### 2.1 Adopt Native Pipe `|>` Throughout
- [ ] **R/plot_column.R**: Lines 93-97 already use `|>` ✓
- [ ] Verify all package code uses `|>` not `%>%`
- [ ] Update documentation examples to use `|>`
- [ ] Note: `/temp` directory code not part of package

### 2.2 Update Function Internals

**R/benvi_palette.R**:
- [ ] Replace `stop()` with `cli::cli_abort()` for better error messages
- [ ] Add informative messages about available palettes
- [x] Already uses modern patterns ✓

**R/benvi_scales.R**:
- [ ] Fix parameter name inconsistency: `pal` vs `pal_name`
  - Current: R/plot_column.R:77 calls with `pal =`
  - Function signature expects `pal_name =`
  - Decision: Standardize on `palette` or `pal_name`?
- [ ] Add `cli` error messages
- [x] Already uses `{{ }}` correctly ✓

**R/plot_*.R functions**:
- [ ] **Simplify** `plot_add_xy()` in R/plot_scatter.R:92-111
  - Remove redundant `if (type == "none") { plot <- plot }` (lines 94-96)
  - Use `switch()` statement instead
- [ ] **Consolidate parameters** across all plot functions:
  - Currently: `fill`, `color`, and `variable` overlap
  - Proposal: Make `variable` primary, deprecate `fill`/`color`
  - Add `.by` parameter for modern grouping?
- [ ] Add input validation with `cli::cli_abort()`
- [ ] Replace `stopifnot()` with informative error messages

**R/utils.R**:
- [ ] **Document** `pretty_number()` Brazilian locale assumption
- [ ] Consider adding `locale` parameter for international use
- [ ] Or rename to `pretty_number_ptbr()` to be explicit

**R/theme_benvi.R**:
- [x] Already follows modern patterns ✓
- [ ] Test with ggplot2 4.0.0

### 2.3 Font Handling Improvements

**Current issue**: `.onLoad()` requires internet connection, fails silently

**R/showtext.R**:
- [ ] Add error handling for failed font downloads
- [ ] Add informative message when fonts unavailable
- [ ] Consider: Lazy loading (download on first use, not package load)
- [ ] Add `cli` messages: "Downloading fonts..." with progress

**R/fonts.R**:
- [ ] Improve `import_fonts()` with better UX
- [ ] Add option to use system fonts as fallback
- [ ] Document font requirements clearly
- [ ] Consider: Add `check_fonts()` helper function

**Example improvement**:
```r
.onLoad <- function(libname, pkgname) {
  tryCatch({
    cli::cli_alert_info("Loading Poppins and Roboto fonts from Google Fonts...")
    sysfonts::font_add_google("Poppins", family = "Poppins")
    sysfonts::font_add_google("Roboto", family = "Roboto")
    showtext::showtext_auto()
    cli::cli_alert_success("Fonts loaded successfully")
  }, error = function(e) {
    cli::cli_alert_warning("Could not download fonts. Charts will use default fonts.")
    cli::cli_alert_info("Run {.run import_fonts()} when online to enable custom fonts.")
  })
}
```

### 2.4 Documentation Modernization

**Update all function documentation**:
- [ ] Add data-masking parameter tags:
  ```r
  #' @param var <[`data-masked`][dplyr::dplyr_data_masking]> Column name
  ```
- [ ] Update examples to use modern syntax (`|>`, `.by`, etc.)
- [ ] Add return type documentation consistently
- [ ] Add `@family` tags to group related functions
- [ ] Ensure all exported functions have `@export`

**Create package documentation**:
- [ ] Add `R/benviplot-package.R` with package-level documentation
- [ ] Document available palette names
- [ ] Add startup message with disclaimer?

---

## Phase 3: Testing Infrastructure

### 3.1 Setup testthat
- [ ] **Create** `tests/testthat/` directory structure
- [ ] **Create** `tests/testthat.R` entry point
- [ ] Add `testthat (>= 3.0.0)` to Suggests in DESCRIPTION
- [ ] Add `Config/testthat/edition: 3`

### 3.2 Core Tests

**tests/testthat/test-benvi_palette.R**:
- [ ] Test all palette names return correct number of colors
- [ ] Test `direction = -1` reverses palette
- [ ] Test `type = "continuous"` interpolation
- [ ] Test `type = "discrete"` with `n > length(pal)` throws error
- [ ] Test invalid palette name throws error

**tests/testthat/test-benvi_scales.R**:
- [ ] Test scales work with ggplot2 4.0.0
- [ ] Test discrete scales with sample data
- [ ] Test continuous scales with sample data
- [ ] Test parameter passing (pal_name, direction, etc.)

**tests/testthat/test-plot_functions.R**:
- [ ] Test each `plot_*()` function creates ggplot object
- [ ] Test with and without `variable` parameter
- [ ] Test edge cases (empty data, NA values, etc.)
- [ ] Test text labels work correctly

**tests/testthat/test-theme.R**:
- [ ] Test `theme_benvi()` returns theme object
- [ ] Test theme works with ggplot2 4.0.0

### 3.3 ggplot2 4.0.0 Compatibility Testing
- [ ] Install ggplot2 4.0.0 in test environment
- [ ] Run all tests with ggplot2 4.0.0
- [ ] Verify no S3/S7 object access issues
- [ ] Update DESCRIPTION: `ggplot2 (>= 4.0.0)`
- [ ] Document ggplot2 4.0.0 requirement in README

---

## Phase 4: Vignettes

**Goal**: Comprehensive user documentation with examples

### 4.1 Create Vignette Structure
- [ ] **Create** `vignettes/` directory
- [ ] Add `knitr` and `rmarkdown` to Suggests
- [ ] Add `VignetteBuilder: knitr` to DESCRIPTION

### 4.2 Vignette 1: Getting Started
**File**: `vignettes/getting-started.Rmd`

**Content**:
- Introduction to benviplot
- Installation instructions
- Basic palette usage
- Simple plotting examples
- Font setup and troubleshooting

**Outline**:
```markdown
# Getting Started with benviplot

## Introduction
- What is benviplot?
- Disclaimer about Benvi brand
- Color palette philosophy

## Installation
- From GitHub: remotes::install_github()
- Font requirements
- Troubleshooting font issues

## Quick Start
- View available palettes
- Use colors in base R plots
- Use colors in ggplot2

## Basic Examples
- Simple scatter plot with benvi colors
- Bar chart with benvi palette
- Customizing plots with theme_benvi()
```

### 4.3 Vignette 2: Color Palettes
**File**: `vignettes/color-palettes.Rmd`

**Content**:
- Complete palette gallery with visual swatches
- Palette naming conventions (Set, Qual, Seq, etc.)
- When to use each palette type
- Accessibility considerations
- Combining palettes

**Outline**:
```markdown
# Color Palettes in benviplot

## Palette Types
- Basic palettes (3 colors)
- Set palettes (4 colors) - Set0 through Set7
- Qualitative palettes (8 colors) - Qual1 through Qual9
- Sequential palettes (9 colors) - Seq0 through Seq7
- City-specific (spo_*, rio_*, bhe_*)
- Index colors (index_blue, index_prpl)

## Gallery
[Visual display of all palettes with code to reproduce]

## Usage Guidelines
- Qualitative data: use Qual* palettes
- Sequential data: use Seq* palettes
- Diverging data: use *_div palettes
- Accessibility tips

## Advanced Usage
- Extracting specific colors
- Reversing palettes
- Interpolating custom colors
```

### 4.4 Vignette 3: Plot Functions
**File**: `vignettes/plot-functions.Rmd`

**Content**:
- Overview of all `plot_*()` functions
- Detailed examples for each
- Customization options
- When to use plot helpers vs. raw ggplot2

**Outline**:
```markdown
# Plot Helper Functions

## Overview
- plot_line()
- plot_column()
- plot_scatter()
- plot_area()
- plot_histogram()

## Common Parameters
- variable: grouping aesthetic
- pal: palette selection
- scale_name, scale_label: legend customization

## Examples
[Detailed examples for each function]

## Customization
- Adding layers to helper plots
- Combining with custom ggplot2 code
- When to use helpers vs. building from scratch
```

### 4.5 Vignette 4: Themes and Styling
**File**: `vignettes/themes-and-styling.Rmd`

**Content**:
- Using `theme_benvi()`
- Font configuration
- Customizing the theme
- Creating publication-ready plots

---

## Phase 5: pkgdown Website

**Goal**: Professional documentation website hosted on GitHub Pages

### 5.1 Setup pkgdown
- [ ] Add `pkgdown` to Suggests
- [ ] Run `usethis::use_pkgdown()` or create manually
- [ ] **Create** `_pkgdown.yml` configuration file

### 5.2 Configure _pkgdown.yml

```yaml
url: https://viniciusoike.github.io/benviplot/

template:
  bootstrap: 5
  bootswatch: flatly
  theme: arrow-light

home:
  title: benviplot • Color Palettes for Data Visualization
  description: >
    ggplot2 extensions and color palettes for creating quality graphics.
    Uses color schemes from the discontinued Benvi brand.

navbar:
  structure:
    left:  [intro, reference, articles, news]
    right: [search, github]
  components:
    home:
      icon: fas fa-home fa-lg
      href: index.html
    reference:
      text: Reference
      href: reference/index.html
    articles:
      text: Articles
      menu:
      - text: Getting Started
        href: articles/getting-started.html
      - text: Color Palettes
        href: articles/color-palettes.html
      - text: Plot Functions
        href: articles/plot-functions.html
      - text: Themes and Styling
        href: articles/themes-and-styling.html
    news:
      text: News
      href: news/index.html
    github:
      icon: fab fa-github fa-lg
      href: https://github.com/viniciusoike/benviplot

reference:
  - title: Color Palettes
    desc: Functions for accessing and using color palettes
    contents:
    - benvi_palette
    - print.palette

  - title: ggplot2 Scales
    desc: Discrete and continuous scales for ggplot2
    contents:
    - starts_with("scale_")

  - title: Plot Helpers
    desc: Wrapper functions for common plot types
    contents:
    - plot_line
    - plot_column
    - plot_scatter
    - plot_area
    - plot_histogram
    - plot_line_trend
    - plot_column_label
    - plot_add_xy

  - title: Themes
    desc: ggplot2 themes
    contents:
    - theme_benvi

  - title: Utilities
    desc: Helper functions
    contents:
    - pretty_number
    - import_fonts

  - title: Data
    desc: Example datasets (if keeping iqa)
    contents:
    - starts_with("iqa")

footer:
  structure:
    left: developed_by
    right: disclaimer
  components:
    disclaimer: >
      <p>This is an unofficial, independent project not affiliated with
      QuintoAndar. Benvi was a discontinued brand of QuintoAndar (2024).
      This package uses publicly available color schemes for data
      visualization purposes.</p>
```

### 5.3 Customize pkgdown Site

**Create** `pkgdown/extra.css`:
- [ ] Custom CSS for palette displays
- [ ] Color swatches styling
- [ ] Improved code block formatting

**Create** `pkgdown/extra.js`:
- [ ] Interactive palette picker (optional)
- [ ] Copy-to-clipboard for hex codes

### 5.4 Homepage Content

**Update** `README.Rmd` for pkgdown homepage:
- [ ] Hero section with example plot
- [ ] Key features list
- [ ] Installation instructions
- [ ] Quick example
- [ ] Link to vignettes
- [ ] Disclaimer prominently displayed

### 5.5 Build and Deploy

**Local testing**:
- [ ] Run `pkgdown::build_site()` locally
- [ ] Review all pages
- [ ] Check links work
- [ ] Verify palette displays correctly

**GitHub Pages setup**:
- [ ] Enable GitHub Pages in repository settings
- [ ] Configure to deploy from `gh-pages` branch
- [ ] **Option A**: Manual deployment with `pkgdown::deploy_to_branch()`
- [ ] **Option B**: GitHub Actions for automatic deployment (see Phase 6)

---

## Phase 6: Package Infrastructure

### 6.1 GitHub Repository Setup

**Create repository structure**:
- [ ] `.github/ISSUE_TEMPLATE/` - Issue templates
- [ ] `.github/PULL_REQUEST_TEMPLATE.md` - PR template
- [ ] `.github/CONTRIBUTING.md` - Contribution guidelines
- [ ] `.github/CODE_OF_CONDUCT.md` - Code of conduct

### 6.2 GitHub Actions

**Create** `.github/workflows/R-CMD-check.yaml`:
- [ ] Runs R CMD check on push/PR
- [ ] Tests on multiple R versions (4.1, 4.2, 4.3, 4.4)
- [ ] Tests on multiple OS (Ubuntu, macOS, Windows)

**Create** `.github/workflows/pkgdown.yaml`:
- [ ] Auto-builds and deploys pkgdown site on push to main
- [ ] Runs on successful R CMD check

**Create** `.github/workflows/test-coverage.yaml`:
- [ ] Runs test coverage with covr package
- [ ] Posts coverage to Codecov or similar

### 6.3 Development Tools

**Create** `dev/` directory (git-ignored):
```r
# dev/01_setup.R - Initial package setup script
# dev/02_dev.R - Development helpers
# dev/03_deploy.R - Deployment checklist
```

**Update** `.Rbuildignore`:
```
^dev$
^claude$
^temp$
^\.github$
^_pkgdown\.yml$
^docs$
^pkgdown$
^\.Rproj\.user$
^.*\.Rproj$
^README\.Rmd$
^LICENSE\.md$
^DISCLAIMER\.md$
```

**Update** `.gitignore`:
```
.Rproj.user
.Rhistory
.RData
.Ruserdata
dev/
docs/
inst/doc
```

### 6.4 NEWS.md

**Create** `NEWS.md`:
```markdown
# benviplot 1.0.0 (Initial Release)

## Major Features

* Complete set of color palettes inspired by the Benvi brand
* ggplot2 scales for discrete and continuous data
* Plot helper functions for common visualizations
* Custom theme with Poppins font support
* Comprehensive documentation and vignettes

## Palettes

* 8 Set palettes (4 colors each)
* 9 Qualitative palettes (8 colors each)
* 8 Sequential palettes (9 colors each)
* City-specific palettes for São Paulo, Rio, and Belo Horizonte
* Index color scales

## Functions

### Color Palettes
* `benvi_palette()` - Access and customize color palettes

### ggplot2 Scales
* `scale_color_benvi_d()` / `scale_fill_benvi_d()` - Discrete scales
* `scale_color_benvi_c()` / `scale_fill_benvi_c()` - Continuous scales

### Plot Helpers
* `plot_line()` - Line charts
* `plot_column()` - Column/bar charts
* `plot_scatter()` - Scatter plots
* `plot_area()` - Area charts
* `plot_histogram()` - Histograms

### Themes
* `theme_benvi()` - Custom ggplot2 theme

### Utilities
* `import_fonts()` - Download and setup Google Fonts
* `pretty_number()` - Format numbers for Brazilian locale

## Technical Details

* Requires R >= 4.1.0
* Compatible with ggplot2 4.0.0+
* Uses modern tidyverse patterns (native pipe |>, .by grouping)
* Follows tidyverse style guide

## Legal

This is an unofficial, independent project not affiliated with
QuintoAndar. See DISCLAIMER.md for details.
```

---

## Phase 7: Final Checks & Release

### 7.1 Package Quality Checks

**Run comprehensive checks**:
- [ ] `devtools::check()` - Must pass with 0 errors, 0 warnings, 0 notes
- [ ] `goodpractice::gp()` - Review and address recommendations
- [ ] `spelling::spell_check_package()` - Fix typos
- [ ] `urlchecker::url_check()` - Verify all URLs work
- [ ] Manual check: All examples run successfully
- [ ] Manual check: All vignettes knit successfully

**Code coverage**:
- [ ] Run `covr::package_coverage()`
- [ ] Target: >70% coverage minimum, >85% preferred
- [ ] Add tests for uncovered areas

### 7.2 Documentation Review

**Review checklist**:
- [ ] All exported functions documented
- [ ] All parameters documented
- [ ] All examples work
- [ ] README is comprehensive and current
- [ ] Vignettes are complete and render correctly
- [ ] pkgdown site builds without errors
- [ ] All links work (internal and external)
- [ ] Disclaimer visible on all key pages

### 7.3 Version Control

**Pre-release tasks**:
- [ ] Ensure clean git status
- [ ] All changes committed
- [ ] Update `NEWS.md` with release date
- [ ] Update version in DESCRIPTION to 1.0.0
- [ ] Re-run `devtools::document()`
- [ ] Commit: "Prepare for 1.0.0 release"

**Create release**:
- [ ] Create git tag: `git tag -a v1.0.0 -m "benviplot 1.0.0"`
- [ ] Push tags: `git push --tags`
- [ ] Create GitHub release with release notes
- [ ] Attach source tarball to release

### 7.4 Deployment

**Deploy documentation**:
- [ ] Run `pkgdown::build_site()`
- [ ] Deploy to GitHub Pages (manual or via Actions)
- [ ] Verify site is live and working

**Optional: Submit to CRAN**:
- [ ] Review CRAN policies
- [ ] Run `devtools::check_win_devel()` (Windows check)
- [ ] Run `rhub::check_for_cran()` (multiple platforms)
- [ ] Prepare cran-comments.md
- [ ] Submit: `devtools::release()`
- [ ] Respond to CRAN feedback if any

### 7.5 Announcement

**Prepare announcement**:
- [ ] Write blog post (optional)
- [ ] Prepare social media posts
- [ ] Post to r-packages mailing list (optional)
- [ ] Post to relevant R communities

---

## Phase 8: Post-Release Maintenance

### 8.1 Issue Management
- [ ] Monitor GitHub issues
- [ ] Create issue labels (bug, enhancement, question, etc.)
- [ ] Respond to user questions
- [ ] Triage and prioritize bugs

### 8.2 Future Development
- [ ] Collect user feedback
- [ ] Plan for version 1.1.0 features
- [ ] Consider community contributions
- [ ] Keep up with ggplot2 updates

---

## Implementation Timeline

### Sprint 1 (Week 1): Foundation
- Phase 1: Data cleanup & legal compliance
- Phase 2.1-2.2: Basic code modernization
- Create basic test infrastructure

**Deliverable**: Clean, legally compliant codebase

### Sprint 2 (Week 2): Code Quality
- Phase 2.3-2.4: Complete code modernization
- Phase 3.1-3.2: Implement core tests
- Update all documentation

**Deliverable**: Modernized, tested package

### Sprint 3 (Week 3): Documentation
- Phase 4: Create all vignettes
- Phase 3.3: ggplot2 4.0.0 testing
- Complete function documentation

**Deliverable**: Comprehensive documentation

### Sprint 4 (Week 4): Website & Infrastructure
- Phase 5: Build pkgdown website
- Phase 6: Setup GitHub Actions & infrastructure
- Local testing and refinement

**Deliverable**: Professional package website

### Sprint 5 (Week 5): Release Preparation
- Phase 7: Final checks and quality assurance
- Bug fixes and polish
- Prepare release materials

**Deliverable**: Release candidate

### Sprint 6 (Week 6): Release & Launch
- Deploy documentation
- Create GitHub release
- Announce to community
- Monitor for issues

**Deliverable**: benviplot 1.0.0 released!

---

## Success Metrics

### Release Readiness
- [ ] All tests passing
- [ ] R CMD check: 0 errors, 0 warnings, 0 notes
- [ ] Documentation coverage: 100% of exported functions
- [ ] Test coverage: >70%
- [ ] pkgdown site live and functional

### Post-Release (First 3 months)
- GitHub stars target: 50+
- Issues opened (shows engagement): 5+
- Pull requests from community: 1+
- Download count (if on CRAN): 100+

---

## Risk Management

### High Risk Items
1. **Sensitive data exposure**: Mitigated by Phase 1 thorough cleanup
2. **Legal issues**: Mitigated by clear disclaimer and using only public info
3. **ggplot2 4.0.0 incompatibility**: Mitigated by thorough testing in Phase 3.3
4. **Font loading failures**: Mitigated by robust error handling in Phase 2.3

### Contingency Plans
- If CRAN rejects: Maintain GitHub-only distribution
- If legal concerns arise: Prepared to rename or modify package
- If font issues persist: Provide fallback to system fonts
- If ggplot2 issues: Pin to ggplot2 3.5.x until resolved

---

## Resources & References

### Key Files to Create/Update
- `DISCLAIMER.md` (new)
- `NEWS.md` (new)
- `_pkgdown.yml` (new)
- `.github/workflows/*.yaml` (new)
- `vignettes/*.Rmd` (new)
- `tests/testthat/*.R` (new)
- `DESCRIPTION` (update)
- `README.Rmd` (update)
- `R/benviplot-package.R` (new)

### External Resources
- ggplot2 4.0.0 release notes: https://www.tidyverse.org/blog/2025/09/ggplot2-4-0-0/
- Modern R development guide: `claude/coding_guidelines.md`
- pkgdown documentation: https://pkgdown.r-lib.org/
- R packages book: https://r-pkgs.org/
- Tidyverse style guide: https://style.tidyverse.org/

---

**Document Version**: 1.0
**Next Review**: After Phase 1 completion
