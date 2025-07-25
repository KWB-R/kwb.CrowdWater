#' Calculate all indicators for all recorded lakes
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' 
#' @return A dataframe that contains columns of the root id, coordinates,
#' the indicator values and number of observations as well as the date of the
#' most recent observation
#' 
#' @export
#' 
get_LakeIndicators <- function(df_cw){
  indicator_list <- list()
  for(i_type in c("nutrients", "biotope", "usage", "waterstress")){
    indicator_list[[i_type]] <- 
      lake_indicator(df_cw = df_cw, indicator_type = i_type)
  }
  dd <- aggregate(
    x = df_cw$SPOTTED_AT, 
    by = list(
      "ROOT_ID" = df_cw$ROOT_ID, 
      "LATTITUDE" = df_cw$LATITUDE, 
      "LONGITUDE" = df_cw$LONGITUDE
    ), 
    FUN = max, 
    na.rm = TRUE
  )
  dd$type <- "date"
  colnames(dd)[colnames(dd) == "x"] <- "last_observation"
  indicator_list[["date"]] <- dd
  
  df_out <- Reduce(f = merge_LakeIndicators, x = indicator_list)
  df_out[, !grepl(pattern = "^type", x = colnames(df_out))]
}

#' Merge two lake indicator tables
#' 
#' @param x indicator table created by [lake_indicator()]
#' @param y indicator table created by [lake_indicator()]
#' 
#' @return merged table
#' 
merge_LakeIndicators <- function(x, y){
  xName <- paste0("_", x$type[1])
  yName <- paste0("_", y$type[1])
  # x2 <- subset(x = x, select = -type)
  # y2 <- subset(x = y, select = -type)
  merge(x = x, y = y, by = c("ROOT_ID", "LATTITUDE", "LONGITUDE"), all = TRUE, 
        suffixes = c(xName, yName))
}

