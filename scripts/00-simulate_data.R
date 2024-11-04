#### Preamble ####
# Purpose: Simulates a dataset
# Author: Ruizi Liu, Yuechen Zhang, Bruce Zhang
# Date: 4 November 2024
# Contact: ruizi.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
# Load necessary libraries
library(tidyverse)

# Number of simulations
n <- 100

# Simulate poll data
set.seed(527)
simulated_data <- tibble(
  poll_id = 1:n,
  pollster = sample(c("YouGov", "Siena/NYT", "RMG Research", "Ipsos", "SurveyUSA"), n, replace = TRUE),
  numeric_grade = rnorm(n, mean = 3, sd = 0.5), # Simulate numeric_grade
  candidate_name = sample(c("Donald Trump", "Kamala Harris"), n, replace = TRUE),
  pct = round(rnorm(n, mean = 50, sd = 5), 1), # Simulate pct (percent votes)
  sample_size = sample(500:2000, n, replace = TRUE),
  end_date = sample(seq(as.Date('2024-07-15'), as.Date('2024-10-01'), by = "day"), n, replace = TRUE)
)

# View simulated data
head(simulated_data)


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")

