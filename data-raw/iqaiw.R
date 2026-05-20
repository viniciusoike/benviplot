# Prepare IQAIW dataset for benviplot package
# IQAIW = Índice QuintoAndar ImovelWeb (rental price index)
# This script downloads, validates, and processes the public IQAIW data

library(dplyr)
library(readr)

# Download data from public QuintoAndar repository
dat <- read_csv(
  "https://publicfiles.data.quintoandar.com.br/indice_quintoandar_imovelweb/index_quintoandar_imovelweb_serie.csv"
)

# Define expected columns from source data
expected_names <- c(
  "ts_date",
  "city_name",
  "house_room",
  "est_price",
  "chg",
  "acum12m"
)

# Define standardized column names for package
new_names <- c("date", "name_muni", "rooms", "price_m2", "chg", "acum12m")

# Convert city abbreviations to full names
convert_city_names <- function(city) {
  vlname <- c(
    "bhe" = "Belo Horizonte",
    "bsb" = "Bras\u00edlia",
    "cur" = "Curitiba",
    "poa" = "Porto Alegre",
    "rio" = "Rio de Janeiro",
    "spo" = "São Paulo"
  )
  return(unname(vlname[city]))
}

# Validate that source data structure hasn't changed
if (!all(expected_names %in% names(dat))) {
  cli::cli_abort(c(
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
  dplyr::rename(dplyr::all_of(expected_names)) |>
  # Remove rows with missing prices
  dplyr::filter(!is.na(.data$price_m2)) |>
  # Convert city codes to full names
  dplyr::mutate(
    name_muni = convert_city_names(.data$name_muni),
    rooms = dplyr::if_else(rooms == "city", "Total", as.character(rooms))
  ) |>
  # Calculate index (base = 100 at first observation per city)
  dplyr::mutate(
    index = .data$price_m2 / dplyr::first(.data$price_m2) * 100,
    .by = "name_muni"
  ) |>
  # Select and order final columns
  dplyr::select(
    date,
    name_muni,
    rooms,
    index,
    chg,
    acum12m,
    price_m2
  )

# Assign to package dataset name
iqaiw <- clean_dat

# Save as package data
usethis::use_data(iqaiw, overwrite = TRUE)
