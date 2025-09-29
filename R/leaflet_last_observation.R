#' Create an interactive leaflet map which contains all the information of the
#' last observation
#' 
#' The leaflet map has two layers. 1) all the observered properties
#' 2) the corresponding image of that observation
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param language A character string, defining the language if the map
#' 
#' @return A leflet map
#' 
#' @importFrom "grDevices" "rgb"
#' @export
#' 
leaflet_last_observation_info <- function(df_cw, language = "german") {
  
  df_cw <- kwb.CrowdWater::tranlsate_categories(
    df_cw = df_cw, 
    from = "english", 
    to = language
  )
  df_cw$month <- format(df_cw$CREATED_AT, "%m")
  
  allColNames <- colnames(df_cw)
  colNames <- groupNames <- 
    allColNames[
      !(allColNames %in% 
          c("ROOT_ID", "CREATED_AT", "MODIFIED_AT", "DESCRIPTION", "CATEGORY", 
            "PHYSICAL_SCALE_UNIT", "PHYSICAL_SCALE_LEVEL", "LATITUDE", 
            "LONGITUDE", "IMAGE", "month"))
    ]
  
  for(property in groupNames){
    i_prop <- grep(pattern = property, x = names(props_and_cats))
    if(length(i_prop) > 0L){
      groupNames <- sub(
        pattern = property, 
        replacement = props_and_cats[[i_prop]][1, paste0("prop_", language)],
        x = groupNames)
    }
  }
  groupNames <- sub(
    pattern = "SPOTTED_AT", 
    replacement = ifelse(language == "german", "Datum", "Date"),
    x = groupNames)
  groupNames <- sub(
    pattern = "ID", 
    replacement = "CrowdWater ID",
    x = groupNames)
  
  # text that appears when clicking the circles
  popup_text <- c()
  for(i in seq_along(groupNames)){
    popup_text <-
      paste0(popup_text, 
             paste0(groupNames[i], ": ", df_cw[[colNames[i]]], "<br>")
      )
  }
  
  layerNames <- if(language == "german"){
    c("Daten", "Bilder")
  } else {
    c("Data", "Images")
  }
  
  legendNames <- if(language == "german"){
    c("Winter", "Fr\u00fchling", "Sommer", "Herbst")
  } else {
    c("Winter", "Spring", "Sommer", "Fall")
  }
  
  month_color_palette <- leaflet::colorFactor(
    palette = c(rgb(78,149,232,maxColorValue = 255), # Jan
                rgb(78,149,232,maxColorValue = 255), # Feb
                rgb(158,195,37,maxColorValue = 255), # Mar
                rgb(158,195,37,maxColorValue = 255), # Apr
                rgb(158,195,37,maxColorValue = 255), # May
                rgb(242,155,39,maxColorValue = 255),# Jun
                rgb(242,155,39,maxColorValue = 255), # Jul
                rgb(242,155,39,maxColorValue = 255), # Aug
                rgb(119,198,181,maxColorValue = 255), # Sep
                rgb(119,198,181,maxColorValue = 255), # Oct
                rgb(119,198,181,maxColorValue = 255), # Nov
                rgb(78,149,232,maxColorValue = 255)), # Dec
    domain = sort(unique(df_cw$month)))
  
  # create map
  bm <- base_map()
  observation_map <- bm %>% 
    leaflet::addLayersControl(
      baseGroups = layerNames,
      options = leaflet::layersControlOptions(collapsed = FALSE),
      position = "topleft"
    ) %>%
    leaflet::addCircleMarkers(
      data = df_cw,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = ~month_color_palette(month), 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = popup_text,
      group = layerNames[1]
    ) %>% 
    leaflet::addCircleMarkers(
      data = df_cw,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = ~month_color_palette(month), 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = ~paste0(
        "<img src = ", 
        IMAGE, 
        " width='300' style='display:block;margin:auto;height:auto' >"),
      group = layerNames[2]
    ) %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = c(rgb(78,149,232,maxColorValue = 255), 
                 rgb(158,195,37,maxColorValue = 255), 
                 rgb(242,155,39,maxColorValue = 255), 
                 rgb(119,198,181,maxColorValue = 255)),
      labels = legendNames,
      title = ifelse(language == "german", "Jahreszeit", "Season"), 
      opacity = 1)
  
  return(observation_map)
}

#' Create an interactive leaflet map which contains the days passed since the 
#' last observations 
#' 
#' 
#' @param df_cw Dataframe of the crowdwater lake properties prepared by 
#' [prepare_data()]
#' @param language A character string, defining the language if the map
#' 
#' @return A leaflet map
#' 
#' @importFrom "grDevices" "rgb"
#' @export
#' 
leaflet_last_observation_days <- function(df_cw, language = "german"){
  days_not_observed <- as.numeric(
    difftime(
      time1 = Sys.time(), 
      time2 = df_cw$SPOTTED_AT, 
      units = "days")
  )
  
  d_groups <- cut(x = days_not_observed, breaks = c(0,15, 61, 181, 366, Inf))
  group_colors <- c(
    rgb(21,91,0, maxColorValue = 255), # last 2 weeks
    rgb(188,201,0, maxColorValue = 255), # last 2 months,
    rgb(242,221,58, maxColorValue = 255), # last half year,
    rgb(224,88,0, maxColorValue = 255), # last year,
    rgb(204,22,0, maxColorValue = 255) # more than 1 years ago
  )
  
  group_names <- if(language == "german"){
    c("Zwei Wochen",  "Drei Monate", "Halbes Jahr", 
      "Ein Jahr", "L\u00e4nger als ein Jahr")
  } else {
    c("Two weeks",  "Three months", "Half a year", 
      "One year",  "More than a year")
  }
  
  d_pal <- leaflet::colorFactor(
    palette = group_colors, 
    levels = levels(d_groups)
  )
  
  bm <- base_map()
  observation_map <- bm %>% 
    leaflet::addCircleMarkers(
      data = df_cw,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = d_pal(d_groups), 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9
    ) %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = group_colors,
      labels = group_names,
      title = ifelse(language == "german", "Letzte Beobachtung", "Last observation"), 
      opacity = 1)
}
