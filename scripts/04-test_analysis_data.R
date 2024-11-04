#### Preamble ####
# Purpose: To perform data integrity, descriptive statistics, and data consistency tests on polling data.
# Author: Ruizi Liu, Yuechen Zhang, Bruce Zhang
# Date: 4 November 2024
# Contact: ruizi.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the files "02-download_data.R" and "03-clean_data.R".
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(dplyr)

data <- read_csv(here::here("data/02-analysis_data/analysis_data.csv"))

# Data Integrity Tests
# Check for missing values in each column
missing_values <- sapply(data, function(x) sum(is.na(x)))
print(missing_values)

# Verify data types (check if pct and pollscore are numeric)
is_pct_numeric <- is.numeric(data$pct)
is_pollscore_numeric <- is.numeric(data$pollscore)
print(is_pct_numeric)
print(is_pollscore_numeric)

# Descriptive Statistics Tests
# Check if pct is within the range 0 to 100
pct_range <- all(data$pct >= 0 & data$pct <= 100)
print(pct_range)

# Check reasonable range for pollscore (assuming -10 to 10)
pollscore_range <- all(data$pollscore >= -10 & data$pollscore <= 10)
print(pollscore_range)

# Check distribution of categorical variables state and methodology
state_distribution <- table(data$state)
methodology_distribution <- table(data$methodology)
print(state_distribution)
print(methodology_distribution)

# Data Consistency Tests
# Verify if start_date is earlier than end_date
# Convert dates to Date type
data$start_date <- as.Date(data$start_date, format="%m/%d/%y")
data$end_date <- as.Date(data$end_date, format="%Y-%m-%d")

# Check if start_date < end_date
date_consistency <- all(data$start_date <= data$end_date)
print(date_consistency)

# Unique Identifier Test (assuming there is a unique identifier column 'poll_id')
# is_unique <- nrow(data) == nrow(distinct(data, poll_id))
# print(is_unique)

