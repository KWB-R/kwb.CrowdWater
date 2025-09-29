#' the Basemap used for all leaflet maps
#' 
#' @param longitude Numeric value defining the longitude if WGS84
#' @param latitude Numeric value defining the latitude if WGS84
#' @param zoom The initial and minimum zoom level
#' @param berlin_districts Logical value if berlin districts should be added
#' 
#' @returns A leaflet map
#' 
#' @importFrom magrittr %>%
#' 
base_map <- function(
    longitude = 13.3987, latitude = 52.5048, zoom = 11, berlin_districts = TRUE
){
  map_out <- leaflet::leaflet() %>%
    leaflet::addTiles(options = leaflet::tileOptions(minZoom = zoom-1)) %>%
    leaflet.extras::addResetMapButton() %>%
    leaflet::setView(lng = longitude, lat = latitude, zoom = zoom) 
  if(berlin_districts){
    map_out <- map_out %>%
      leaflet::addPolygons(
        data = berlin_district_shp,
        fill = FALSE,
        color = "black",
        weight = 2,
        opacity = 0.4,
        group = "Bezirksgrenzen"
      )
  } 
  map_out
}

#' Transformation of numeric values into colors
#' 
#' @param v_indicator Numeric Vector of indicator data
#' @param v_worst Worst possible value
#' @param v_neutral Neutral value
#' @param v_best Best possible value
#' @param col_worst Color for worst value as hexadecimal string of the 
#' form "#rrggbb"
#' @param col_neutral Color for worst value as hexadecimal string of the 
#' form "#rrggbb"
#' @param col_best Color for worst value as hexadecimal string of the 
#' form "#rrggbb"
#' @param col_NA Color for NA values (Transparent by default)
#' @param resolution_bad the resolution between neutral and worst value
#' @param resolution_good The resolution between netral and best value
#' @param resolution_legend The resolution of the legend values
#' 
#' @return Vector of colors corresponding to the indicator values
#' 
#' @importFrom grDevices colorRampPalette
indicators_to_colors <- function(
    v_indicator, v_worst, v_neutral, v_best, 
    col_worst = "#E6550D", col_neutral = "#EFF3FB", col_best = "#08306B", 
    col_NA = "#00000000", resolution_bad = 0.1, resolution_good = 0.1, 
    resolution_legend = 1
){
  
  bad_values <- seq(from = v_worst, to = v_neutral, by = resolution_bad)
  good_values <- seq(from = v_neutral, to = v_best, by = resolution_good)
  
  bad_colors <- colorRampPalette(
    colors = c(col_worst, col_neutral))(length(bad_values))
  good_colors <- colorRampPalette(
    colors = c(col_neutral, col_best))(length(good_values))
  
  col_mapping <- data.frame("color" = c(NA, bad_colors, good_colors),
                            "values" = c(v_worst - 1, bad_values, good_values))
  
  col_mapping <- col_mapping[!duplicated(col_mapping),]
  
  legend_ticks <- seq(v_worst, v_best, by = resolution_legend)
  legend_table <- col_mapping[col_mapping$values %in% legend_ticks,]
  
  v_indicator[v_indicator < v_worst] <- v_worst
  v_indicator[v_indicator > v_best] <- v_best
  v_out <- as.character(cut(
    x = v_indicator, 
    breaks = col_mapping$values, 
    include.lowest = FALSE, labels = col_mapping$color[2:nrow(col_mapping)]
  ))
  v_out[is.na(v_out)] <- col_NA
  
  list("color_vector" = v_out,
       "color_mapping" = col_mapping,
       "legend_table" = legend_table)
}

#' Adds additional information to legend values
#' 
#' @param lv legend values as returned by [indicators_to_colors()] in the 
#' legend_table
#' @param low_label Additional lable for the lowest value
#' @param high_label Additional lable for the highest value
#' @param increase_bounds Add greater or equal / less or equal than sign to 
#' the highest /lowest legend value
#' 
#' @return extended legend labels
#' 
create_legend_labels <- function(
    lv, low_label = NULL, high_label = NULL, increase_bounds = TRUE
){
  if(increase_bounds){
    lv[1] <-paste0("\u2264 ", lv[1])
    lv[length(lv)] <- paste0("\u2265 ", lv[length(lv)])
  } 
  if(!is.null(low_label)){
    lv[1] <-paste0(lv[1], ": ", low_label)
  }
  if(!is.null(high_label)){
    lv[length(lv)] <- paste0(lv[length(lv)], ": ", high_label)
  }
  lv
}

#' Save a leaflet as html
#' 
#' By adding content to the html it is assured that icons are scaled according
#' to the device. In this way the map can be used by mobile devices.
#' 
#' @param x Leaflet object to be saved
#' @param file Filename including path
#' 
#' @export
#' 
save_leaflet <- function(x, file){
  x <- htmlwidgets::prependContent(
    x,
    htmltools::tags$head(
      htmltools::tags$meta(
        name = "viewport",
        content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
      )
    )
  )
  
  htmlwidgets::saveWidget(
    widget = x, 
    file = file, 
    selfcontained = TRUE
  )
}