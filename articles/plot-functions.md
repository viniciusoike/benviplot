# Plot Helper Functions

``` r

library(ggplot2)
library(benviplot)
```

## Introduction

`benviplot` provides convenience functions for creating common chart
types. These functions simplify the plotting process while maintaining
full ggplot2 compatibility, making them perfect for:

- **Data exploration**: Quickly visualize patterns
- **Reports**: Reduce code repetition
- **Prototyping**: Test different visualizations rapidly

All plot functions return standard ggplot2 objects, so you can add
layers, modify themes, and customize freely.

## Common Parameters

Most plot functions share these parameters:

| Parameter | Description | Default |
|----|----|----|
| `data` | A data.frame or tibble | Required |
| `x` | Variable for x-axis | Required |
| `y` | Variable for y-axis | Required |
| `variable` | Grouping variable for colors | Optional |
| `palette` | Palette name (e.g., “qual_5”) | Function-specific |
| `scale_name` | Legend title | `""` |
| `scale_label` | Legend labels | [`waiver()`](https://ggplot2.tidyverse.org/reference/waiver.html) |
| `color` | Single color (when no grouping) | Auto |

## plot_line()

Create line charts for time series and trends.

### Basic Usage

``` r

# Simple line chart
plot_line(economics, x = date, y = unemploy)
```

![](plot-functions_files/figure-html/line-basic-1.png)

### Multiple Lines

``` r

# Filter for demonstration
library(dplyr)
housing_subset <- txhousing |>
  filter(city %in% c("Austin", "Houston", "Dallas"))

plot_line(
  housing_subset,
  x = date,
  y = sales,
  variable = city,
  palette = "purples",
  scale_name = "City"
)
```

![](plot-functions_files/figure-html/line-groups-1.png)

### With Points

``` r

# Sample data
monthly_sales <- data.frame(
  month = 1:12,
  revenue = c(120, 135, 145, 142, 158, 165, 170, 168, 175, 180, 190, 195)
)

plot_line(monthly_sales, x = month, y = revenue, point = TRUE)
```

![](plot-functions_files/figure-html/line-points-1.png)

### Key Parameters

- `point`: Add points on the line (`TRUE`/`FALSE`)
- `zero`: Draw y = 0 reference line (`TRUE`/`FALSE`)
- `color`: Custom color for single lines

## plot_column()

Create bar/column charts for categorical comparisons.

### Basic Bar Chart

``` r

# Sample data
products <- data.frame(
  product = c("A", "B", "C", "D", "E"),
  sales = c(120, 200, 150, 180, 220)
)

plot_column(products, x = product, y = sales)
```

![](plot-functions_files/figure-html/column-basic-1.png)

### With Value Labels

``` r

# Show values on bars
plot_column(products, x = product, y = sales, text = TRUE)
```

![](plot-functions_files/figure-html/column-text-1.png)

### Grouped Bars

``` r

# Data with groups
quarterly <- data.frame(
  quarter = rep(c("Q1", "Q2", "Q3", "Q4"), each = 3),
  region = rep(c("North", "South", "West"), 4),
  revenue = c(120, 130, 115, 145, 155, 140, 160, 165, 150, 175, 180, 170)
)

plot_column(
  quarterly,
  x = quarter,
  y = revenue,
  variable = region,
  palette = "greens",
  scale_name = "Region"
)
```

![](plot-functions_files/figure-html/column-groups-1.png)

### Key Parameters

- `text`: Show value labels on bars (`TRUE`/`FALSE`)
- `variable`: Create grouped/stacked bars
- `horizontal`: Flip to horizontal bars (`TRUE`/`FALSE`)

## plot_scatter()

Create scatter plots to visualize relationships between variables.

### Basic Scatter

``` r

plot_scatter(mtcars, x = wt, y = mpg)
```

![](plot-functions_files/figure-html/scatter-basic-1.png)

### With Groups

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  variable = as.factor(cyl),
  palette = "qual_5",
  scale_name = "Cylinders"
)
```

![](plot-functions_files/figure-html/scatter-groups-1.png)

### With Trend Line

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  fit = TRUE,
  fit_method = "lm"
)
```

![](plot-functions_files/figure-html/scatter-fit-1.png)

### Grouped Trend Lines

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  variable = as.factor(cyl),
  fit = TRUE,
  fit_variable = TRUE,
  fit_method = "lm",
  palette = "oranges",
  scale_name = "Cylinders"
)
```

![](plot-functions_files/figure-html/scatter-fit-groups-1.png)

### With Axis Lines

``` r

# Create sample data with negative values
scatter_data <- data.frame(
  x = rnorm(50, 0, 2),
  y = rnorm(50, 0, 2)
)

plot_scatter(scatter_data, x = x, y = y, zero = "both")
```

![](plot-functions_files/figure-html/scatter-axes-1.png)

### Key Parameters

- `fit`: Add trend line (`TRUE`/`FALSE`)
- `fit_method`: Method for trend line (`"lm"`, `"loess"`, `"auto"`)
- `fit_variable`: Separate trend lines per group (`TRUE`/`FALSE`)
- `fit_ci`: Show confidence interval (`TRUE`/`FALSE`)
- `zero`: Add axis lines (`"none"`, `"x"`, `"y"`, `"both"`)

## plot_area()

Create area charts for showing cumulative values or proportions.

### Basic Area Chart

``` r

# Economic data over time
plot_area(economics, x = date, y = unemploy / 1000) +
  labs(y = "Unemployed (millions)")
```

![](plot-functions_files/figure-html/area-basic-1.png)

### Stacked Area

``` r

# Sample data
time_series <- data.frame(
  year = rep(2010:2020, 3),
  category = rep(c("Product A", "Product B", "Product C"), each = 11),
  value = c(
    seq(100, 150, length.out = 11),
    seq(80, 120, length.out = 11),
    seq(60, 100, length.out = 11)
  )
)

plot_area(
  time_series,
  x = year,
  y = value,
  variable = category,
  palette = "seq_greens",
  scale_name = "Product"
)
```

![](plot-functions_files/figure-html/area-stacked-1.png)

### Key Parameters

- `variable`: Create stacked areas
- `palette`: Color palette for multiple areas

## plot_histogram()

Create histograms to visualize distributions.

### Basic Histogram

``` r

plot_histogram(mtcars, x = mpg)
```

![](plot-functions_files/figure-html/histogram-basic-1.png)

### With Custom Bins

``` r

plot_histogram(mtcars, x = mpg, bins = 15)
```

![](plot-functions_files/figure-html/histogram-bins-1.png)

### With Grouping

``` r

plot_histogram(
  mtcars,
  x = mpg,
  variable = as.factor(cyl),
  palette = "purples",
  scale_name = "Cylinders"
)
```

![](plot-functions_files/figure-html/histogram-groups-1.png)

### Different Binning Methods

``` r

# Using Freedman-Diaconis rule
plot_histogram(mtcars, x = mpg, bw = "fd") +
  labs(subtitle = "Freedman-Diaconis binwidth")
```

![](plot-functions_files/figure-html/histogram-bw-1.png)

### Key Parameters

- `bins`: Number of bins (integer)
- `bw`: Binwidth calculation method (`"sturges"`, `"fd"`, `"scott"`)
- `variable`: Group by category
- `position`: Histogram style (`"stack"`, `"dodge"`, `"identity"`)

## Advanced Examples

### Combining Multiple Layers

All plot functions return ggplot objects, so you can add layers:

``` r

plot_line(economics, x = date, y = unemploy / 1000) +
  geom_smooth(
    method = "loess",
    se = FALSE,
    color = benvi_palette("browns")[2],
    linewidth = 1.5
  ) +
  labs(
    title = "US Unemployment Over Time",
    subtitle = "With smoothed trend line",
    x = "Year",
    y = "Unemployed (millions)"
  )
```

![](plot-functions_files/figure-html/advanced-layers-1.png)

### Customizing Aesthetics

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  variable = as.factor(cyl),
  palette = "qual_7",
  scale_name = "Cylinders",
  size = 4,  # Passed to geom_point via ...
  alpha = 0.7
) +
  labs(
    title = "Fuel Efficiency Analysis",
    subtitle = "Custom size and transparency",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon"
  )
```

![](plot-functions_files/figure-html/advanced-custom-1.png)

### Faceting

``` r

plot_scatter(mtcars, x = wt, y = mpg) +
  facet_wrap(~ cyl, labeller = label_both) +
  labs(title = "MPG vs Weight by Cylinder Count")
```

![](plot-functions_files/figure-html/advanced-facet-1.png)

### Combining Helper Functions with Manual ggplot2

``` r

# Start with helper function, then customize extensively
plot_column(products, x = product, y = sales) +
  geom_hline(
    yintercept = mean(products$sales),
    linetype = "dashed",
    color = "gray40",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 1,
    y = mean(products$sales) + 10,
    label = "Average",
    hjust = 0,
    color = "gray40"
  ) +
  labs(
    title = "Product Sales vs Average",
    y = "Sales ($1000s)"
  )
```

![](plot-functions_files/figure-html/advanced-combo-1.png)

## When to Use Helper Functions vs. Pure ggplot2

### Use Helper Functions When:

- [x] Doing quick exploratory analysis
- [x] Creating standard charts repeatedly
- [x] Writing reports with consistent styling
- [x] Teaching/prototyping

### Use Pure ggplot2 When:

- [x] Creating complex, custom visualizations
- [x] Need precise control over every element
- [x] Building unique chart types
- [x] Combining multiple geometries in unusual ways

**Remember**: Helper functions are just shortcuts. You can always start
with a helper and customize with ggplot2 layers!

## Customization Examples

### Custom Colors Without `variable`

``` r

# Use specific benvi color
my_color <- benvi_palette("rio_qual")[3]

plot_line(economics, x = date, y = unemploy, color = my_color) +
  labs(title = "Custom Color Line Chart")
```

![](plot-functions_files/figure-html/custom-single-1.png)

### Custom Legend

``` r

plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  variable = as.factor(cyl),
  palette = "purples",
  scale_name = "Number of\nCylinders",
  scale_label = c("Four", "Six", "Eight")
) +
  theme(legend.position = "bottom")
```

![](plot-functions_files/figure-html/custom-legend-1.png)

### Adding Titles and Labels

``` r

plot_column(products, x = product, y = sales, text = TRUE) +
  labs(
    title = "Q4 Product Sales Performance",
    subtitle = "All regions combined",
    x = "Product Category",
    y = "Revenue ($1000s)",
    caption = "Source: Internal sales data"
  )
```

![](plot-functions_files/figure-html/custom-labels-1.png)

## Tips and Best Practices

### 1. Choose Appropriate Chart Types

- **Trends over time**:
  [`plot_line()`](https://viniciusoike.github.io/benviplot/reference/plot_line.md)
  or
  [`plot_area()`](https://viniciusoike.github.io/benviplot/reference/plot_area.md)
- **Comparing categories**:
  [`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md)
- **Relationships**:
  [`plot_scatter()`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md)
- **Distributions**:
  [`plot_histogram()`](https://viniciusoike.github.io/benviplot/reference/plot_histogram.md)

### 2. Limit Colors

When using `variable`, keep groups ≤ 7 for readability:

``` r

# Good: 3 groups
housing_few <- housing_subset |> filter(city %in% c("Austin", "Houston"))
plot_line(housing_few, x = date, y = sales, variable = city, palette = "yellows")
```

![](plot-functions_files/figure-html/tips-colors-1.png)

### 3. Use Appropriate Palettes

- **Categorical groups**: Use `Qual*` or `Set*` palettes
- **Sequential/ordered**: Use `Seq*` palettes

### 4. Always Label Your Axes

``` r

plot_scatter(mtcars, x = wt, y = mpg) +
  labs(
    x = "Vehicle Weight (1000 lbs)",
    y = "Fuel Efficiency (miles per gallon)"
  )
```

![](plot-functions_files/figure-html/tips-labels-1.png)

### 5. Consider Your Audience

- **Presentations**: Larger text, fewer details
- **Reports**: More annotations, context
- **Exploration**: Quick and simple

## Function Reference Summary

| Function | Best For | Key Feature |
|----|----|----|
| [`plot_line()`](https://viniciusoike.github.io/benviplot/reference/plot_line.md) | Time series, trends | `point` parameter |
| [`plot_column()`](https://viniciusoike.github.io/benviplot/reference/plot_column.md) | Category comparisons | `text` labels |
| [`plot_scatter()`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md) | Correlations | `fit` trend lines |
| [`plot_area()`](https://viniciusoike.github.io/benviplot/reference/plot_area.md) | Cumulative values | Stacked areas |
| [`plot_histogram()`](https://viniciusoike.github.io/benviplot/reference/plot_histogram.md) | Distributions | Multiple binning methods |

## Troubleshooting

### “Object not found” errors

Ensure you’re using unquoted column names:

``` r

# Correct
plot_line(data, x = date, y = value)

# Incorrect
plot_line(data, x = "date", y = "value")
```

### Colors not showing

When using `variable`, ensure it’s a factor or categorical:

``` r

# Convert numeric to factor
plot_scatter(
  mtcars,
  x = wt,
  y = mpg,
  variable = as.factor(cyl),  # Convert to factor!
  palette = "qual_3"
)
```

![](plot-functions_files/figure-html/troubleshoot-factor-1.png)

### Palette errors

Check that palette exists and has enough colors:

``` r

# View available colors
benvi_palette("qual_5")

# Ensure you don't exceed available colors for discrete palettes
```

## Summary

In this vignette you learned:

- [x] How to use all plot helper functions
- [x] Common parameters across functions
- [x] When to use helpers vs. pure ggplot2
- [x] How to customize and extend helper plots
- [x] Best practices for effective visualizations

## Next Steps

- See
  [`vignette("color-palettes")`](https://viniciusoike.github.io/benviplot/articles/color-palettes.md)
  for complete palette gallery
- See
  [`vignette("themes-and-styling")`](https://viniciusoike.github.io/benviplot/articles/themes-and-styling.md)
  for theme customization
- Explore individual function documentation:
  [`?plot_line`](https://viniciusoike.github.io/benviplot/reference/plot_line.md),
  [`?plot_scatter`](https://viniciusoike.github.io/benviplot/reference/plot_scatter.md),
  etc.

## Further Examples

For more visualization ideas and techniques:

- [R Graph Gallery](https://r-graph-gallery.com/)
- [ggplot2 Book](https://ggplot2-book.org/)
- [Data Visualization with R](https://rkabacoff.github.io/datavis/)
