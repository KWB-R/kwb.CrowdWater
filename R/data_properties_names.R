#' Regions Bounding Boxes
#' 
#' 
#' @format A named list of regions defined by bounding boxes. The bounding boxes
#' are  numeric vectors of coordinates which define the top, bottom, left, and 
#' right coordinates of the box.(in WGS84)
#' 
"bboxes"


#' List of CrowdWater Properties and Categories
#' 
#' @format A named list where list names correspond to the crowdwater properties
#' (column names of the table). For each property a data frame of categories is
#' given, which includes the translation into German or English, the order of 
#' categories if applicable (if not -> NA) and the type of answers
#' 
"props_and_cats"

#' Simple feature of the Berlin district boundaries
#' 
#' @format Besides the geometry, the Name of the district and its ID is given
#' 
"berlin_district_shp"


