# Replicating QuintoAndar research plots -----------------------------------
#
# Recreates charts from publicly available QuintoAndar research reports using
# benviplot palettes, scales, and theme. Each section is self-contained: it
# builds its own data, assembles a plot object, and writes a figure to
# man/figures/.
#
# Figures are written with ggsave_benvi(), which selects the ragg device for
# PNG output. This matters here: Poppins is registered via systemfonts, and
# only ragg-backed devices can see registered fonts.

# Setup --------------------------------------------------------------------

library(ggplot2)
library(dplyr)
library(ggtext)
library(benviplot)

# Used via :: below, so not attached: countrycode, forcats, ggrepel, readr,
# scales, tibble. Note that filter_out() and replace_values() in the last
# section require dplyr >= 1.2.0.

# Family size --------------------------------------------------------------

# Source: https://publicfiles.data.quintoandar.com.br/research/estudo_microapartamento.pdf

family_size <- tibble::tribble(
  ~year , ~value , ~group               ,
   1991 , 4.2    , "Brasil"             ,
   1991 , 4.0    , "Principais cidades" ,
   2000 , 3.8    , "Brasil"             ,
   2000 , 3.6    , "Principais cidades" ,
   2010 , 3.3    , "Brasil"             ,
   2010 , 3.2    , "Principais cidades" ,
   2020 , 2.9    , "Brasil"             ,
   2020 , 2.8    , "Principais cidades"
)

pal_family <- c(benvi_palette("benvi_blue")[4], benvi_palette("purples")[3])

p_col_label <- ggplot(
  family_size,
  aes(as.factor(year), value, fill = group, group = group)
) +
  geom_col(position = position_dodge(width = 0.95), key_glyph = "point") +
  geom_text(
    aes(y = 0.5, label = value, color = group),
    position = position_dodge(width = 0.95),
    size = 3,
    family = "Poppins",
    show.legend = FALSE
  ) +
  geom_hline(yintercept = 4.9, color = "#e2e2e2") +
  scale_x_discrete(expand = expansion(0.25)) +
  scale_y_continuous(breaks = 0:4, limits = c(0, 5)) +
  scale_fill_manual(values = pal_family) +
  # Label color follows fill: white on the darker bar, black on the lighter one
  scale_color_manual(values = c("#ffffff", "#000000")) +
  guides(fill = guide_legend(override.aes = list(shape = 21, size = 4))) +
  labs(
    title = "Diminuição do tamanho das famílias",
    subtitle = "Número médio de moradores por domicílio ao longo dos anos no Brasil e nas principais cidades",
    y = "Tamanho médio da família",
    x = NULL,
    fill = NULL
  ) +
  theme_benvi("Poppins", background = TRUE) +
  theme_sub_panel(
    grid.major.x = element_blank()
  ) +
  theme_sub_plot(
    title = element_text(size = 18, face = "bold"),
    subtitle = element_text(size = 9, color = "#000000"),
    title.position = "plot"
  ) +
  theme_sub_axis(
    title = element_text(size = 9)
  ) +
  theme_sub_legend(
    position = "inside",
    direction = "horizontal",
    position.inside = c(0.77, 0.88)
  )

ggsave_benvi(
  "man/figures/plot_replicating_1.png",
  p_col_label,
  width = 7,
  height = 4
)

# Pricing factors ----------------------------------------------------------

# Source: https://publicfiles.data.quintoandar.com.br/research/pesquisa_precificacao_datafolha.pdf

pricing_factors <- tibble::tribble(
  ~label                                  , ~y   ,
  "Estado de conservação"                 , 0.68 ,
  "Localidade próxima a serviços"         , 0.65 ,
  "Quantidade de cômodos"                 , 0.62 ,
  "Tamanho do imóvel em metros quadrados" , 0.61 ,
  "Idade do imóvel"                       , 0.38 ,
  "Áreas de lazer"                        , 0.37 ,
  "Posição do imóvel"                     , 0.34 ,
  "Em qual andar o imóvel está"           , 0.29 ,
  "Mobília"                               , 0.26
)

pricing_factors <- pricing_factors |>
  mutate(
    label = forcats::fct_reorder(label, y),
    # Full-width background bar drawn behind each value bar
    ylim = 1
  )

# Boundary between the two side ribbons. Bars are sorted ascending, so the
# five below this row are under 50% and the four above it are over.
split_row <- 5

p_col_void <- ggplot(pricing_factors, aes(y, label)) +
  geom_col(width = 1, fill = benvi_palette("qual_benvi")[6]) +
  geom_col(
    aes(ylim, label),
    width = 1,
    fill = NA,
    color = "#000000",
    lwd = 0.2
  ) +
  geom_text(
    aes(
      x = 0.05,
      label = scales::number(y, accuracy = 1, scale = 100, suffix = "%")
    ),
    family = "Poppins",
    fontface = "bold",
    size = 6,
    color = benvi_palette("benvi_blue")[1],
    hjust = 0
  ) +
  geom_text(
    aes(x = 0.2, label = label),
    family = "Poppins",
    size = 2.5,
    color = benvi_palette("benvi_blue")[1],
    hjust = 0
  ) +
  # Right-hand ribbon: bottom half ("Menos da metade")
  geom_rect(
    data = tibble(xmin = 0.95, xmax = 1, ymin = 0.5, ymax = split_row),
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = benvi_palette("qual_benvi")[6],
    inherit.aes = FALSE
  ) +
  annotate(
    "label",
    x = 0.98,
    y = (split_row - 0.5) / 2 + 0.5,
    label = "Menos da metade",
    family = "Poppins",
    size = 2.5,
    angle = 270,
    color = "#000000",
    fill = benvi_palette("qual_benvi")[6],
    border.color = NA
  ) +
  # Right-hand ribbon: top half ("Mais da metade")
  geom_rect(
    data = tibble(xmin = 0.95, xmax = 1, ymin = split_row, ymax = 9.5),
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = benvi_palette("qual_benvi")[4],
    inherit.aes = FALSE
  ) +
  annotate(
    "label",
    x = 0.98,
    y = (9.5 - split_row) / 2 + split_row,
    label = "Mais da metade",
    family = "Poppins",
    size = 2.5,
    angle = 270,
    color = "#ffffff",
    fill = benvi_palette("qual_benvi")[4],
    border.color = NA
  ) +
  scale_x_continuous(limits = c(0, 1)) +
  theme_benvi(background = TRUE) +
  theme_sub_plot(margin = margin(20, 10, 20, 10)) +
  theme_sub_panel(
    grid.major = element_blank()
  ) +
  theme_sub_axis(
    title = element_blank(),
    text = element_blank()
  )

ggsave_benvi(
  "man/figures/plot_replicating_2.png",
  p_col_void,
  width = 5,
  height = 4
)

# World Cup activities -----------------------------------------------------

# Source: https://publicfiles.data.quintoandar.com.br/research/pesquisa_copa_do_mundo.pdf

worldcup <- tibble::tribble(
  ~label                                          , ~share ,
  "Assistir aos jogos juntos na casa de alguém"   , 0.51   ,
  "Gritar e comemorar na janela os gols"          , 0.39   ,
  "Assistir aos jogos juntos num bar/restaurante" , 0.33   ,
  "Se reunir depois dos jogos"                    , 0.30   ,
  "Pintar ruas e calçadas com a temática da copa" , 0.27   ,
  "Assistir aos jogos juntos na rua/praça"        , 0.24   ,
  # Both rows report 24%; the nudge keeps the report's ordering after sorting
  "Colocar bandeirinhas com a temática da copa"   , 0.2399
)

worldcup <- worldcup |>
  mutate(
    share_label = scales::number(
      share,
      accuracy = 1,
      scale = 100,
      suffix = "%"
    ),
    label = forcats::fct_reorder(label, share)
  )

p_col_void_2 <- ggplot(worldcup, aes(share, label)) +
  geom_col(width = 1, fill = benvi_palette("rio_qual")[4]) +
  geom_col(aes(x = 1), width = 1, fill = NA, color = "#000000", lwd = 0.2) +
  geom_text(
    aes(x = 0.04, label = label),
    family = "Poppins",
    size = 5,
    hjust = 0
  ) +
  geom_text(
    aes(x = 0.9, label = share_label),
    hjust = 0,
    family = "Poppins",
    fontface = "bold",
    size = 5
  ) +
  scale_x_continuous(limits = c(0, 1)) +
  labs(
    title = "E as <b>principais atividades</b> feitas com os moradores do<br>mesmo bairro são:"
  ) +
  theme_benvi(background = TRUE) +
  theme_sub_plot(
    title = element_markdown(
      size = 16,
      family = "Poppins",
      margin = margin(10, 10, 20, 50)
    )
  ) +
  theme_sub_panel(grid.major = element_blank()) +
  theme_sub_axis(
    title = element_blank(),
    text = element_blank()
  )

ggsave_benvi(
  "man/figures/plot_replicating_3.png",
  p_col_void_2,
  width = 8,
  height = 5
)

# Satisfaction by generation -----------------------------------------------

# Source: https://publicfiles.data.quintoandar.com.br/research/pesquisa_ipsos_retratos_do_morar.pdf

title_generations <- paste0(
  "Os <span style='color:#3bc7de;'><b>baby boomers são os mais felizes ",
  "com o<br>local onde vivem</b></span>, mas essa satisfação ",
  "diminui<br>progressivamente nas gerações mais novas:"
)

generations <- tibble::tribble(
  ~generation    , ~share ,
  "Baby Boomers" , 0.78   ,
  "Geração X"    , 0.74   ,
  "Millennials"  , 0.69   ,
  "Geração Z"    , 0.66
)

generations <- generations |>
  mutate(
    generation = forcats::fct_reorder(generation, share)
  )

benvi_cinza <- benvi_palette("seq_grays")

p_col_benvi <- ggplot(generations, aes(share, generation)) +
  geom_col(fill = benvi_palette("blues")[2], width = 1) +
  geom_col(
    aes(x = 1),
    width = 1,
    fill = NA,
    color = benvi_palette("benvi_blue")[8],
    lwd = 0.5
  ) +
  geom_text(
    aes(x = 0.075, label = scales::percent(share, accuracy = 1)),
    family = "Poppins",
    size = 10,
    color = benvi_cinza[6]
  ) +
  geom_text(
    aes(x = 0.15, label = generation),
    family = "Poppins",
    size = 7,
    color = benvi_cinza[6],
    hjust = 0
  ) +
  scale_x_continuous(limits = c(0, 1), expand = expansion(0)) +
  labs(
    title = title_generations,
    x = NULL,
    y = NULL
  ) +
  theme_benvi() +
  theme_sub_plot(
    title = ggtext::element_textbox(
      color = benvi_cinza[8],
      size = 18,
      padding = margin(10, 10, 30, 30)
    ),
    background = element_rect(
      fill = benvi_palette("benvi_blue")[1],
      color = NA
    )
  ) +
  theme_sub_panel(
    grid.major = element_blank(),
    background = element_rect(fill = benvi_palette("benvi_blue")[1], color = NA)
  ) +
  theme_sub_axis(text = element_blank())

ggsave_benvi(
  "man/figures/plot_replicating_4.png",
  p_col_benvi,
  width = 8,
  height = 5
)

# Living alone vs GDP ------------------------------------------------------

# Source: https://publicfiles.data.quintoandar.com.br/research/estudo_microapartamento.pdf
# Data: Our World in Data (requires an internet connection)

households <- readr::read_csv(
  "https://ourworldindata.org/grapher/one-person-households-vs-gdp-per-capita.csv?v=1&csvType=full&useColumnShortNames=true"
)

households <- households |>
  rename(
    gdppercap = ny_gdp_pcap_pp_kd,
    pop = population_historical,
    share = share_of_one_person_households
  ) |>
  arrange(year)

# For each country keep only the most recent complete observation
latest <- households |>
  filter_out(if_any(c(gdppercap, pop, share), is.na)) |>
  group_by(entity) |>
  slice_tail() |>
  ungroup()

latest <- latest |>
  mutate(
    region = countrycode::countrycode(entity, "country.name", "region"),
    region = case_when(
      region %in% c("Latin America & Caribbean", "North America") ~ "Américas",
      region %in% c("East Asia & Pacific", "South Asia") ~ "Ásia",
      region %in%
        c(
          "Sub-Saharan Africa",
          "Middle East & North Africa"
        ) ~ "África e Oriente Médio",
      region == "Europe & Central Asia" ~ "Europa e Ásia Central",
      .default = NA_character_
    )
  )

# Named vector maps the English source names to Portuguese display labels
highlight_countries <- c(
  "Brasil" = "Brazil",
  "México" = "Mexico",
  "EUA" = "United States",
  "Rússia" = "Russia",
  "Japão" = "Japan",
  "Alemanha" = "Germany",
  "Turquia" = "Turkey",
  "Luxemburgo" = "Luxembourg",
  "Noruega" = "Norway",
  "França" = "France",
  "Guatemala" = "Guatemala",
  "Tanzânia" = "Tanzania",
  "Lesoto" = "Lesotho",
  "Quênia" = "Kenya",
  "Bulgária" = "Bulgaria",
  "Argentina" = "Argentina"
)

latest <- latest |>
  mutate(
    text_highlight = if_else(entity %in% highlight_countries, entity, ""),
    text_highlight = replace_values(
      text_highlight,
      from = highlight_countries,
      to = names(highlight_countries)
    )
  )

pal_region <- c(
  benvi_palette("yellows")[2],
  benvi_palette("greens")[2],
  benvi_palette("blues")[2],
  benvi_palette("purples")[2]
)

p_scatter <- ggplot(latest, aes(log(gdppercap), share)) +
  geom_point(aes(color = region, size = sqrt(pop))) +
  ggrepel::geom_text_repel(
    aes(label = text_highlight),
    size = 4,
    force = 10,
    box.padding = 0.5,
    min.segment.length = 0,
    max.overlaps = Inf,
    family = "Poppins"
  ) +
  # Redraw highlighted countries with an outline so labels are easy to trace
  geom_point(
    data = subset(latest, text_highlight != ""),
    aes(fill = region, size = sqrt(pop)),
    shape = 21
  ) +
  scale_x_continuous(
    breaks = log(c(1, 5, 10, 20, 50, 100) * 1e3),
    # Brazilian convention: period as thousands separator, comma as decimal
    labels = scales::number(
      c(1, 5, 10, 20, 50, 100) * 1e3,
      big.mark = ".",
      decimal.mark = ","
    )
  ) +
  scale_color_manual(name = NULL, values = pal_region) +
  scale_fill_manual(name = NULL, values = pal_region) +
  scale_size(range = c(1, 10)) +
  guides(
    size = "none",
    color = guide_legend(override.aes = list(size = 5))
  ) +
  labs(
    title = "Morando sozinho ao redor do mundo",
    x = "PIB per capita (US$ log)",
    y = "% de domicílios unipessoais",
    caption = "Fonte: Our World in Data, QuintoAndar"
  ) +
  theme_benvi(background = TRUE) +
  theme_sub_plot(title = element_text(size = 22)) +
  theme_sub_legend(
    text = element_text(size = 10),
    justification = "right"
  )

ggsave_benvi(
  "man/figures/plot_replicating_5.png",
  p_scatter,
  width = 9,
  height = 9 / 1.38
)

# Scratch: generalized share-column helper ---------------------------------

# Draft of a reusable version of the "World Cup activities" chart. Not wired up
# yet. Note the bug to fix before using it: the geom_text() call below passes
# `fontface = font_face`, which is never defined — it should be
# `font_face_number`.

# fancy_column_share <- function(
#   dat,
#   font_family = "Poppins",
#   font_size_label = 5,
#   font_size_number = 5,
#   number_bold = TRUE,
#   label_bold = FALSE,
#   fill = "#F2C037"
# ) {
#   font_face_label <- ifelse(label_bold, "bold", "plain")
#   font_face_number <- ifelse(number_bold, "bold", "plain")

#   p <- ggplot(dat, aes(share, label)) +
#     geom_col(width = 1, fill = fill) +
#     geom_col(aes(x = 1), width = 1, fill = NA, color = "#000000", lwd = 0.2) +
#     geom_text(
#       aes(x = 0.05, label = label),
#       family = font_family,
#       size = font_size_label,
#       hjust = 0
#     ) +
#     geom_text(
#       aes(x = 0.9, label = share_label),
#       hjust = 0,
#       family = font_family,
#       fontface = font_face,
#       size = font_size_number
#     ) +
#     scale_x_continuous(limits = c(0, 1)) +
#     theme_minimal() +
#     theme(
#       panel.grid.minor = element_blank(),
#       panel.grid.major = element_blank(),
#       axis.text = element_blank(),
#       axis.title = element_blank()
#     )

#   return(p)
# }
