# define internal data as global variables to avoid the note 
# "no visible binding for global variable" for internal data
utils::globalVariables(c("bboxes", "props_and_cats", "berlin_district_shp"))