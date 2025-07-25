#' Calculation of the CrowdWater Biotope Indicator
#' 
#' The indicator is calculated per observation
#' 
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param return_scoring_system If TRUE the scoring system is returned instead 
#' of the indicator vector. 
#' 
#' @details
#' While most citizens are not able to tell if the lake experiences water stress
#' by the observation at one point of time, there might be citizens who know the
#' water body for a long time. The more observations include this information
#' the more certain it is. Some citizen may only know about water level changes
#' but cannot answer if the lake dries out. This is why in contrast to the other
#' indicators, the points are counted even if one question remains unknown or
#' unanswered. 
#' 
#' 
#' @return
#' Either a numeric vector of the indicator points, or a description of the 
#' scoring system. This is a list of properties and categories which contribute
#' to the indicator. 
#' 
#' @export
#' 
indicator_waterStress <- function(
    df_cw, return_scoring_system = FALSE
){
  
  p1 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_WATER_LEVEL", 
    categories = c("None", "Yes, small", "Yes, large"), 
    points = c(2, -0.5, -1), 
    NA_answers = c("No answer", "Unknown")
  )
  
  p2 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_DRIES_OUT", 
    categories = c("Yes", "No"), 
    points = c(-2, 1),
    NA_answers = c("No answer", "Unknown")
  )
  
  if(return_scoring_system){
    s_out <- lapply(list(p1, p2), function(x){
      x$scoring_system
    })
    s_out <- do.call(rbind, s_out)
    s_out <<- split(x = s_out, s_out$property)
    return(lapply(s_out, function(x){
      x[,c("categories", "points")]
    }))
  } else {
    valid_answers <- p1$valid_answer | p2$valid_answer # one valid answer is sufficient
    indicator <- p1$points + p2$points 
    indicator[!valid_answers] <- NA
    return(indicator)
  }
}
