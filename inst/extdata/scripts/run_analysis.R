library(kwb.CrowdWater)
library(leaflet)

# data path and crowdwater file
dp <- "Y:/iGB/Projects/AD4GD/Exchange/01_data"
file_path <- "01_input/crowdwater_app"
cw_files <- dir(file.path(dp, file_path), pattern = "crowdwater_spots_")
newest_file <- sort(cw_files, decreasing = TRUE)[1]

# load and prepare data
cw_data <- kwb.CrowdWater::prepare_data(
  path = file.path(dp, file_path), 
  file = newest_file, 
  region = "Berlin", 
  validated_only = TRUE, 
  language = "german")


# ------------------------------------------------------------------------------
