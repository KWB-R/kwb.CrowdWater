#' Add all the indicators to the lake properties table
#' 
#' @param df_cw Dataframe of the CrowdWater lake properties, prepared by 
#' [prepare_data()]
#' 
#' @return
#' df_cw extended by 4 indicator columns
#' 
#' @export
#' 
add_ObservationIndicators <- function(df_cw){
  df_cw$waterstress <- indicator_waterStress(df_cw = df_cw)
  df_cw$nutrients <- indicator_nutrients(df_cw = df_cw)
  df_cw$biotope <- indicator_biotope(df_cw = df_cw)
  df_cw$usage <- indicator_usage(df_cw = df_cw)
  df_cw
}