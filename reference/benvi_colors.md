# Get Benvi colors by name

Access individual Benvi colors by their names. When called without
arguments, returns all available color names.

## Usage

``` r
benvi_colors(color_names)
```

## Arguments

- color_names:

  Character vector of color names. If not provided, returns all
  available color names.

## Value

A character vector of hex color codes (when `color_names` is provided),
or a character vector of all available color names (when called without
arguments).

## Examples

``` r
# Get all available color names
benvi_colors()
#>  [1] "AzulQuinto"   "BrancoQuinto" "Preto"        "Concreto"     "CinzaQuente" 
#>  [6] "Creme"        "Branco"       "Chocolate"    "Ocre"         "Musgo"       
#> [11] "Noite"        "Ameixa"       "Cereja"       "Tijolo"       "Cafe"        
#> [16] "Manteiga"     "Floresta"     "Topazio"      "Violeta"      "Blush"       
#> [21] "Terracota"    "Amendoim"     "Lima"         "Primavera"    "Ciano"       
#> [26] "Quartzo"      "Rosa"         "Pessego"      "Trigo"        "Oliva"       
#> [31] "Petroleo"     "Lirio"        "Orquidea"     "Lavanda"      "Areia"       
#> [36] "Capri"       

# Get specific colors
benvi_colors("Floresta")
#> [1] "#009850"
benvi_colors(c("Floresta", "Violeta", "AzulQuinto"))
#> [1] "#009850" "#9A75B4" "#3957BD"
```
