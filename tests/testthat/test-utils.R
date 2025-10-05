# Tests for utility functions

# pretty_number() tests ----

test_that("pretty_number formats numbers correctly", {
  result <- pretty_number(1234567.89)

  expect_type(result, "character")
  expect_length(result, 1)

  # Should use Brazilian formatting (. for thousands, , for decimal)
  expect_match(result, "\\.")
})

test_that("pretty_number handles different digit specifications", {
  x <- 1234567.89

  result_0 <- pretty_number(x, digits = 0)
  result_1 <- pretty_number(x, digits = 1)
  result_2 <- pretty_number(x, digits = 2)

  expect_type(result_0, "character")
  expect_type(result_1, "character")
  expect_type(result_2, "character")
})

test_that("pretty_number handles negative digits", {
  # Negative digits round to tens, hundreds, etc.
  result <- pretty_number(1234567, digits = -3)

  expect_type(result, "character")
})

test_that("pretty_number adds percent sign when requested", {
  result <- pretty_number(12.5, digits = 1, percent = TRUE)

  expect_type(result, "character")
  expect_match(result, "%$")
})

test_that("pretty_number handles vectors", {
  x <- c(100, 1000, 10000)
  result <- pretty_number(x)

  expect_type(result, "character")
  expect_length(result, 3)
})

test_that("pretty_number handles zero", {
  result <- pretty_number(0)

  expect_type(result, "character")
  expect_equal(result, "0")
})

test_that("pretty_number handles negative numbers", {
  result <- pretty_number(-1234.56)

  expect_type(result, "character")
  expect_match(result, "^-")
})

test_that("pretty_number handles large numbers with separators", {
  result <- pretty_number(10000)  # Ten thousand

  expect_type(result, "character")
  expect_match(result, "\\.")  # Should have thousand separators
  expect_equal(result, "10.000")
})

test_that("pretty_number handles very small numbers", {
  result <- pretty_number(0.001, digits = 3)

  expect_type(result, "character")
})

test_that("pretty_number throws error for non-numeric input", {
  expect_error(
    pretty_number("not a number"),
    "must be numeric"
  )

  expect_error(
    pretty_number(factor(c("a", "b"))),
    "must be numeric"
  )
})

test_that("pretty_number throws error for invalid digits", {
  expect_error(
    pretty_number(123, digits = "not numeric"),
    "must be a single numeric"
  )

  expect_error(
    pretty_number(123, digits = c(1, 2)),
    "must be a single numeric"
  )
})

test_that("pretty_number throws error for invalid percent", {
  expect_error(
    pretty_number(123, percent = "yes"),
    "must be a single logical"
  )

  expect_error(
    pretty_number(123, percent = c(TRUE, FALSE)),
    "must be a single logical"
  )
})

test_that("pretty_number handles NA values", {
  result <- pretty_number(c(100, NA, 200))

  expect_type(result, "character")
  expect_length(result, 3)
  # format() converts NA to "NA" string
  expect_true(any(grepl("NA", result)))
})

test_that("pretty_number Brazilian format is correct", {
  result <- pretty_number(1234.56, digits = 2)

  # Should use . for thousands and , for decimals (Brazilian standard)
  expect_match(result, "1\\.234,56")
})

# plot_add_xy() tests ----

test_that("plot_add_xy adds horizontal and vertical lines", {
  library(ggplot2)

  base_plot <- ggplot(mtcars, aes(x = wt - mean(wt), y = mpg - mean(mpg))) +
    geom_point()

  p <- plot_add_xy(base_plot, type = "both")

  expect_s3_class(p, "ggplot")

  # Should have added 2 layers (hline and vline)
  expect_equal(length(p$layers), 3)  # original + 2 new layers
})

test_that("plot_add_xy type='x' adds only horizontal line", {
  library(ggplot2)

  base_plot <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()

  p <- plot_add_xy(base_plot, type = "x")

  expect_s3_class(p, "ggplot")

  # Check for GeomHline
  geom_classes <- sapply(p$layers, function(l) class(l$geom)[1])
  expect_true("GeomHline" %in% geom_classes)
})

test_that("plot_add_xy type='y' adds only vertical line", {
  library(ggplot2)

  base_plot <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()

  p <- plot_add_xy(base_plot, type = "y")

  expect_s3_class(p, "ggplot")

  # Check for GeomVline
  geom_classes <- sapply(p$layers, function(l) class(l$geom)[1])
  expect_true("GeomVline" %in% geom_classes)
})

test_that("plot_add_xy type='none' adds no lines", {
  library(ggplot2)

  base_plot <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()

  original_layers <- length(base_plot$layers)
  p <- plot_add_xy(base_plot, type = "none")

  expect_s3_class(p, "ggplot")

  # Should not add any layers
  expect_equal(length(p$layers), original_layers)
})

test_that("plot_add_xy works with complex plots", {
  library(ggplot2)

  p <- ggplot(mtcars, aes(x = wt - mean(wt), y = mpg - mean(mpg), color = factor(cyl))) +
    geom_point() +
    facet_wrap(~gear) +
    theme_benvi()

  p_with_axes <- plot_add_xy(p, type = "both")

  expect_s3_class(p_with_axes, "ggplot")
  expect_no_error(ggplot_build(p_with_axes))
})

test_that("plot_add_xy preserves existing layers", {
  library(ggplot2)

  base_plot <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    geom_smooth(method = "lm")

  original_layers <- length(base_plot$layers)
  p <- plot_add_xy(base_plot, type = "both")

  # Should preserve original layers and add 2 more
  expect_gte(length(p$layers), original_layers)
})
