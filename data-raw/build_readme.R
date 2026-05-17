library(ggplot2)
library(benviplot)
library(dplyr)

index_data <- iqaiw |>
  filter(
    rooms %in% c("1", "2"),
    between(date, as.Date("2023-01-01"), as.Date("2025-12-31"))
  )

p1 <- ggplot(index_data, aes(date, index, color = rooms)) +
  geom_line(lwd = 0.7) +
  facet_wrap(vars(name_muni)) +
  scale_color_benvi_d() +
  labs(
    title = "IQAIW Rental Index by City",
    x = NULL,
    y = "Index (base = 100)",
    color = "Rooms",
    caption = "Source: IQAIW (benviplot)"
  ) +
  theme_benvi()

index_data <- iqaiw |>
  filter(
    rooms == "Total",
    between(date, as.Date("2023-01-01"), as.Date("2025-12-31"))
  ) |>
  mutate(xdate = lubridate::year(date) + (lubridate::month(date) - 1) / 12)

p2 <- ggplot(index_data, aes(x = xdate, y = name_muni, fill = acum12m * 100)) +
  geom_tile(height = 0.6, color = "gray90") +
  scale_fill_benvi_c(
    pal_name = "benvi_blue",
    name = "YoY Change (%)",
    direction = -1
  ) +
  scale_x_continuous(
    breaks = seq(2023, 2025, 1),
    expand = expansion(0)
  ) +
  labs(x = NULL, y = NULL) +
  theme_benvi() +
  theme(
    legend.title = element_text(hjust = 0.5, vjust = 0.75),
    axis.text = element_text(size = 12),
    panel.grid = element_blank()
  )

sales <- data.frame(
  x = factor(c(1, 2, 3, 4, 5, 6)),
  y = c(200, 220, 230, 210, 240, 290)
)

p3 <- plot_column(sales, x = x, y = y, text = TRUE)

ggsave(
  "man/figures/readme_plot_example_1.png",
  p1,
  width = 8,
  height = 5,
  dpi = 300
)

ggsave(
  "man/figures/readme_plot_example_2.png",
  p2,
  width = 6,
  height = 6 / 1.618,
  dpi = 300
)

ggsave(
  "man/figures/readme_plot_example_3.png",
  p3,
  width = 6,
  height = 6 / 1.618,
  dpi = 300
)
