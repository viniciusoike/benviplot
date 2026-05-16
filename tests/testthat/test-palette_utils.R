# Tests for palette utility functions

test_that("show_palettes runs without error for all types", {
  expect_no_error(show_palettes())
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

test_that("show_palettes errors on invalid type", {
  expect_error(show_palettes("invalid_type"), "must be one of")
})
