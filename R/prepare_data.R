#' CrowdWater lake data preparation
#' 
#' The downloaded csv file is filtered for lake specific columns, for regions 
#' and for validated observations. The observed properties are named correctly
#' in English.
#' 
#' @param path The filepath 
#' @param file The filename including the ".csv" ending
#' @param region Either a character defining a region which is available in 
#' or a numeric vector of coordinates in WGS84 shaping a rectangle by "top", 
#' "bottom", "left" and "right" coordinate.
#' @param validated_only Logical if only checked observations are selected
#' 
#' @return
#' A list of two data frames. The first one contains data on the observered
#' proberties, the second data frame contains data of the phyiscale category.
#' 
#' @importFrom utils read.csv
#' 
#' @export
prepare_data <- function(
    path, file, region = NULL, validated_only = TRUE
){
  df <- read.csv(
    file = file.path(path, file), 
    sep = ";",
    header = TRUE)
  
  df <- df[df$PRESELECT_WATER_TYPE == "Lake",]
  
  if(!is.null(region)){
    bbox <- if(is.character(region)){
      bboxes[[region]]
    } else {
      names(region) <- c("top", "bottom", "left", "right")
      region
    }
    
    df <- df[
      df$LATITUDE >= bbox["bottom"] & df$LATITUDE <= bbox["top"] &
        df$LONGITUDE >= bbox["left"] & df$LONGITUDE <= bbox["right"],] 
  }

  
  if(validated_only){
    df <- df[df$STATE == "enabled",]
  }
  
  lake_cols <- c(
    "ID", "ROOT_ID", "LATITUDE", "LONGITUDE", "CREATED_AT", "MODIFIED_AT", 
    "SPOTTED_AT", "DESCRIPTION", "CATEGORY","PHYSICAL_SCALE_UNIT", 
    "PHYSICAL_SCALE_LEVEL", names(props_and_cats))
  
 if(any(!(lake_cols %in% colnames(df)))){
   missing <- lake_cols[!(lake_cols %in% colnames(df))]
   stop("Not all properties of the props_and_cats data are part of the",
        "crowdwater table. The following properties do not match: ",  
        paste(missing, sep = ", "))
 }
  
  df <- df[,lake_cols]
  
  tz <- "Etc/UTC" # Coordinated world time, check other timezones with OlsonNames()
  df$CREATED_AT <- as.POSIXct(df$CREATED_AT, tz = tz)
  df$MODIFIED_AT[df$MODIFIED_AT == ""] <- NA
  df$MODIFIED_AT <- as.POSIXct(df$MODIFIED_AT, tz = tz) 
  df$SPOTTED_AT <- as.POSIXct(df$SPOTTED_AT, tz = tz) 
  
  df_scale <- df[df$CATEGORY %in% c("physical scale"),]
  df_lake <- df[df$CATEGORY %in% c("standing water type"),]
  
  for(i in seq_along(props_and_cats)){
    property <- names(props_and_cats)[i]
    categories <- props_and_cats[[i]]
    catType <- unique(categories$type)
    catOrder <- all(!is.na(categories$order))
    df_lake[[property]] <- 
      if(catType == "multiple"){
        renameMultipleChoice(
          v = df_lake[[property]], 
          oldNames = categories$cw_output, 
          newNames = categories$english
        )
      } else if(catType == "single"){
        renameSingleChoice(
          v = df_lake[[property]],
          oldNames = categories$cw_output, 
          newNames = categories$english
        )
      }
    if(catOrder){
      df_lake[[property]] <- factor(
        x = df_lake[[property]], 
        levels = categories$english[order(categories$order)], 
        ordered = TRUE)
    }
  }
  
  list("lake_properties" = df_lake,
       "physical_scale" = df_scale)
}

#' Replaces multiple category names by new names
#' 
#' @param v Character vector of categories
#' @param oldNames Character vector listing the old names of the categories
#' @param newNames Characteri vector listing the new names of the categories in 
#' the same order as the oldNames vector
#' 
#' @return Character vector of renamed categories
#' 
renameSingleChoice <- function(v, oldNames, newNames){
  if(length(oldNames) != length(newNames)){
    stop("Category vectors do not match")
  }
  for(i in seq_along(oldNames)){
    v <- gsub(
      pattern = paste0("^", oldNames[i], "$"), 
      replacement = newNames[i], 
      x = v
    )
  }
  v
}

#' Replaces multiple separated category names by new names 
#' 
#' Multiple choice answers per observation are combined a one cell of the table
#' and seperated by a comma.
#' 
#' @param v Character vector of categories
#' @param oldNames Character vector listing the old names of the categories
#' @param newNames Characteri vector listing the new names of the categories in 
#' the same order as the oldNames vector
#' @param sep The seperator that is used in a cell between categories of the same
#' observation
#' 
#' @return Character vector of renamed categories
#'
renameMultipleChoice <- function(v, oldNames, newNames, sep = ", "){
  v_list <- strsplit(x = v, split = sep)
  v_list[sapply(v_list, length) == 0] <- ""
  v_list <- lapply(
    v_list, 
    renameSingleChoice, 
    oldNames = paste0("^",oldNames,"$"), 
    newNames = newNames
  )
  sapply(v_list, paste0, collapse = sep)
}
