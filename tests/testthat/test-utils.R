# Tests for utility functions

# format_num_br() tests ----

test_that("format_num_br formats numbers correctly", {
  result <- format_num_br(1234567.89)

  expect_type(result, "character")
  expect_length(result, 1)

  # Should use Brazilian formatting (. for thousands, , for decimal)
  expect_match(result, "\\.")
})

test_that("format_num_br handles different digit specifications", {
  x <- 1234567.89

  result_0 <- format_num_br(x, digits = 0)
  result_1 <- format_num_br(x, digits = 1)
  result_2 <- format_num_br(x, digits = 2)

  expect_type(result_0, "character")
  expect_type(result_1, "character")
  expect_type(result_2, "character")
})

test_that("format_num_br handles negative digits", {
  # Negative digits round to tens, hundreds, etc.
  result <- format_num_br(1234567, digits = -3)

  expect_type(result, "character")
})

test_that("format_num_br adds percent sign when requested", {
  result <- format_num_br(12.5, digits = 1, percent = TRUE)

  expect_type(result, "character")
  expect_match(result, "%$")
})

test_that("format_num_br handles vectors", {
  x <- c(100, 1000, 10000)
  result <- format_num_br(x)

  expect_type(result, "character")
  expect_length(result, 3)
})

test_that("format_num_br never uses scientific notation", {
  # format() switches to scientific notation when it is shorter, which made
  # format_num_br(1e5) return "1e+05"
  expect_equal(format_num_br(100000), "100.000")
  expect_equal(format_num_br(1e6), "1.000.000")
  expect_equal(format_num_br(1e15), "1.000.000.000.000.000")
  expect_false(any(grepl("e[+-]", format_num_br(10^(1:15)))))
})

test_that("format_num_br does not pad elements to a common width", {
  # format() right-justifies to the widest element unless trim = TRUE, which
  # left-padded shorter labels with spaces
  result <- format_num_br(c(100, 1000, 10000))

  expect_equal(result, c("100", "1.000", "10.000"))
  expect_false(any(grepl("^\\s", result)))
})

test_that("format_num_br handles zero", {
  result <- format_num_br(0)

  expect_type(result, "character")
  expect_equal(result, "0")
})

test_that("format_num_br handles negative numbers", {
  result <- format_num_br(-1234.56)

  expect_type(result, "character")
  expect_match(result, "^-")
})

test_that("format_num_br handles large numbers with separators", {
  result <- format_num_br(10000)  # Ten thousand

  expect_type(result, "character")
  expect_match(result, "\\.")  # Should have thousand separators
  expect_equal(result, "10.000")
})

test_that("format_num_br handles very small numbers", {
  result <- format_num_br(0.001, digits = 3)

  expect_type(result, "character")
})

test_that("format_num_br throws error for non-numeric input", {
  expect_error(
    format_num_br("not a number"),
    "must be numeric"
  )

  expect_error(
    format_num_br(factor(c("a", "b"))),
    "must be numeric"
  )
})

test_that("format_num_br throws error for invalid digits", {
  expect_error(
    format_num_br(123, digits = "not numeric"),
    "must be a single numeric"
  )

  expect_error(
    format_num_br(123, digits = c(1, 2)),
    "must be a single numeric"
  )
})

test_that("format_num_br throws error for invalid percent", {
  expect_error(
    format_num_br(123, percent = "yes"),
    "must be a single logical"
  )

  expect_error(
    format_num_br(123, percent = c(TRUE, FALSE)),
    "must be a single logical"
  )
})

test_that("format_num_br handles NA values", {
  result <- format_num_br(c(100, NA, 200))

  expect_type(result, "character")
  expect_length(result, 3)
  # format() converts NA to "NA" string
  expect_true(any(grepl("NA", result)))
})

test_that("format_num_br Brazilian format is correct", {
  result <- format_num_br(1234.56, digits = 2)

  # Should use . for thousands and , for decimals (Brazilian standard)
  expect_match(result, "1\\.234,56")
})
