# Getting Started with benviplot

## Introduction

`benviplot` provides color palettes and ggplot2 helper functions for
exploratory data analysis. The color schemes are based on Benvi, a brand
of the Brazilian proptech QuintoAndar[^1]. The package ships with a
custom ggplot2 theme, a family of discrete and continuous color scales,
and convenience wrappers for common chart types.

### Installation

``` r

# Install remotes if needed
install.packages("remotes")

remotes::install_github("viniciusoike/benviplot")
```

### Font Setup (Optional)

`benviplot` bundles the Poppins font family and registers it
automatically when the package loads (requires the `systemfonts`
package). When Poppins is registered,
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
uses it by default. Without `systemfonts`, the theme falls back to the
system sans-serif font.

For the best rendering quality with custom fonts, install the `ragg`
package. When `ragg` is set as the graphics device (the default in
RStudio and Positron), Poppins renders correctly in all output formats.

``` r

install.packages("ragg")
```

You can check your full font and device status at any time with:

``` r

font_status()
```

## Quick Start

``` r

library(ggplot2)
library(benviplot)
```

The core of the package is
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
combined with the `scale_*_benvi_*()` functions. Together, they give any
ggplot2 chart a consistent look with minimal effort. In the example
below,
[`scale_fill_benvi_d()`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md)
maps the discrete cylinder variable to the `"qual_8"` qualitative
palette, while
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
handles the rest of the styling.

``` r

ggplot(mtcars, aes(x = wt, y = mpg, fill = as.factor(cyl))) +
  geom_point(shape = 21, size = 3, color = "#000000") +
  scale_fill_benvi_d(name = "Cylinders", pal_name = "qual_8") +
  labs(
    title = "Fuel Efficiency vs. Weight",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon"
  ) +
  theme_benvi()
```

![](getting-started_files/figure-html/quick-scatter-1.png)

## Color Palettes

The package organizes its palettes into several families: theme,
sequential, qualitative, diverging, city-specific, and brand. Each
family serves a different purpose, and choosing the right one depends on
the nature of your variable.

### Browsing palettes

[`show_palettes()`](https://viniciusoike.github.io/benviplot/reference/show_palettes.md)
gives a visual overview of all available palettes. Calling it without
arguments displays every palette in the package; pass a type name to
narrow the output.

``` r

show_palettes()
```

You can filter by type: `"theme"`, `"sequential"`, `"qualitative"`,
`"diverging"`, `"city"`, or `"brand"`.

``` r

show_palettes("sequential")
```

![](getting-started_files/figure-html/show-seq-1.png)

### Accessing palette colors

[`benvi_palette()`](https://viniciusoike.github.io/benviplot/reference/benvi_palette.md)
returns a named vector of hex codes. Printing it renders a color swatch
in the console, which is useful for quick visual comparison.

``` r

# Preview a palette
benvi_palette("qual_2")
```

![](getting-started_files/figure-html/view-palettes-1.png)

To use the colors outside of ggplot2 (e.g. in base R or as input to
another package), coerce to a plain character vector.

``` r

# Get hex codes as a plain character vector
as.character(benvi_palette("benvi_blue"))
#>  [1] "#021841" "#192C50" "#2F405F" "#46546E" "#5D687D" "#737C8C" "#8A919C"
#>  [8] "#A0A5AB" "#B7B9BA" "#CECDC9"
```

Discrete palettes contain between 4 and 9 fixed colors. When you need
more granularity, set `type = "continuous"` to interpolate an arbitrary
number of colors along the palette gradient.

``` r

benvi_palette("seq_greens", n = 20, type = "continuous")
```

![](getting-started_files/figure-html/continuous-1.png)

## Using ggplot2 Scales

The scale functions follow the standard ggplot2 naming convention:
`scale_{aesthetic}_benvi_{d|c}()`, where `d` is for discrete variables
and `c` is for continuous ones. Both `color` and `fill` variants are
available, and `colour` spellings work as expected.

### Discrete scales

Discrete scales map categorical variables to a qualitative or
city-specific palette. The `pal_name` argument (or the first positional
argument) selects which palette to use.

``` r

iqaiw_total <- subset(iqaiw, rooms == "Total")

ggplot(iqaiw_total, aes(x = date, y = index, color = name_muni)) +
  geom_line(linewidth = 0.7) +
  geom_hline(yintercept = 100) +
  scale_color_benvi_d("rio_qual", name = NULL) +
  labs(
    title = "IQAIW Rental Index by City",
    x = NULL,
    y = "Index (base = 100)"
  ) +
  theme_benvi()
```

![](getting-started_files/figure-html/discrete-scale-1.png)

### Continuous scales

Continuous scales interpolate across a sequential or brand palette. They
are well suited for heatmaps, choropleths, and any visualization where a
numeric variable needs a smooth color gradient. Use `direction = -1` to
reverse the palette.

``` r

iqaiw_total <- subset(iqaiw_total, !is.na(acum12m))

ggplot(iqaiw_total, aes(x = date, y = name_muni, fill = acum12m * 100)) +
  geom_tile(height = 0.6, color = "#ffffff") +
  scale_fill_benvi_c(
    pal_name = "benvi_blue",
    name = "YoY Change (%)",
    direction = -1
  ) +
  scale_x_date(
    date_breaks = "1 year",
    date_labels = "%Y",
    expand = expansion(0)
  ) +
  labs(x = NULL, y = NULL) +
  theme_benvi() +
  theme(
    legend.title = element_text(hjust = 0.5, vjust = 0.75),
    axis.text = element_text(size = 12),
    panel.grid = element_blank()
  )
```

![](getting-started_files/figure-html/continuous-scale-1.png)

## Plot Helper Functions

`benviplot` includes convenience wrappers for common chart types. These
functions accept a data frame and column names via tidy evaluation,
apply
[`theme_benvi()`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md)
automatically, and return a standard `ggplot2` object. They are designed
for quick exploratory work; for publication-quality figures, building
the plot from scratch gives you full control.

### Line chart

[`plot_line()`](https://viniciusoike.github.io/benviplot/reference/plot_line.md)
draws a single-series line chart. Pass `color` to map a grouping
variable and get multiple lines with an automatic legend.

``` r

plot_line(economics, x = date, y = uempmed)
```

![](getting-started_files/figure-html/helper-line-1.png)

### Bar chart

[`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md)
creates a vertical bar chart. Setting `text = TRUE` adds value labels
above each bar; for bars with enough height, `text_inside = TRUE` places
labels inside the bars instead (requires the `ggfittext` package).

``` r

sales <- data.frame(
  cities = c(
    "São Paulo",
    "Rio de Janeiro",
    "Belo Horizonte",
    "Porto Alegre",
    "Curitiba"
  ),
  revenue = c(125, 200, 150, 175, 80)
)

plot_column(sales, x = cities, y = revenue, text = TRUE)
```

![](getting-started_files/figure-html/helper-column-1.png)

### Scatter plot

[`plot_scatter()`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md)
maps `x` and `y` to a scatter plot. A `color` argument maps a grouping
variable to the point color using a Benvi palette. Set `fit = TRUE` to
overlay a regression line.

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  color = as.factor(cyl),
  pal_name = "qual_5",
  scale_name = "Cylinders",
  fit = TRUE
)
```

![](getting-started_files/figure-html/helper-scatter-1.png)

### Adding layers

Because all helpers return `ggplot2` objects, you can extend them with
additional layers, scales, or theme adjustments as you normally would.

``` r

plot_line(economics, x = date, y = unemploy / 1000) +
  geom_smooth(se = FALSE, color = benvi_palette("oranges")[3]) +
  labs(
    title = "US Unemployment with Smoothed Trend",
    subtitle = "Unemployment figures in millions",
    x = NULL,
    y = "Unemployed (millions)",
    caption = "Data: economics dataset"
  )
```

![](getting-started_files/figure-html/customization-1.png)

## Base R

The palettes are not tied to ggplot2. Since
[`benvi_palette()`](https://viniciusoike.github.io/benviplot/reference/benvi_palette.md)
returns plain hex codes, you can use them anywhere that accepts color
strings, including base R graphics, `lattice`, or any other plotting
system.

``` r

colors <- as.character(benvi_palette("purples"))

plot(
  mtcars$wt,
  mtcars$mpg,
  col = colors[mtcars$cyl / 2 - 1],
  pch = 19,
  cex = 1.5,
  xlab = "Weight (1000 lbs)",
  ylab = "Miles per Gallon",
  main = "Using Benvi colors in base R"
)
```

![](getting-started_files/figure-html/base-r-1.png)

## Getting Help

- **Function documentation**:
  [`?benvi_palette`](https://viniciusoike.github.io/benviplot/reference/benvi_palette.md),
  [`?theme_benvi`](https://viniciusoike.github.io/benviplot/reference/theme_benvi.md),
  [`?scale_color_benvi_d`](https://viniciusoike.github.io/benviplot/reference/ggplot2-scales-discrete.md)
- **Package website**: <https://viniciusoike.github.io/benviplot/>
- **Report issues**: <https://github.com/viniciusoike/benviplot/issues>

[^1]: All color information used here is publicly available and this
    project is not affiliated with QuintoAndar.
