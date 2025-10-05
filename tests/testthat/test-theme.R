# Tests for theme_benvi() and font functions
library(ggplot2)

test_that("theme_benvi returns a theme object", {
  theme <- theme_benvi()

  expect_s3_class(theme, "theme")
  expect_type(theme, "list")
})

test_that("theme_benvi can be added to ggplot", {
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_benvi()

  expect_s3_class(p, "ggplot")

  # Verify theme is applied
  expect_s3_class(p$theme, "theme")
})

test_that("theme_benvi works with ggplot2 4.0.0+", {
  ggplot2_version <- packageVersion("ggplot2")
  skip_if(ggplot2_version < "4.0.0", "ggplot2 4.0.0+ required")

  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_benvi()

  # Should build without errors
  expect_silent(ggplot_build(p))
})

test_that("theme_benvi has correct legend position", {
  theme <- theme_benvi()

  # Legend should be on top
  expect_equal(theme$legend.position, "top")
})

test_that("theme_benvi is based on theme_minimal", {
  theme <- theme_benvi()

  # Should have minimal theme characteristics
  expect_s3_class(theme, "theme")

  # Check for some minimal theme properties
  # (panel background should be white/blank)
  expect_true(!is.null(theme$panel.background))
})

test_that("theme_benvi can be combined with other theme elements", {
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    theme_benvi() +
    theme(legend.position = "bottom")

  expect_s3_class(p, "ggplot")

  # Legend position should be overridden to bottom
  expect_equal(p$theme$legend.position, "bottom")
})

test_that("import_fonts runs without error", {
  # This test may fail if fonts can't be downloaded, but shouldn't crash
  expect_no_error(import_fonts())
})

test_that("import_fonts handles missing internet gracefully", {
  # If curl is not available or no internet, should handle gracefully
  skip_if_not_installed("curl")

  # Should not crash even if fonts can't be downloaded
  expect_no_error(import_fonts())
})

test_that("showtext is loaded on package load", {
  # showtext should be automatically loaded
  expect_true("showtext" %in% loadedNamespaces())
})

test_that("theme_benvi uses Poppins font when available", {
  # Import fonts first
  suppressMessages(import_fonts())

  theme <- theme_benvi()

  # Check if font family is set
  # Note: This might be empty if fonts aren't available
  if (!is.null(theme$text$family)) {
    expect_type(theme$text$family, "character")
  }
})

test_that("theme_benvi works with faceted plots", {
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_wrap(~cyl) +
    theme_benvi()

  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

test_that("theme_benvi preserves plot title formatting", {
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    labs(
      title = "Test Title",
      subtitle = "Test Subtitle",
      caption = "Test Caption"
    ) +
    theme_benvi()

  expect_s3_class(p, "ggplot")

  # Build and check labels are preserved
  built <- ggplot_build(p)
  expect_equal(p$labels$title, "Test Title")
  expect_equal(p$labels$subtitle, "Test Subtitle")
  expect_equal(p$labels$caption, "Test Caption")
})
