benvi_colors_data <- readr::read_rds("inst/extdata/benvi_colors.rds")
palette <- readr::read_rds("inst/extdata/benvi_palette.rds")
usethis::use_data(benvi_colors_data, palette, internal = TRUE, overwrite = TRUE)
