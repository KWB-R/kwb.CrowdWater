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
#' @return
#' Either a numeric vector of the indicator points, or a description of the 
#' scoring system. This is a list of properties and categories which contribute
#' to the indicator.
#' 
#' @export
#' 
indicator_biotope <- function(
    df_cw, return_scoring_system = FALSE
){
  
  p1 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_SHORE_STATE", 
    categories = c("Natural", "Built-in"), 
    points = c(1, -1)
  )
  
  p2 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_DEADWOOD", 
    categories = c("Yes, a lot", "Yes, some"), 
    points = c(1, 0.5)
  )
  
  # for lake-Shore is "Built-In" the answer "" is interpreted as "No vegetation"
  # for all other shore states vegetation is expected and the answer "" 
  # is interpreted as "No answer"
  df_cw$LAKE_SHORE_VEGETATION[
    df_cw$LAKE_SHORE_STATE == "Built-in" & 
      df_cw$LAKE_SHORE_VEGETATION == "No answer"] <- "No vegetation"
  
  p3 <- assign_points_MC(
    df = df_cw, 
    property = "LAKE_SHORE_VEGETATION", 
    categories = c("Reed", "Trees", "Other", "Lawn", "No vegetation"), 
    points = c(1, 0.5, 0.5, -0.5, -1)
  )
  
  p4 <- assign_points_MC(
    df = df_cw, 
    property = "LAKE_ANIMALS", 
    categories = c("Waterfowl", "Fish", "Dragonflies", "Amphibians"), 
    points = c(0.5, 0.5, 1, 1)
  )
  
  p5 <- assign_points_SC(
    df = df_cw, 
    property = "FLOATING_LEAVE_PLANTS", 
    categories = c("Yes"), 
    points = c(1)
  )
  
  p6 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_PLANTS_UNDERWATER", 
    categories = c("Yes"), 
    points = c(1)
  )
  
  if(return_scoring_system){
    s_out <- lapply(list(p1, p2, p3, p4, p5, p6), function(x){
      x$scoring_system
    })
    s_out <- do.call(rbind, s_out)
    s_out <<- split(x = s_out, s_out$property)
    return(lapply(s_out, function(x){
      x[,c("categories", "points")]
    }))
  } else {
    valid_answers <- p1$valid_answer & p2$valid_answer & p3$valid_answer & 
      p4$valid_answer & p5$valid_answer & p6$valid_answer 
    
    indicator <- p1$points + p2$points + p3$points + p4$points + p5$points +
      p6$points
    indicator[!valid_answers] <- NA
    return(indicator)
  }
}