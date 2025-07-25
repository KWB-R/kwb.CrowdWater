#' Assign Points of Single choice answer
#' 
#' Used within the indicator functions
#' 
#' @param df Prepared CrowdWater data frame
#' @param property Character Value. One of the column names of df
#' @param categories Character vector that lists the catetories of the property
#' for which points are assigned
#' @param points Numeric vector of the same length and order of the categories
#' vector with the assigned points
#' @param NA_answers Character vector defining one or more answers that are 
#' treated as NA values
#' 
#' @return 
#' a list of 
#'  - points: Numeric vector of the category points\cr
#'  - valid_answer: Logical vector if all the required properties were observed\cr
#'  - scoring_system: The points assigned to the categories
#'  
assign_points_SC <- function(
    df, property, categories, points,  NA_answers = "No answer"
){
  v_out <- rep(0, nrow(df))
  for(i in seq_along(categories)){
    v_out[df[[property]] == categories[i]] <- points[i]
  }
  
  answered <- if(!is.null(NA_answers)){
    !(df[[property]] %in% NA_answers)
  } else {
    rep(TRUE, length(df[[property]]))
  }
  
  all_cats <- props_and_cats[[property]]$english
  not_mentioned_cats <- all_cats[
    !(all_cats %in% c(categories, NA_answers))
  ]
    
  list(
    "points" = v_out, 
    "valid_answer" = answered,
    "scoring_system" = data.frame(
      "property" = property,
      "categories" = c(
        categories, 
        not_mentioned_cats, 
        NA_answers),
      "points" = c(
        points, 
        rep(0, length(not_mentioned_cats)), 
        rep(NA, length(NA_answers))))
  )
}

#' Assign Points of Multiple choice answer
#' 
#' Used within the indicator functions
#' 
#' @param df Prepared CrowdWater data frame
#' @param property Character Value. One of the column names of df
#' @param categories Character vector that lists the catetories of the property
#' for which points are assigned
#' @param points Numeric vector of the same length and order of the categories
#' vector with the assigned points
#' @param NA_answers Character vector defining one or more answers that are 
#' treated as NA values
#' 
#' @return 
#' a list of 
#'  - points: Numeric vector of the category points\cr
#'  - valid_answer: Logical vector if all the required properties were observed\cr
#'  - scoring_system: The points assigned to the categories
#'  
assign_points_MC <- function(
    df, property, categories, points,  NA_answers = "No answer"
){
  v_out <- rep(0, nrow(df))
  for(i in seq_along(categories)){
    v_out <- v_out + ifelse(
      test = grepl(pattern = categories[i], x = df[[property]]), 
      yes = points[i], 
      no = 0)
  }
  
  answered <- if(!is.null(NA_answers)){
    !(df[[property]] %in% NA_answers)
  } else {
    rep(TRUE, length(df[[property]]))
  }
  
  all_cats <- props_and_cats[[property]]$english
  not_mentioned_cats <- all_cats[
    !(all_cats %in% c(categories, NA_answers))
  ]
  
  list(
    "points" = v_out, 
    "valid_answer" = answered,
    "scoring_system" = data.frame(
      "property" = property,
      "categories" = c(
        categories, 
        not_mentioned_cats, 
        NA_answers),
      "points" = c(
        points, 
        rep(0, length(not_mentioned_cats)), 
        rep(NA, length(NA_answers))))
  )
}

