#### Preamble ####
# Purpose: Downloads and saves the data from fivethirtyeight
# Author: Ruizi Liu, Yuechen Zhang, Bruce Zhang
# Date: 4 November 2024
# Contact: ruizi.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download the data form fivethirtyeight first 
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

the_raw_data <- read_csv(here::here("data/01-raw_data/president_polls.csv"))

#### Save data ####
write_csv(the_raw_data, here::here("data/01-raw_data/raw_data.csv"))

         
