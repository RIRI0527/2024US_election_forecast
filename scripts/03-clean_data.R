#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
# install.packages("arrow")
library(tidyverse)
library(arrow)
library(here)

#### Clean data ####
data <- read_csv(here::here("data/01-raw_data/raw_data.csv")) |>
  clean_names()

# Filter data to Trump estimates based on high-quality polls after she declared
just_trump_high_quality <- data |>
  dplyr::filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 3 # Need to investigate this choice - come back and fix. 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date)
  ) |>
  #######
  dplyr::filter(end_date >= as.Date("2024-07-15")) |> # When Trump declared
  mutate(
    num_trump = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )

cleaned_data <- just_trump_high_quality |>
  select(pct, start_date, end_date, state, methodology, pollster, pollscore) |>
  filter(!pollster %in% c("YouGov Blue", "YouGov/Center for Working Class Politics", "McCourtney Institute/YouGov"))

#### Save data ####
write_parquet(cleaned_data, here::here("data/02-analysis_data/analysis_data.parquet"))
write_csv(cleaned_data, here::here("data/02-analysis_data/analysis_data.csv"))

