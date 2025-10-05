# Tests for benvi_palette() function

test_that("benvi_palette returns correct number of colors", {
  # Set palettes have 4 colors
  expect_length(benvi_palette("Set0"), 4)
  expect_length(benvi_palette("Set3"), 4)

  # Qual palettes have varying lengths
  expect_length(benvi_palette("Qual1"), 8)
  expect_length(benvi_palette("Qual2"), 8)
  expect_length(benvi_palette("Qual5"), 8)

  # Seq palettes have 9 colors
  expect_length(benvi_palette("Seq0"), 9)
  expect_length(benvi_palette("Seq5"), 9)

  # City palettes
  expect_length(benvi_palette("spo_seq"), 2)
  expect_length(benvi_palette("rio_qual"), 8)

  # Index palettes
  expect_length(benvi_palette("index_blue"), 10)
  expect_length(benvi_palette("index_prpl"), 10)
})

test_that("benvi_palette returns valid hex colors", {
  pal <- benvi_palette("Set3")

  # Check all are character strings
  expect_type(pal, "character")

  # Check hex format (#XXXXXX)
  expect_true(all(grepl("^#[0-9A-F]{6}$", pal, ignore.case = TRUE)))
})

test_that("benvi_palette has correct class", {
  pal <- benvi_palette("Qual2")
  expect_s3_class(pal, "palette")
})

test_that("benvi_palette discrete mode works correctly", {
  # Request fewer colors than available
  pal <- benvi_palette("Qual2", n = 3, type = "discrete")
  expect_length(pal, 3)

  # Request exact number of colors
  pal <- benvi_palette("Set1", n = 4, type = "discrete")
  expect_length(pal, 4)
})

test_that("benvi_palette continuous mode interpolates correctly", {
  # Request more colors than available
  pal <- benvi_palette("Seq5", n = 20, type = "continuous")
  expect_length(pal, 20)

  # All should still be valid hex colors
  expect_true(all(grepl("^#[0-9A-F]{6}$", pal, ignore.case = TRUE)))

  # Test with small palette
  pal <- benvi_palette("spo_seq", n = 10, type = "continuous")
  expect_length(pal, 10)
})

test_that("benvi_palette direction parameter works", {
  pal_normal <- benvi_palette("Set1")
  pal_reversed <- benvi_palette("Set1", direction = -1)

  # Should be same length
  expect_length(pal_reversed, length(pal_normal))

  # Should be reversed (compare as character vectors)
  expect_equal(as.character(pal_normal), rev(as.character(pal_reversed)))
})

test_that("benvi_palette throws error for invalid direction", {
  expect_error(
    benvi_palette("Set1", direction = 2),
    "direction.*must be 1 or -1"
  )

  expect_error(
    benvi_palette("Set1", direction = 0),
    "direction.*must be 1 or -1"
  )
})

test_that("benvi_palette throws error for invalid palette name", {
  expect_error(
    benvi_palette("InvalidPalette"),
    "not found"
  )

  expect_error(
    benvi_palette("NotARealPalette"),
    "not found"
  )
})

test_that("benvi_palette throws error when requesting too many discrete colors", {
  expect_error(
    benvi_palette("Set3", n = 10, type = "discrete"),
    "Too many colors"
  )

  expect_error(
    benvi_palette("Qual2", n = 20, type = "discrete"),
    "Too many colors"
  )
})

test_that("benvi_palette works with all palette names", {
  # Test all Set palettes
  for (i in 0:7) {
    pal_name <- paste0("Set", i)
    expect_s3_class(benvi_palette(pal_name), "palette")
  }

  # Test all Seq palettes
  for (i in 0:7) {
    pal_name <- paste0("Seq", i)
    expect_s3_class(benvi_palette(pal_name), "palette")
  }

  # Test all Qual palettes
  for (i in 1:9) {
    pal_name <- paste0("Qual", i)
    expect_s3_class(benvi_palette(pal_name), "palette")
  }

  # Test city palettes
  city_pals <- c("spo_seq", "spo_div", "spo_qual",
                 "rio_seq", "rio_div", "rio_qual",
                 "bhe_seq", "bhe_div")
  for (pal_name in city_pals) {
    expect_s3_class(benvi_palette(pal_name), "palette")
  }

  # Test index palettes
  expect_s3_class(benvi_palette("index_blue"), "palette")
  expect_s3_class(benvi_palette("index_prpl"), "palette")

  # Test Basic
  expect_s3_class(benvi_palette("Basic"), "palette")
})

test_that("benvi_palette n parameter defaults correctly", {
  # When n is not specified, should return all colors in palette
  pal_set <- benvi_palette("Set3")
  expect_length(pal_set, 4)

  pal_qual <- benvi_palette("Qual5")
  expect_length(pal_qual, 8)

  pal_seq <- benvi_palette("Seq2")
  expect_length(pal_seq, 9)
})

test_that("print.palette method works", {
  pal <- benvi_palette("Set3")

  # Check that it's using the custom print method
  expect_s3_class(pal, "palette")

  # Should not error when printing (produces graphical output, not text)
  expect_no_error(print(pal))
})
