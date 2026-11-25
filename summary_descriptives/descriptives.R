
# Packages ----------------------------------------------------------------

library(tidyverse) # only one actually required, samplezoo is just for demo
library(samplezoo)


# Function ----------------------------------------------------------------

# This function helps make building the descriptive table for paper easier
# rather than input the mean, sd, min, and max seperately, this 
# function allows it to print all requested descriptives across a data frame
# and prints them out in a long df, which is a bit easier on the eyes


data_name_here |> 
  summarise(
    across( 
      .cols = c(),# column names, does not need "" ,
        .fns = c(, # this is used to describe the function within a list of the output (i.e., mean and sd)
          mean = function (x) mean(x, na.rm = TRUE), # you can add another base R function in here (e.g., a count)
          sd = function(x) sd(x, na.rm =TRUE),
          min = function(x) min(x, na.rm = TRUE),
          max = function(x) max(x, na.rm = TRUE)
        ),
        .names = '{.col} ---- {.fn}' # names that will appear in the row of the long data output, it prints the column and function associated (i.e., mean, sd, min, max)
      )
    ) |> 
      pivot_longer( # this is a nice pivot that keeps everything neat 
        cols = everything()
      )

## if curious... the . used above (i.e., .cols, .fns, .names) are just argument names from the across function, nothing special 
    

# Demo with {samplezoo} -----------------------------------------------------

set.seed(123)
data <- samplezoo("small") 


data |>  # plug in data
  summarise(
    across(
      .cols = c(norm, norm_2, norm_3), # add the columns we want from the data
      .fns = c( # our desired functions
        mean = function (x) mean(x, na.rm = TRUE),
        sd = function(x) sd(x, na.rm =TRUE),
        min = function(x) min(x, na.rm = TRUE),
        max = function(x) max(x, na.rm = TRUE)
      ),
      .names = '{.col} ---- {.fn}'  
    )
  ) |> 
  pivot_longer(
    cols = everything()
  ) 



# Output ------------------------------------------------------------------

# # A tibble: 12 × 2
# name             value
# <chr>            <dbl>
#   1 norm ---- mean   51.4 
# 2 norm ---- sd     13.7 
# 3 norm ---- min    15.4 
# 4 norm ---- max    82.8 
# 5 norm_2 ---- mean 58.9 
# 6 norm_2 ---- sd    9.67
# 7 norm_2 ---- min  39.5 
# 8 norm_2 ---- max  92.4 
# 9 norm_3 ---- mean 42.4 
# 10 norm_3 ---- sd   19.0 
# 11 norm_3 ---- min   4.87
# 12 norm_3 ---- max  85.9 


