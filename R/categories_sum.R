#' This function returns the sum of categories per property of the given 
#' dataframe
#' 
#' @param df Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()], optionally filtered for one ROOT_ID
#' @param property The property
#' @param includeNA Logical if NA (No answer) data should be included
#' @param language A character string, defining the language of df. If unknown
#' the function [identify_language()] can be used to find out.
#' 
#' @return A dataframe with the columns ROOT_ID, LATITUED, LONGITUDE and all 
#' the available categories per defined property. Besides the percentage of 
#' categories per site, the number of observations is given.
#' 
#' @export
#' 
categories_sum <- function(
    df, property, language = "english", includeNA = FALSE
){
  v <- df[[property]]
  p_df <- props_and_cats[[property]]
 
  keep_rows <- seq_along(v)
  n_cats <- nrow(p_df)
  catNames <- p_df[[language]]
  if(!includeNA){
    catNames <-  p_df[p_df$english != "No answer",language]
    keep_rows <-  which(!(v %in% p_df[p_df$english == "No answer",language]))
    n_cats <- n_cats - 1
  }
  
  output_matrix <- matrix(data = NA, nrow = 1, ncol = n_cats + 1)
  colnames(output_matrix) <- c(catNames, "n")
  
  n <- length(keep_rows)
  output_matrix[1, "n"] <- n
  if(n == 0L){
    return(output_matrix)
  } else {
    if(p_df$type[1] == "single"){
      for(cat_i in catNames){
        output_matrix[1, cat_i] <- sum(v[keep_rows] == cat_i) 
      }
    } else if(p_df$type[1] == "multiple"){
      for(cat_i in catNames){
        output_matrix[1, cat_i] <- length(grep(pattern = cat_i, x = v[keep_rows]))
      }
    }
    return(output_matrix)
  }
}
