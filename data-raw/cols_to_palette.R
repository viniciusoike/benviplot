get_colors <- function(x) {

  if (all(is.character(x)) && !all(stringr::str_detect(x, "#"))) {
    names <- x
    hex <- colors[match({{ x }}, colors$name), ]$hex
    hex <- structure(hex, class = "colors")
    n <- seq(1, length(x))

    return(
      list(hex = hex, names = names, n = n)
    )

  } else {

    out <- list(
      hex = structure(x, class = "colors"),
      names = paste0("color_", 1:length(x)),
      n = seq(1, length(x))
      )

    return(out)

    }

}

get_hex <- function(x) {

  hex <- get_colors(x)$hex
  hex <- structure(hex, class = "colors")

  return(hex)

}

colors <- readr::read_rds(here::here("inst/extdata/benvi_colors.rds"))

basic <- c("AzulQuinto", "BrancoQuinto", "Preto")
set0 <- c("Concreto", "CinzaQuente", "Creme", "Branco")
set1 <- c("Chocolate", "Cafe", "Amendoim", "Trigo")
set2 <- c("Ocre", "Manteiga", "Lima", "Oliva")
set3 <- c("Musgo", "Floresta", "Primavera", "Petroleo")
set4 <- c("Noite", "Topazio", "Capri", "Lirio")
set5 <- c("Ameixa", "Violeta", "Quartzo", "Orquidea")
set6 <- c("Cereja", "Blush", "Rosa", "Lavanda")
set7 <- c("Tijolo", "Terracota", "Pessego", "Areia")

x <- c(basic, set0, set1, set2, set3, set4, set5, set6, set7)
check <- all(x %in% colors$name)

if (isTRUE(check)) {
  message("No name color problems.")
}

sets <- cbind(set0, set1, set2, set3, set4, set5, set6, set7)

qual1 <- sets[1, ]
qual2 <- sets[2, ]
qual3 <- sets[3, ]
qual4 <- sets[4, ]

#> Create sequential color palettes using interpolation
seqs <- sets[c(1, 4), ]
seqs <- as.data.frame(seqs)

sequential <- list()

for (i in seq_along(seqs)) {

  interpolation <- colorRampPalette(get_hex(seqs[, i]))(9)
  sequential[[i]] <- structure(interpolation, class = "colors")

  }

names(sequential) <- paste0("seq", 0:7)

spo_seq <- c("Ameixa", "Violeta")
spo_div <- c("Ameixa", "CinzaQuente")
spo_qual <- c(spo_seq, "Floresta", "Primavera", "Capri", "Areia", "Blush", "CinzaQuente")

rio_seq <- c("Musgo", "Primavera")
rio_div <- c("Musgo", "CinzaQuente")
rio_qual <- c(rio_seq, "Ocre", "Manteiga", "Topazio", "Orquidea", "Quartzo", "CinzaQuente")

bhe_seq <- c("Cereja", "Rosa")
bhe_div <- c("Cereja", "CinzaQuente")
bhe_qual <- bhe_seq

qual5 <- c("Floresta", "Primavera", "Violeta", "Quartzo", "Cafe", "Amendoim", "Oliva", "Lima")
qual6 <- c("Petroleo", "Lirio", "Orquidea", "Lavanda", "Areia")
qual7 <- c("Violeta", "Quartzo", "Lirio", "Floresta", "Primavera")
qual8 <- c("Topazio", "Pessego", "Musgo", "Violeta", "Terracota")
qual9 <- c("AzulQuinto", "Manteiga", "Floresta", "Violeta", "Blush")

index_blue <- c(
  "#021841", "#192C50", "#2F405F", "#46546E", "#5D687D", "#737C8C", "#8A919C",
  "#A0A5AB", "#B7B9BA", "#CECDC9")
index_prpl <- c(
  "#441835", "#552C45", "#654055", "#765466", "#876876", "#977C86", "#A89196",
  "#B8A5A6", "#C9B9B6", "#DACDC7"
)

sets <- list(
  grays = set0,
  browns = set1,
  yellows = set2,
  greens = set3,
  blues = set4,
  purples = set5,
  pinks = set6,
  oranges = set7,
  seq_grays = sequential$seq0,
  seq_browns = sequential$seq1,
  seq_yellows = sequential$seq2,
  seq_greens = sequential$seq3,
  seq_blues = sequential$seq4,
  seq_purples = sequential$seq5,
  seq_pinks = sequential$seq6,
  seq_oranges = sequential$seq7,
  qual_1 = qual1,
  qual_2 = qual2,
  qual_3 = qual3,
  qual_4 = qual4,
  qual_5 = qual5,
  qual_6 = qual6,
  qual_7 = qual7,
  qual_8 = qual8,
  qual_9 = qual9,
  spo_seq = spo_seq,
  spo_div = spo_div,
  spo_qual = spo_qual,
  rio_seq = rio_seq,
  rio_div = rio_div,
  rio_qual = rio_qual,
  bhe_seq = bhe_seq,
  bhe_div = bhe_div,
  benvi_blue = index_blue,
  benvi_purple = index_prpl,
  basic = basic
  )

palette_benvi <- lapply(sets, get_colors)
readr::write_rds(palette_benvi, here::here("inst/extdata/benvi_palette.rds"))
