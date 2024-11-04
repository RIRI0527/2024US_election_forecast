#### Preamble ####
# Purpose: To perform data integrity, descriptive statistics, and data consistency tests on the simulated polling data.
# Author: Ruizi Liu, Yuechen Zhang, Bruce Zhang
# Date: 4 November 2024
# Contact: ruizi.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Ensure the `dplyr` package is installed and loaded.
#                 The dataset (`simulated_data.csv`) should be available in the specified path.
#                 This script assumes columns for `poll_id`, `pct`, `pollscore`, `start_date`, `end_date`, `state`, `methodology`, and others are present.
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(dplyr)

# Read the data
data <- read_csv(here::here("data/00-simulated_data/simulated_data.csv"))


# Data Integrity Tests
# 1. Check for missing values in each column
missing_values <- sapply(data, function(x) sum(is.na(x)))
print(missing_values)

# 2. Check data types for important columns (e.g., `poll_id`, `pct`, `pollscore` should be numeric)
is_poll_id_numeric <- is.numeric(data$poll_id)
is_pct_numeric <- is.numeric(data$pct)
is_pollscore_numeric <- is.numeric(data$pollscore)
print(is_poll_id_numeric)
print(is_pct_numeric)
print(is_pollscore_numeric)

# Descriptive Statistics Tests
# 3. Check if pct is within 0 to 100 range
pct_range <- all(data$pct >= 0 & data$pct <= 100)
print(pct_range)

# 4. Check if pollscore is within a reasonable range, assuming between -10 and 10
pollscore_range <- all(!is.na(data$pollscore) & data$pollscore >= -10 & data$pollscore <= 10)
print(pollscore_range)

# 5. Check the distribution of categorical variables like `state` and `methodology`
state_distribution <- table(data$state)
methodology_distribution <- table(data$methodology)
print(state_distribution)
print(methodology_distribution)

# Data Consistency Tests
# 6. Verify if start_date is earlier than end_date
data$start_date <- as.Date(data$start_date, format="%Y-%m-%d")
data$end_date <- as.Date(data$end_date, format="%Y-%m-%d")
date_consistency <- all(data$start_date <= data$end_date)
print(date_consistency)

# 7. Verify that each `poll_id` is unique within each combination of `pollster_id` and `start_date`
unique_poll_id <- nrow(data) == nrow(distinct(data, poll_id, pollster_id, start_date))
print(unique_poll_id)

# 8. Check for valid sample sizes in `sample_size`, ensuring no negative values and reasonable range
sample_size_valid <- all(!is.na(data$sample_size) & data$sample_size > 0 & data$sample_size < 100000)
print(sample_size_valid)

