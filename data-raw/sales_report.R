# Prepare IQAIW dataset for benviplot package
# IQAIW = Índice QuintoAndar ImovelWeb (rental price index)
# This script downloads, validates, and processes the public IQAIW data

library(dplyr)
library(readr)

# Download data from public QuintoAndar repository
dat <- read_csv("data-raw/qa_sales_report.csv")

# Define expected columns from source data
expected_names <- c(
  "ts_date",
  "name_city",
  "name_zone",
  "price_contract"
)

# Define standardized column names for package
new_names <- c(
  "date",
  "name_muni",
  "name_zone",
  "price_m2"
)

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

# Create named vector for column renaming
names(expected_names) <- new_names

# Process and clean data
clean_dat <- dat |>
  # Rename to standardized names
  dplyr::rename(dplyr::all_of(expected_names)) |>
  # Select and order final columns
  dplyr::select(dplyr::all_of(new_names))

# Assign to package dataset name
sales_report <- clean_dat

usethis::use_data(sales_report, overwrite = TRUE)
