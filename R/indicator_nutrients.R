#' Calculation of the CrowdWater Nutrient Indicator
#' 
#' The indicator is calculated per observation
#' 
#' 
#' @param df_cw Dataframe of the prepared crowdwater data
#' @param return_scoring_system If TRUE the scoring system is returned instead 
#' of the indicator vector. 
#' 
#' @return
#' Either a numeric vector of the indicator points, or a description of the 
#' scoring system. This is a list of properties and categories which contribute
#' to the indicator.
#' 
#' @export
#' 
indicator_nutrients <- function(
    df_cw, return_scoring_system = FALSE
){
  
  p1 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_SWIM", 
    categories = c("Yes"), 
    points = c(1)
  )
  
  p2 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_TRANSPARENCY", 
    categories = c("Deeper than 1 m", "20 \u002d 50  cm", "A few cm"), 
    points = c(1, -1, -2)
  )
  
  p3 <- assign_points_SC(
    df = df_cw, 
    property = "DUCKWEED", 
    categories = c("Completely covered", "Ca. 3\u002f4", "Ca. 1\u002f2", "Ca. 1\u002f4"), 
    points = c(-2, -1, -0.5, -0.25)
  )
  
  p4 <- assign_points_SC(
    df = df_cw, 
    property = "FLOATING_LEAVE_PLANTS", 
    categories = c("Yes"), 
    points = c(1),
    NA_answer = NULL
  )
  
  p5 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_PLANTS_UNDERWATER", 
    categories = c("Yes"), 
    points = c(1),
    NA_answer = NULL
  )
  
  p6 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_WATER_COLOUR", 
    categories = c("Clear", "Blue", "Green", "Brown"), 
    points = c(1, 1, -1, -1)
  )
  
  p7 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_SMELL", 
    categories = c("Rotten eggs", "Other sewage odor"), 
    points = c( -1, -2)
  )
  
  if(return_scoring_system){
    s_out <- lapply(list(p1, p2, p3, p4, p5, p6, p7), function(x){
      x$scoring_system
    })
    s_out <- do.call(rbind, s_out)
    s_out <<- split(x = s_out, s_out$property)
    return(lapply(s_out, function(x){
      x[,c("categories", "points")]
    }))
  } else {
    valid_answers <- p1$valid_answer & p2$valid_answer & p3$valid_answer & 
      p4$valid_answer & p5$valid_answer & p6$valid_answer & p7$valid_answer 
    
    indicator <- p1$points + p2$points + p3$points + p4$points + p5$points +
      p6$points + p7$points
    indicator[!valid_answers] <- NA
    return(indicator)
  }
}
