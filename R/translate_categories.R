#' From single observation to average site indicators
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param from Character string, defining the language of df_cw
#' @param to Character string, defining the language to translate in
#' 
#' @return
#' df_cw translated
#' 
#' @export
#' 
tranlsate_categories <- function(
    df_cw, from, to
){
  for(i in seq_along(props_and_cats)){
    property <- names(props_and_cats)[i]
    categories <- props_and_cats[[i]]
    catType <- unique(categories$type)
    catOrder <- all(!is.na(categories$order))
    df_cw[[property]] <- 
      if(catType == "multiple"){
        renameMultipleChoice(
          v = as.character(df_cw[[property]]), 
          oldNames = categories[[from]], 
          newNames = categories[[to]]
        )
      } else if(catType == "single"){
        renameSingleChoice(
          v = df_cw[[property]],
          oldNames = categories[[from]], 
          newNames = categories[[to]]
        )
      }
    if(catOrder){
      df_cw[[property]] <- factor(
        x = df_cw[[property]], 
        levels = categories[[to]][order(categories$order)], 
        ordered = TRUE)
    }
  }
  df_cw
}