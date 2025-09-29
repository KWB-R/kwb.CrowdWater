#' Function identifies the language based on category names
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' 
#' @return A character string of the language
#' 
#' @importFrom "utils" "head"
#' 
identify_language <- function(df_cw){
  cat_columns <- which(!grepl(
    pattern = "cw_output|^order$|^type$|^prop_", 
    x = colnames(props_and_cats[[1]])
  ))
  
  potential_languages <- length(cat_columns)
  i <- 0
  while(potential_languages > 1L){
    i <- i + 1
    if(i > length(props_and_cats))
      stop("No language identified. Check for correct spelling in CrowdWater dataframe")
    
    n_matches <- colSums(sapply(cat_columns, function(cc){
      head(df_cw[[names(props_and_cats)[i]]]) %in% 
        props_and_cats[[i]][,cc]
    }))
    
    potential_languages <- sum(n_matches > 1)
  }
  
  colnames(props_and_cats[[1]])[
    cat_columns[order(n_matches, decreasing = TRUE)[1]]
  ]
}