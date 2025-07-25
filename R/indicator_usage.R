#' Calculation of the CrowdWater Usage Indicator
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
indicator_usage <- function(
    df_cw, return_scoring_system = FALSE
){
  p1 <- assign_points_SC(
    df = df_cw, 
    property = "LAKE_ACCESS", 
    categories = c("Yes"), 
    points = c(2)
  )
  p2 <- assign_points_MC(
    df = df_cw, 
    property = "LAKE_USAGE", 
    categories = c("Bathing", "Dog bathing", "Activities on the shore",
                   "Water sports", "Fishing", "No visible usage"), 
    points = c(2, 1, 0.5, 1, 1, -1)
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
    valid_answers <- p1$valid_answer & p2$valid_answer 
    indicator <- p1$points + p2$points 
    # negative values appear in the combinantion "no lake acces" and 
    # "no visible usage" this combination is set to 0 instead of -1
    # The combinantion "lake acces" and "no visible usage" leads to 1
    indicator[indicator < 0] <- 0 
    indicator[!valid_answers] <- NA
    return(indicator)
  }
}