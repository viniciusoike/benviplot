# ==============================================================================
# Official Hexagon Logo Generator for benviplot
# ==============================================================================
#
# This script generates the official package hexagon logo (logo_cropped.png).
# The logo features a treemap visualization showcasing various benvi color
# palettes arranged using fibonacci proportions.
#
# Requirements:
#   - ggplot2: For creating the treemap visualization
#   - treemapify: For geom_treemap functionality
#   - hexSticker: For generating the hexagonal sticker
#   - benviplot: The package itself (use devtools::load_all())
#   - showtext: For custom font rendering (Poppins)
#   - magick: For post-processing transparency effects
#
# Output:
#   - man/figures/logo_cropped.png (official package logo)
#
# Usage:
#   1. Ensure you're in the package root directory
#   2. Load the package: devtools::load_all()
#   3. Run this entire script
#   4. The logo will be saved to man/figures/logo_cropped.png
#
# ==============================================================================

# Load required packages
library(ggplot2)
library(treemapify)
library(hexSticker)
library(benviplot)
library(showtext)

# Setup fonts for high-quality rendering
font_add_google("Poppins", "Poppins")
showtext_opts(dpi = 300)
showtext_auto()

# Select colors from various benvi palettes to showcase diversity
colors_showcase <- c(
  benvi_palette("benvi_blue")[2],
  benvi_palette("rio_qual")[c(4)],
  benvi_palette("qual_2")[6],
  benvi_palette("spo_qual")[3],
  benvi_palette("qual_2")[1],
  benvi_palette("spo_qual")[7],
  benvi_palette("seq_oranges")[1]
)

# Create fibonacci-based proportions for treemap areas
# This creates visually pleasing relative sizes following the golden ratio
fib <- c(1, 1, 2, 3, 5, 8, 13, 21)
fib <- 1 / fib
fib <- fib[-1]

# Prepare treemap data
# Each color gets an area proportional to fibonacci values
treemap_data <- data.frame(
  area = fib[1:length(colors_showcase)],
  color_id = factor(1:length(colors_showcase)),
  fill_color = colors_showcase
)

# Create treemap visualization
# White borders separate color blocks for clarity
subplot <- ggplot(treemap_data, aes(area = area, fill = color_id)) +
  geom_treemap(color = "#FFFFFF", size = 2) +
  scale_fill_manual(values = colors_showcase) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.margin = margin(0, 0, 0, 0)
  )

# Generate light version of hexagon sticker
# White background with blue border following benvi brand colors
sticker(
  subplot = subplot,
  s_x = 1,
  s_y = 0.5,
  s_width = 1.1,
  s_height = 1.1,
  package = "Benviplot",
  p_x = 1,
  p_y = 1.45,
  p_color = "#000000",
  p_family = "Poppins",
  p_size = 5,
  h_fill = "#FFFFFF",
  h_color = "#3957BD",
  h_size = 0.5,
  filename = "man/figures/logo.png",
  dpi = 300,
  spotlight = FALSE,
  white_around_sticker = TRUE
)

# Generate dark version of hexagon sticker
# Blue background with black border for use on dark backgrounds
sticker(
  subplot = subplot,
  s_x = 1,
  s_y = 1,
  s_width = 2,
  s_height = 2,
  package = "Benviplot",
  p_x = 0.8,
  p_y = 1.45,
  p_color = "#000000",
  p_family = "Poppins",
  p_size = 5,
  h_fill = "#3957BD",
  h_color = "#000000",
  h_size = 1,
  filename = "man/figures/logo_dark.png",
  dpi = 300,
  white_around_sticker = TRUE
)

# Post-process dark version to add transparency
# The magick package removes white background by making it transparent
library(magick)

# Read the dark version
p <- image_read("man/figures/logo_dark.png")

# Apply transparency to white areas at each corner
# The fuzz parameter allows for slight color variations
# Each point targets a corner of the image
pp <- p %>%
  image_fill(
    color = "transparent",
    refcolor = "white",
    fuzz = 4,
    point = "+1+1"
  ) %>%
  image_fill(
    color = "transparent",
    refcolor = "white",
    fuzz = 4,
    point = "+517+1"
  ) %>%
  image_fill(
    color = "transparent",
    refcolor = "white",
    fuzz = 4,
    point = "+1+599"
  ) %>%
  image_fill(
    color = "transparent",
    refcolor = "white",
    fuzz = 4,
    point = "+517+599"
  )

# Save the final version as logo_cropped.png
# This is the official package logo
image_write(image = pp, path = "man/figures/logo_cropped.png")

# Display success message
message("✓ Hex logo created successfully!")
message("  - man/figures/logo_cropped.png (official package logo)")

# ==============================================================================
# Notes
# ==============================================================================
#
# Color Selection Strategy:
#   The logo showcases colors from multiple palette families:
#   - benvi_blue: Core brand color
#   - rio_qual, spo_qual: City-specific palettes
#   - qual_2: General qualitative palette
#   - seq_oranges: Sequential palette
#
# Fibonacci Proportions:
#   Using fibonacci-based ratios creates natural, aesthetically pleasing
#   proportions that follow the golden ratio principle.
#
# Transparency Processing:
#   The magick image processing makes the white background transparent,
#   allowing the hexagon to display properly on any background color.
#
# ==============================================================================
