#' Returnes only the latest observations per lake
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' 
#' @return A dataframe in the same shape as the lake properties dataframe with 
#' all historical observations removed
#' 
#' @export
#' 
latest_observations <- function(df_cw){
  site_list <- split(x = df_cw, f = df_cw$ROOT_ID)
  one_per_lake <- lapply(site_list, function(x){
    x[order(x$SPOTTED_AT, decreasing = TRUE)[1],]
  })
  do.call(rbind, one_per_lake)
}
