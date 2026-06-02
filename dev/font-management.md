# Font Management in R Packages

Notes on bundling and using custom fonts in R packages, based on hard-won
experience with benviplot and CRAN submissions.

## How R resolves fonts

R has two independent font resolution paths. Most font-related bugs come from
confusing the two.

**Base R devices** (pdf, postscript, png with `type = "cairo"`, the default
grDevices) use the system font database. Only fonts installed at the OS level
are visible. On Windows this means fonts registered in the Windows font
registry; on macOS, fonts in `/Library/Fonts` or `~/Library/Fonts`; on Linux,
fonts found by fontconfig.

**systemfonts-aware devices** (ragg's `agg_png`, `agg_tiff`, etc.) use the
systemfonts package to resolve fonts. These devices see both system fonts *and*
fonts registered programmatically with `systemfonts::register_font()`.

The critical implication: `systemfonts::register_font()` does NOT make a font
available to base R devices. A font can be "registered" and still invisible to
`pdf()`, `postscript()`, and `png()`.

## The CRAN problem

`R CMD check` renders examples using base R devices (typically PDF). CRAN
machines and win-builder do not have custom fonts installed at the OS level.
If your theme or plot function requests a font that only exists in the
systemfonts registry, the PDF device fails with:

```
font family 'MyFont' not found in PostScript font database
Error in grid.Call.graphics(C_text, ...) : invalid font type
```

This happens even though systemfonts reports the font as registered.

## Recommended strategy

### 1. Bundle the font files

Ship `.ttf` or `.otf` files in `inst/fonts/`. Keep only the weights you
actually use to minimize package size. Register them in `.onLoad()`:

```r
.onLoad <- function(libname, pkgname) {
  if (requireNamespace("systemfonts", quietly = TRUE)) {
    font_dir <- system.file("fonts", package = pkgname)
    systemfonts::register_font(
      name = "MyFont",
      plain = file.path(font_dir, "MyFont-Regular.ttf"),
      bold = file.path(font_dir, "MyFont-Bold.ttf"),
      italic = file.path(font_dir, "MyFont-Italic.ttf"),
      bolditalic = file.path(font_dir, "MyFont-BoldItalic.ttf")
    )
  }
}
```

### 2. Do not auto-detect for the default font family

There is no reliable way to auto-detect whether a font will work at
theme-creation time because:

- `systemfonts::registry_fonts()` only reflects the systemfonts registry,
  which base R devices (PDF, PostScript) ignore entirely.
- `systemfonts::system_fonts()` uses platform font APIs (e.g. CoreText on
  macOS) which are not the same as the base R PostScript/PDF font database.
  A font can appear in `system_fonts()` and still fail in `pdf()`.
- Checking whether ragg is installed is not enough. `R CMD check` uses the
  PDF device regardless of what packages are present.
- You cannot check the active device at theme-creation time because the
  device may not be open yet (it opens at print/render time).

The only safe default is `"sans"`. Keep font registration in `.onLoad()`
so the font is available for users who explicitly request it with ragg.

### 3. Always fall back to a safe default

Your theme should work without the custom font. Never let the default code
path request a font that might not render.

```r
default_font <- function() {
  if (font_is_available()) "MyFont" else "sans"
}
```

Let users override with an option or argument:

```r
my_theme <- function(
  base_family = getOption("mypkg.font_family", default_font()),
  ...
) {
  # ...
}
```

### 4. Put systemfonts and ragg in Suggests

Neither should be a hard dependency. The package works without them (using
"sans"), and works better with them.

```
Suggests: ragg, systemfonts
```

### 5. Provide a status function

Give users a way to diagnose their setup.

```r
font_status <- function() {
  # Report: is systemfonts installed? Is the font registered?
  # Is the font a system font? Is ragg available?
  # What will the theme actually use?
}
```

## Common mistakes

### Auto-detecting font availability for the default

The most common mistake. Every detection strategy has a gap.

- `systemfonts::registry_fonts()` only reflects the systemfonts registry.
  Base R devices (PDF, PostScript) ignore it. A font can be "registered" and
  still crash `R CMD check`.
- `systemfonts::system_fonts()` uses platform APIs (CoreText, fontconfig).
  These are not the same as the base R PostScript/PDF font database. A font
  reported by `system_fonts()` can still fail in `pdf()` or `postscript()`.
- Checking whether ragg is installed does not help. `R CMD check` uses the
  PDF device regardless.
- Checking `dev.cur()` at theme-creation time does not help. The device may
  not be open yet; it opens at print/render time.

The only safe default is `"sans"`. Register the bundled font in `.onLoad()`
so it is available for explicit opt-in, but never select it automatically.

### Treating font registration as font installation

`systemfonts::register_font()` is session-scoped and device-scoped. It does
not install the font on the OS. After restarting R, the font is gone unless
`.onLoad()` re-registers it. It is never visible to non-R applications, and
never visible to base R graphics devices regardless of session state.

### Using `extrafont` or `showtext` in a package

These packages solve the font problem for interactive use but create issues
in packages.

`extrafont` requires a one-time `font_import()` step that modifies a
user-global database. You cannot run this from `.onLoad()` on CRAN. It also
patches the PDF device in ways that can conflict with other packages.

`showtext` hijacks the graphics device to render text as paths. This works
well interactively but can cause unexpected behavior in `R CMD check` and
when combined with other packages that modify device behavior. It also
changes text rendering semantics (text is no longer selectable in PDFs).

For packages, `systemfonts` + `ragg` is the cleanest path. Both are
maintained by the tidyverse team, work together naturally, and do not require
user-global state.

### Forgetting to wrap examples

Even with a correct fallback, if your examples explicitly set
`base_family = "MyFont"`, they will fail on CRAN. Make sure examples use the
default (which falls back to "sans") or wrap font-dependent examples in
`\donttest{}`.

### Bundling too many font weights

Each `.ttf` file adds 100-300 KB to your package. CRAN has a soft 5 MB limit
on package tarballs. If your font family has 18 weights, bundle only the ones
your theme actually uses (typically Regular, Bold, Italic, BoldItalic).

### Not checking font license

Google Fonts are generally OFL (SIL Open Font License), which permits
bundling. Other fonts may not. Check the license before shipping font files
in `inst/`.

## Decision flowchart

When your theme/plot function needs to pick a font family:

1. Always default to `"sans"`.
2. Register the bundled font in `.onLoad()` so it is available for ragg users.
3. Let users opt in via `options()` or the `base_family` argument.
4. Provide a `font_status()` function that tells users how to enable the font.

Do NOT auto-select fonts based on registry status, system font detection, or
ragg availability. None of these guarantee the font will work with the device
that eventually renders the plot.
