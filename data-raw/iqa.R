library(readr)
library(dplyr)

dat <- read_csv("data-raw/iqa.csv")

# Define expected columns from source data
expected_names <- c(
  "date",
  "name_muni",
  "chg",
  "acum12m",
  "rent_price"
)

# Define standardized column names for package
new_names <- c(
  "date",
  "name_muni",
  "chg",
  "acum12m",
  "price_m2"
)

# Convert city abbreviations to full names
convert_city_names <- Vectorize(function(city) {
  vlname <- c(
    "bhe" = "Belo Horizonte",
    "bsb" = "Bras\u00edlia",
    "cur" = "Curitiba",
    "poa" = "Porto Alegre",
    "rio" = "Rio de Janeiro",
    "spo" = "São Paulo"
  )

  if (city %in% names(vlname)) {
    return(unname(vlname[city]))
  } else {
    return(city)
  }
})

# Validate that source data structure hasn't changed
if (!all(expected_names %in% names(dat))) {
  cli::cli_warn(c(
    "x" = "IQAIW data format has changed",
    "i" = "Expected columns: {.val {expected_names}}",
    "i" = "Found columns: {.val {names(dat)}}",
    "i" = "Please check the source or contact package maintainer"
  ))
}

# Create named vector for column renaming
names(expected_names) <- new_names

# Process and clean data
clean_dat <- dat |>
  # Rename to standardized names
  dplyr::rename(dplyr::any_of(expected_names)) |>
  # Remove rows with missing prices
  dplyr::filter(!is.na(.data$price_m2)) |>
  # Convert city codes to full names
  dplyr::mutate(name_muni = convert_city_names(.data$name_muni)) |>
  # Calculate index (base = 100 at first observation per city)
  dplyr::mutate(
    index = .data$price_m2 / dplyr::first(.data$price_m2) * 100,
    .by = "name_muni"
  ) |>
  # Select and order final columns
  dplyr::select(
    date,
    name_muni,
    index,
    chg,
    acum12m,
    price_m2
  )

# Assign to package dataset name
iqa <- clean_dat

# Save as package data
usethis::use_data(iqa, overwrite = TRUE)
