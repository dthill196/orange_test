# Design a simple task for each county to test parallel processing in HTCondor
library(dplyr)

# Get command line argument
args <- commandArgs(trailingOnly = TRUE)

# Check if the county name is provided
if (length(args) == 0) {
  stop("No county name provided.")
}

# Extract county name
county_name <- args[1]

# Load data
dat <- readRDS('Rt_data_county.rds')
dat <- dat %>% mutate(county = ifelse(county == 'St Lawrence', 'St_Lawrence', county),
                      county = ifelse(county == 'New York', 'New_York', county))

# Filter data based on county name
dat_filtered <- dat %>% filter(county == county_name)
output_file <- paste0('result/', county_name, "_processed_data.rds")
saveRDS(object = dat_filtered, file = output_file)

