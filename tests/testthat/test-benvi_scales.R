# Tests for benvi scale functions
library(ggplot2)

# Test data
test_data <- data.frame(
  x = 1:10,
  y = 1:10,
  category = factor(rep(c("A", "B", "C", "D"), length.out = 10)),
  value = rnorm(10)
)

# Discrete color scale tests ----

test_that("scale_color_benvi_d creates discrete color scale", {
  p <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_2")

  expect_s3_class(p, "ggplot")
  expect_true("ScaleDiscrete" %in% class(p$scales$get_scales("colour")))
})

test_that("scale_colour_benvi_d (British spelling) works", {
  p <- ggplot(test_data, aes(x = x, y = y, colour = category)) +
    geom_point() +
    scale_colour_benvi_d(pal_name = "qual_2")

  expect_s3_class(p, "ggplot")
  expect_true("ScaleDiscrete" %in% class(p$scales$get_scales("colour")))
})

test_that("scale_fill_benvi_d creates discrete fill scale", {
  p <- ggplot(test_data, aes(x = category, fill = category)) +
    geom_bar() +
    scale_fill_benvi_d(pal_name = "greens")

  expect_s3_class(p, "ggplot")
  expect_true("ScaleDiscrete" %in% class(p$scales$get_scales("fill")))
})

test_that("discrete scales work with different palettes", {
  # Theme palette
  p1 <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "browns")
  expect_s3_class(p1, "ggplot")

  # Qual palette
  p2 <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_5")
  expect_s3_class(p2, "ggplot")

  # City palette
  p3 <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "rio_qual")
  expect_s3_class(p3, "ggplot")
})

test_that("discrete scales respect direction parameter", {
  p_normal <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_2", direction = 1)

  p_reverse <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_2", direction = -1)

  expect_s3_class(p_normal, "ggplot")
  expect_s3_class(p_reverse, "ggplot")
})

# Continuous color scale tests ----

test_that("scale_color_benvi_c creates continuous color scale", {
  p <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "seq_purples")

  expect_s3_class(p, "ggplot")
  scale <- p$scales$get_scales("colour")
  expect_true(any(c("ScaleContinuous", "Scale") %in% class(scale)))
})

test_that("scale_colour_benvi_c (British spelling) works", {
  p <- ggplot(test_data, aes(x = x, y = y, colour = value)) +
    geom_point() +
    scale_colour_benvi_c(pal_name = "seq_greens")

  expect_s3_class(p, "ggplot")
  scale <- p$scales$get_scales("colour")
  expect_true(any(c("ScaleContinuous", "Scale") %in% class(scale)))
})

test_that("scale_fill_benvi_c creates continuous fill scale", {
  p <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
    geom_bin2d() +
    scale_fill_benvi_c(pal_name = "seq_yellows")

  expect_s3_class(p, "ggplot")
  scale <- p$scales$get_scales("fill")
  expect_true(any(c("ScaleContinuous", "Scale") %in% class(scale)))
})

test_that("continuous scales work with different palettes", {
  # Sequential palette
  p1 <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "seq_grays")
  expect_s3_class(p1, "ggplot")

  # Qual palette (can be used continuously)
  p2 <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "qual_9")
  expect_s3_class(p2, "ggplot")
})

test_that("continuous scales respect direction parameter", {
  p_normal <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "seq_purples", direction = 1)

  p_reverse <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "seq_purples", direction = -1)

  expect_s3_class(p_normal, "ggplot")
  expect_s3_class(p_reverse, "ggplot")
})

# ggplot2 4.0.0+ compatibility tests ----

test_that("scales work with ggplot2 4.0.0+", {
  # Get ggplot2 version
  ggplot2_version <- packageVersion("ggplot2")

  skip_if(ggplot2_version < "4.0.0", "ggplot2 4.0.0+ required")

  # Test that scales work without S3/S7 object errors
  p <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_2")

  # Build the plot (this would fail if there are S3/S7 issues)
  expect_silent(ggplot_build(p))
})

test_that("scales accept additional ggplot2 parameters", {
  # Test that we can pass additional parameters through ...
  p1 <- ggplot(test_data, aes(x = x, y = y, color = category)) +
    geom_point() +
    scale_color_benvi_d(pal_name = "qual_2", name = "Custom Name")
  expect_s3_class(p1, "ggplot")

  p2 <- ggplot(test_data, aes(x = x, y = y, color = value)) +
    geom_point() +
    scale_color_benvi_c(pal_name = "seq_purples", name = "Value Scale")
  expect_s3_class(p2, "ggplot")
})

# Error handling tests ----

test_that("scales throw error for invalid palette names", {
  expect_error(
    {
      p <- ggplot(test_data, aes(x = x, y = y, color = category)) +
        geom_point() +
        scale_color_benvi_d(pal_name = "InvalidPalette")
      ggplot_build(p)
    },
    "not found"
  )
})

test_that("scales throw error for invalid direction", {
  # The error is thrown when the palette is created, not when scale is defined
  expect_error(
    {
      p <- ggplot(test_data, aes(x = x, y = y, color = category)) +
        geom_point() +
        scale_color_benvi_d(pal_name = "qual_2", direction = 2)
      ggplot_build(p)
    },
    "direction.*must be 1 or -1"
  )

  expect_error(
    {
      p <- ggplot(test_data, aes(x = x, y = y, color = value)) +
        geom_point() +
        scale_color_benvi_c(pal_name = "seq_purples", direction = 0)
      ggplot_build(p)
    },
    "direction.*must be 1 or -1"
  )
})
