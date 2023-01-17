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

    return(x)

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

sets <- list(
  Set0 = set0,
  Set1 = set1,
  Set2 = set2,
  Set3 = set3,
  Set4 = set4,
  Set5 = set5,
  Set6 = set6,
  Set7 = set7,
  Seq0 = list(hex = sequential$seq0),
  Seq1 = list(hex = sequential$seq1),
  Seq2 = list(hex = sequential$seq2),
  Seq3 = list(hex = sequential$seq3),
  Seq4 = list(hex = sequential$seq4),
  Seq5 = list(hex = sequential$seq5),
  Seq6 = list(hex = sequential$seq6),
  Seq7 = list(hex = sequential$seq7),
  Qual1 = qual1,
  Qual2 = qual2,
  Qual3 = qual3,
  Qual4 = qual4,
  Qual5 = qual5,
  Qual6 = qual6,
  Qual7 = qual7,
  Qual8 = qual8,
  Qual9 = qual9,
  spo_seq = spo_seq,
  spo_div = spo_div,
  spo_qual = spo_qual,
  rio_seq = rio_seq,
  rio_div = rio_div,
  rio_qual = rio_qual,
  bhe_seq = bhe_seq,
  bhe_div = bhe_div,
  Basic = basic)

palette_benvi <- lapply(sets, get_colors)
readr::write_rds(palette_benvi, here::here("inst/extdata/benvi_palette.rds"))
