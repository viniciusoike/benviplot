benvi_colors <- readr::read_rds(here::here("inst/extdata/benvi_colors.rds"))
palette <- readr::read_rds(here::here("inst/extdata/benvi_palette.rds"))
usethis::use_data(benvi_colors, palette, internal = TRUE, overwrite = TRUE)
