# Tests for plot helper functions
library(ggplot2)

# Load test data
data("iqa", package = "benviplot")

# Test data for various plots
test_ts_data <- data.frame(
  date = seq.Date(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "month"),
  value = rnorm(12, 100, 10),
  group = rep(c("A", "B", "C"), length.out = 12)
)

test_cat_data <- data.frame(
  category = c("Cat1", "Cat2", "Cat3", "Cat4"),
  value = c(10, 25, 15, 30)
)

# plot_line() tests ----

test_that("plot_line creates a ggplot object", {
  p <- plot_line(
    data = iqa,
    x = date,
    y = price_m2,
    variable = name_muni
  )

  expect_s3_class(p, "ggplot")
  expect_true("GeomLine" %in% class(p$layers[[1]]$geom))
})

test_that("plot_line works without variable parameter", {
  df_single <- subset(iqa, name_muni == "São Paulo")

  p <- plot_line(
    data = df_single,
    x = date,
    y = price_m2
  )

  expect_s3_class(p, "ggplot")
})

test_that("plot_line respects palette parameter", {
  p <- plot_line(
    data = test_ts_data,
    x = date,
    y = value,
    variable = group,
    palette = "qual_5"
  )

  expect_s3_class(p, "ggplot")
})

# plot_column() tests ----

test_that("plot_column creates a ggplot object", {
  p <- plot_column(
    data = test_cat_data,
    x = category,
    y = value
  )

  expect_s3_class(p, "ggplot")
  expect_true("GeomCol" %in% class(p$layers[[1]]$geom))
})

test_that("plot_column works with text labels", {
  p <- plot_column(
    data = test_cat_data,
    x = category,
    y = value,
    text = TRUE
  )

  expect_s3_class(p, "ggplot")
  # Should have both col and text layers
  expect_gte(length(p$layers), 2)
})

test_that("plot_column works with variable parameter", {
  df <- data.frame(
    cat = rep(c("A", "B"), each = 2),
    subcat = rep(c("X", "Y"), 2),
    val = c(10, 20, 15, 25)
  )

  p <- plot_column(
    data = df,
    x = cat,
    y = val,
    variable = subcat
  )

  expect_s3_class(p, "ggplot")
})

test_that("plot_column with text_inside creates ggfittext layer", {
  p <- plot_column(
    data = test_cat_data,
    x = category,
    y = value,
    text = TRUE,
    text_inside = TRUE
  )

  expect_s3_class(p, "ggplot")

  # Check for geom_bar_text layer from ggfittext
  geom_classes <- sapply(p$layers, function(x) class(x$geom))
  expect_true(any(sapply(geom_classes, function(x) "GeomBarText" %in% x)))
})

test_that("plot_column with text_inside respects flip parameter", {
  # Vertical bars (flip = FALSE)
  p1 <- plot_column(
    data = test_cat_data,
    x = category,
    y = value,
    text = TRUE,
    text_inside = TRUE,
    flip = FALSE
  )

  # Horizontal bars (flip = TRUE)
  p2 <- plot_column(
    data = test_cat_data,
    x = category,
    y = value,
    text = TRUE,
    text_inside = TRUE,
    flip = TRUE
  )

  expect_s3_class(p1, "ggplot")
  expect_s3_class(p2, "ggplot")

  # p2 should have coord_flip
  expect_true("CoordFlip" %in% class(p2$coordinates))
})

# plot_scatter() tests ----

test_that("plot_scatter creates a ggplot object", {
  p <- plot_scatter(
    data = mtcars,
    x = wt,
    y = mpg
  )

  expect_s3_class(p, "ggplot")
  expect_true("GeomPoint" %in% class(p$layers[[1]]$geom))
})

test_that("plot_scatter works with variable parameter", {
  p <- plot_scatter(
    data = mtcars,
    x = wt,
    y = mpg,
    variable = cyl
  )

  expect_s3_class(p, "ggplot")
})

test_that("plot_scatter can be faceted", {
  p <- plot_scatter(
    data = mtcars,
    x = wt,
    y = mpg,
    variable = cyl
  ) +
    facet_wrap(~gear)

  expect_s3_class(p, "ggplot")
  expect_true(!is.null(p$facet))
})

# plot_area() tests ----

test_that("plot_area creates a ggplot object", {
  p <- plot_area(
    data = test_ts_data,
    x = date,
    y = value,
    variable = group
  )

  expect_s3_class(p, "ggplot")
  expect_true("GeomArea" %in% class(p$layers[[1]]$geom))
})

test_that("plot_area works without variable", {
  df_single <- test_ts_data[test_ts_data$group == "A", ]

  p <- plot_area(
    data = df_single,
    x = date,
    y = value
  )

  expect_s3_class(p, "ggplot")
})

# plot_histogram() tests ----

test_that("plot_histogram creates a ggplot object", {
  p <- plot_histogram(
    data = mtcars,
    x = mpg
  )

  expect_s3_class(p, "ggplot")
  expect_true("GeomBar" %in% class(p$layers[[1]]$geom))
})

test_that("plot_histogram works with different bandwidth methods", {
  p1 <- plot_histogram(data = mtcars, x = mpg, method = "Sturges")
  p2 <- plot_histogram(data = mtcars, x = mpg, method = "fd")
  p3 <- plot_histogram(data = mtcars, x = mpg, method = "Scott")

  expect_s3_class(p1, "ggplot")
  expect_s3_class(p2, "ggplot")
  expect_s3_class(p3, "ggplot")
})

test_that("plot_histogram respects palette parameter", {
  p <- plot_histogram(
    data = mtcars,
    x = mpg,
    palette = "seq_greens"
  )

  expect_s3_class(p, "ggplot")
})

# plot_add_xy() tests ----

test_that("plot_add_xy adds axes to plot", {
  base_plot <- ggplot(mtcars, aes(x = wt - mean(wt), y = mpg - mean(mpg))) +
    geom_point()

  p_both <- plot_add_xy(base_plot, type = "both")
  p_x <- plot_add_xy(base_plot, type = "x")
  p_y <- plot_add_xy(base_plot, type = "y")
  p_none <- plot_add_xy(base_plot, type = "none")

  expect_s3_class(p_both, "ggplot")
  expect_s3_class(p_x, "ggplot")
  expect_s3_class(p_y, "ggplot")
  expect_s3_class(p_none, "ggplot")

  # Check that axes were added
  expect_gt(length(p_both$layers), length(base_plot$layers))
  expect_equal(length(p_none$layers), length(base_plot$layers))
})

# Edge case tests ----

test_that("plot functions handle NA values", {
  df_na <- data.frame(
    x = c(1, 2, NA, 4, 5),
    y = c(10, NA, 30, 40, 50),
    grp = c("A", "A", "B", "B", "B")
  )

  # These should not error, but may produce warnings about NA removal
  expect_s3_class(plot_line(df_na, x = x, y = y), "ggplot")
  expect_s3_class(plot_scatter(df_na, x = x, y = y), "ggplot")
  expect_s3_class(plot_histogram(df_na, x = x), "ggplot")
})

test_that("plot functions handle single row data", {
  df_single <- data.frame(x = 1, y = 10)

  expect_s3_class(plot_scatter(df_single, x = x, y = y), "ggplot")
  expect_s3_class(plot_column(df_single, x = as.character(x), y = y), "ggplot")
})

# Integration with benvi scales ----

test_that("plot functions work with benvi theme", {
  p <- plot_line(
    data = test_ts_data,
    x = date,
    y = value,
    variable = group
  ) +
    theme_benvi()

  expect_s3_class(p, "ggplot")
})

test_that("plot functions can be customized with additional layers", {
  p <- plot_scatter(
    data = mtcars,
    x = wt,
    y = mpg,
    variable = cyl
  ) +
    geom_smooth(method = "lm", se = FALSE, color = "black") +
    labs(title = "Custom Title")

  expect_s3_class(p, "ggplot")
  expect_equal(length(p$layers), 2)  # point + smooth
})
