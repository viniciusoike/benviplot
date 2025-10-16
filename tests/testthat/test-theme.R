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

test_that("check_poppins_installed returns logical", {
  result <- check_poppins_installed()
  expect_type(result, "logical")
  expect_length(result, 1)
})

test_that("font_status returns information", {
  # Should run without error and return invisibly
  expect_invisible(font_status())

  result <- font_status()
  expect_type(result, "list")
  expect_named(result, c("poppins_installed", "ragg_available"))
  expect_type(result$poppins_installed, "logical")
  expect_type(result$ragg_available, "logical")
})

test_that("theme_benvi uses appropriate font family", {
  theme <- theme_benvi()

  # Should always have a text family set (either Poppins or sans)
  expect_type(theme$text$family, "character")
  expect_true(theme$text$family %in% c("Poppins", "sans"))
})

test_that("get_benvi_font_family returns valid font", {
  # Internal function but important to test
  font <- get_benvi_font_family()

  expect_type(font, "character")
  expect_length(font, 1)
  expect_true(font %in% c("Poppins", "sans"))
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
