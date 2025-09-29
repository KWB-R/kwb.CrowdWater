#' Returnes only the latest observations per lake
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param includeNA Logical if NA (No answer) data should be included
#' 
#' @return A dataframe in the same shape as the lake properties dataframe with 
#' all historical observations removed
#' 
#' @export
#' 
site_category_percentage  <- function(
    df_cw, includeNA = FALSE)
{
  language <- identify_language(df_cw = df_cw)

  site_list <- split(x = df_cw, f = df_cw$ROOT_ID)
  site_data <- do.call(
    rbind, 
    lapply(site_list, function(x){
      x[1,c("ROOT_ID", "LATITUDE", "LONGITUDE")]
    })
  )

    
  prop_tables <- list()
  for(prop_i in names(props_and_cats)){
    prop_list <- lapply(
      X = site_list, 
      FUN = categories_sum, 
      property = prop_i, 
      language = language, 
      includeNA = includeNA
    )  
    x <- do.call(rbind, prop_list)
    y <- round(x / x[,ncol(x)] * 100, 0)
    prop_data <- cbind(y[,-ncol(y)], "n" = x[,"n"])
    prop_tables[[prop_i]] <- cbind(site_data, prop_data)
  }
  prop_tables
}
  
