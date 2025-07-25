#' From single observation to average site indicators
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param indicator_type A character defining the indicator. Either "nutrients"
#' "biotope", "usage" or "waterstress"
#' 
#' @return
#' A data frame of 5 columns (ROOT_ID, LATTITUDE, LONGITUDE and the indicator 
#' value and the number of observations)
#' 
#' @importFrom "stats" "aggregate"
#' @export
#' 
lake_indicator <- function(df_cw, indicator_type){
  if(indicator_type == "waterstress"){
    df_cw$waterstress <- indicator_waterStress(df_cw = df_cw)
    site_list <- split(x = df_cw, f = df_cw$ROOT_ID)
    
    df_agg <- as.data.frame(t(sapply(site_list, function(x){
      newest_on_top <- x[order(x$SPOTTED_AT, decreasing = TRUE),]
      v <- newest_on_top$waterstress[!is.na(newest_on_top$waterstress)]
      
      df_out <- data.frame(
        "ROOT_ID" = x$ROOT_ID[1],
        "LATTITUDE" = x$LATITUDE[1],
        "LONGITUDE" = x$LONGITUDE[1],
        "type" = indicator_type,
        "indicator" =  sum(v, na.rm = TRUE),
        "n" = sum(!is.na(v)))#
      if(df_out$n == 0L){
        df_out$indicator <- NA
      }
      df_out
    })))
    
  } else {
    v <- if(indicator_type == "nutrients"){
      indicator_nutrients(df_cw = df_cw)
    } else if(indicator_type == "biotope"){
      indicator_biotope(df_cw = df_cw)
    } else if(indicator_type == "usage"){
      indicator_usage(df_cw = df_cw)
    }
    df_out <- aggregate(
      x = v, 
      by = list(
        "ROOT_ID" = df_cw$ROOT_ID, 
        "LATTITUDE" = df_cw$LATITUDE, 
        "LONGITUDE" = df_cw$LONGITUDE
      ), 
      FUN = function(x){
        c("indicator" = mean(x, na.rm = TRUE),
          "n" = sum(!is.na(x)))
      } 
    )
    df_out$type <- indicator_type
    list_columns <- which(colnames(df_out) == "x")
    
    df_agg <- cbind(df_out[,-list_columns], df_out[[list_columns]])
  }
  df_agg
}

