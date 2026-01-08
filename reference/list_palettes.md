# List available palette names

Returns a character vector of available palette names, optionally
filtered by type.

## Usage

``` r
list_palettes(type = "all")
```

## Arguments

- type:

  Character string specifying the palette type to filter. One of:

  - `"all"` (default): All palettes

  - `"theme"`: Theme palettes (grays, browns, yellows, etc.)

  - `"sequential"`: Sequential palettes (seq\_\*)

  - `"qualitative"`: Qualitative palettes (qual\_\*)

  - `"city"`: City-specific palettes (spo\_*, rio\_*, bhe\_\*)

  - `"brand"`: Brand palettes (basic, benvi_blue, benvi_purple)

## Value

A character vector of palette names.

## Examples

``` r
# List all palettes
list_palettes()
#>  [1] "grays"            "browns"           "yellows"          "greens"          
#>  [5] "blues"            "purples"          "pinks"            "oranges"         
#>  [9] "seq_grays"        "seq_browns"       "seq_yellows"      "seq_greens"      
#> [13] "seq_blues"        "seq_purples"      "seq_pinks"        "seq_oranges"     
#> [17] "qual_1"           "qual_2"           "qual_3"           "qual_4"          
#> [21] "qual_5"           "qual_6"           "qual_7"           "qual_8"          
#> [25] "qual_9"           "qual_benvi"       "spo_seq"          "spo_div"         
#> [29] "spo_qual"         "rio_seq"          "rio_div"          "rio_qual"        
#> [33] "bhe_seq"          "bhe_div"          "benvi_blue"       "benvi_purple"    
#> [37] "div_blue_muted"   "div_purple_muted" "basic"           

# List theme palettes
list_palettes("theme")
#> [1] "grays"   "browns"  "yellows" "greens"  "blues"   "purples" "pinks"  
#> [8] "oranges"

# List sequential palettes
list_palettes("sequential")
#> [1] "seq_grays"   "seq_browns"  "seq_yellows" "seq_greens"  "seq_blues"  
#> [6] "seq_purples" "seq_pinks"   "seq_oranges"
```
