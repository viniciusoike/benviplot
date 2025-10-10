# Tests for palette utility functions

test_that("benvi_colors returns all color names when called without arguments", {
  colors <- benvi_colors()

  expect_type(colors, "character")
  expect_gt(length(colors), 0)
  expect_true("Floresta" %in% colors)
  expect_true("Violeta" %in% colors)
  expect_true("AzulQuinto" %in% colors)
})

test_that("benvi_colors returns hex code for single color", {
  floresta_hex <- benvi_colors("Floresta")

  expect_type(floresta_hex, "character")
  expect_length(floresta_hex, 1)
  expect_match(floresta_hex, "^#[0-9A-F]{6}$", ignore.case = TRUE)
  expect_equal(floresta_hex, "#009850")
})

test_that("benvi_colors works with vector of color names", {
  colors <- benvi_colors(c("Floresta", "Violeta", "AzulQuinto"))

  expect_type(colors, "character")
  expect_length(colors, 3)
  expect_true(all(grepl("^#[0-9A-F]{6}$", colors, ignore.case = TRUE)))
})

test_that("benvi_colors throws error for invalid color name", {
  expect_error(
    benvi_colors("InvalidColor"),
    "not found"
  )

  expect_error(
    benvi_colors(c("Floresta", "InvalidColor")),
    "not found"
  )
})

test_that("list_palettes returns all palettes by default", {
  pals <- list_palettes()

  expect_type(pals, "character")
  expect_true("grays" %in% pals)
  expect_true("qual_1" %in% pals)
  expect_true("seq_greens" %in% pals)
  expect_true("spo_seq" %in% pals)
  expect_true("benvi_blue" %in% pals)
  expect_true("basic" %in% pals)
})

test_that("list_palettes filters by theme", {
  theme_pals <- list_palettes("theme")

  expect_type(theme_pals, "character")
  expect_length(theme_pals, 8)
  expect_true("grays" %in% theme_pals)
  expect_true("browns" %in% theme_pals)
  expect_false("qual_1" %in% theme_pals)
  expect_false("seq_grays" %in% theme_pals)
})

test_that("list_palettes filters by sequential", {
  seq_pals <- list_palettes("sequential")

  expect_type(seq_pals, "character")
  expect_length(seq_pals, 8)
  expect_true("seq_grays" %in% seq_pals)
  expect_true("seq_purples" %in% seq_pals)
  expect_false("grays" %in% seq_pals)
  expect_false("qual_1" %in% seq_pals)
})

test_that("list_palettes filters by qualitative", {
  qual_pals <- list_palettes("qualitative")

  expect_type(qual_pals, "character")
  expect_length(qual_pals, 9)
  expect_true("qual_1" %in% qual_pals)
  expect_true("qual_9" %in% qual_pals)
  expect_false("grays" %in% qual_pals)
  expect_false("seq_grays" %in% qual_pals)
})

test_that("list_palettes filters by city", {
  city_pals <- list_palettes("city")

  expect_type(city_pals, "character")
  expect_length(city_pals, 8)
  expect_true("spo_seq" %in% city_pals)
  expect_true("rio_qual" %in% city_pals)
  expect_true("bhe_div" %in% city_pals)
  expect_false("grays" %in% city_pals)
})

test_that("list_palettes filters by brand", {
  brand_pals <- list_palettes("brand")

  expect_type(brand_pals, "character")
  expect_length(brand_pals, 3)
  expect_true("basic" %in% brand_pals)
  expect_true("benvi_blue" %in% brand_pals)
  expect_true("benvi_purple" %in% brand_pals)
  expect_false("grays" %in% brand_pals)
})

test_that("list_palettes throws error for invalid type", {
  expect_error(
    list_palettes("invalid_type"),
    "must be one of"
  )
})

test_that("list_colors returns all color names", {
  colors <- list_colors()

  expect_type(colors, "character")
  expect_gt(length(colors), 0)
  expect_equal(colors, benvi_colors())
})

test_that("show_palettes runs without error", {
  # Test that show_palettes doesn't error
  expect_no_error(show_palettes())

  # Test with type parameter
  expect_no_error(show_palettes("theme"))
  expect_no_error(show_palettes("sequential"))
  expect_no_error(show_palettes("qualitative"))
  expect_no_error(show_palettes("city"))
  expect_no_error(show_palettes("brand"))
})

test_that("show_palettes works with n parameter", {
  expect_no_error(show_palettes(n = 5))
  expect_no_error(show_palettes("theme", n = 3))
})

test_that("show_palettes returns NULL invisibly", {
  result <- show_palettes()
  expect_null(result)
})
