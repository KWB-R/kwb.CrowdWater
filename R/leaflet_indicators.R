#' Create an interactive leaflet map which contains all the information of the
#' last observation
#' 
#' The leaflet map has two layers. 1) all the observered properties
#' 2) the corresponding image of that observation
#' 
#' @param cw_indicators Dataframe of the crowdwater indicators per lake created 
#' by [get_LakeIndicators()] 
#' @param language A character string, defining the language if the map
#' 
#' @return A leflet map
#' 
#' @export
#'
leaflet_indicator <- function(cw_indicators, language = "german") {
  if(language == "german"){
    groupNames <- 
      c("Indikator N\u00e4hrstoffe", "Indikator Biotop", "Indikator Nutzung", 
        "Indikator Wassermangel")
    legendNames <- 
      c("N\u00e4hrstoffe", "Biotopwert", "Nutzung", "Wassermangel")
  } else if(language == "english"){
    groupNames <- 
      c("Indicator Nutrients", "Indicator Biotope", "Indicator Usage", 
        "Indicator Water Stress")
    legendNames <- 
      c("Nutrients", "Biotope Value", "Usage", 
        "Water Stress")
  }
  
  # text that appears when klicking the circles
  popup_text <- 
    paste0(
      groupNames[1], ": ", round(cw_indicators$indicator_nutrients, 1),
      " (",cw_indicators$n_nutrients ,")", "<br>", 
      groupNames[2], ": ",  round(cw_indicators$indicator_biotope, 1),
      " (",cw_indicators$n_biotope ,")","<br>",
      groupNames[3], ": ", round(cw_indicators$indicator_usage, 1),
      " (",cw_indicators$n_usage ,")","<br>",
      groupNames[4], ": ", round(cw_indicators$indicator_waterstress, 1),
      " (",cw_indicators$n_waterstress ,")","<br>")
  
  # Nutrients
  pal_n <- indicators_to_colors(
    v_indicator = cw_indicators$indicator_nutrients, 
    v_worst = -6, v_neutral = 0, v_best = 4,
    col_worst = "#874503", col_neutral = "#EFF3FB", col_best = "#088CBD", 
    resolution_bad = 0.1, resolution_good = 0.1, resolution_legend = 1
  )
  l_n <- create_legend_labels(
    lv = pal_n$legend_table$values, 
    low_label = ifelse(language == "german", "Viel N\u00e4hrstoffe", "High nutrients"), 
    high_label = ifelse(language == "german", "Wenig N\u00e4hrstoffe", "Low nutrients"), 
    increase_bounds = TRUE)
  
  # biotope
  pal_b <- indicators_to_colors(
    v_indicator = cw_indicators$indicator_biotope, 
    v_worst = -1, v_neutral = 2, v_best = 8,
    col_worst = "#878787", col_neutral = "#EFF3FB", col_best = "#07A319", 
    resolution_bad = 0.1, resolution_good = 0.1, resolution_legend = 1
  )
  l_b <- create_legend_labels(
    lv = pal_b$legend_table$values, 
    high_label = ifelse(language == "german", "Hohes Biotoppotenzial", "High biotope potential"), 
    low_label = ifelse(language == "german", "Geringes Biotoppotenzial", "Low biotope potential"), 
    increase_bounds = TRUE)
  
  # usage
  pal_u <- indicators_to_colors(
    v_indicator = cw_indicators$indicator_usage, 
    v_worst = 0.5, v_neutral = 2.5, v_best = 6.5,
    col_worst = "#878787", col_neutral = "#EFF3FB", col_best = "#6B00A1", 
    resolution_bad = 0.1, resolution_good = 0.1, resolution_legend = 1
  )
  l_u <- create_legend_labels(
    lv = pal_u$legend_table$values, 
    high_label = ifelse(language == "german", "Hohe Nutzung", "High usage"), 
    low_label = ifelse(language == "german", "Geringe Nutzung", "Low usage"), 
    increase_bounds = TRUE)
  
  # Water stress
  pal_w <- indicators_to_colors(
    v_indicator = cw_indicators$indicator_waterstress, 
    v_worst = -6, v_neutral = 0, v_best = 6,
    col_worst = "#C70A0A", col_neutral = "#EFF3FB", col_best = "#07A319", 
    resolution_bad = 0.1, resolution_good = 0.1, resolution_legend = 2
  )
  l_w <- create_legend_labels(
    lv = pal_w$legend_table$values, 
    low_label = ifelse(language == "german", "Wassermangel", "Water stress"), 
    high_label = ifelse(language == "german", "Kein Wassermangel", "No water stress"), 
    increase_bounds = TRUE)
  
  
  
  bm <- base_map()
  
  indicator_maps <- bm %>%  
    leaflet::addLayersControl(
      baseGroups = groupNames,
      options = leaflet::layersControlOptions(collapsed = FALSE),
      position = "topleft"
    ) %>%
    # leaflet::addEasyButtonBar(
    #   position = "topright",
    #   leaflet::easyButton(
    #     icon = htmltools::span("Map 1", style = "font-weight: bold; font-size: 8px;"),
    #     title = "Aktuelle Beobachtungen",
    #     position = "topright",
    #     onClick = htmlwidgets::JS("function(btn, map){ window.open('https://ad4gd.kompetenz-wasser.io/seepatin/recent_properties_map.html', '_blank'); }")
    #   ),
    #   leaflet::easyButton(
    #     icon = htmltools::span("Map 2", style = "font-weight: bold; font-size: 8px;"),
    #     title = "Letzte Dateneingaben",
    #     position = "topright",
    #     onClick = htmlwidgets::JS("function(btn, map){ window.open('https://ad4gd.kompetenz-wasser.io/seepatin/last_observation_map.html', '_blank'); }")
    #   )
    # ) %>%
    leaflet::addCircleMarkers(
      data = cw_indicators,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = pal_n$color_vector, 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = popup_text,
      group = groupNames[1]
    ) %>%
    leaflet::addCircleMarkers(
      data = cw_indicators,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = pal_b$color_vector, 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = popup_text,
      group = groupNames[2]
    ) %>%
    leaflet::addCircleMarkers(
      data = cw_indicators,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = pal_u$color_vector, 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = popup_text,
      group = groupNames[3], 
    ) %>%
    leaflet::addCircleMarkers(
      data = cw_indicators,
      lng = ~LONGITUDE, lat = ~LATITUDE,
      fillColor = pal_w$color_vector, 
      fillOpacity = 1, color = "black", weight = 0.8, radius = 9,
      popup = popup_text,
      group = groupNames[4]
    )
  
  indicator_maps <- indicator_maps %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = pal_n$legend_table$color,
      labels = l_n,
      title = legendNames[1], 
      group = groupNames[1], 
      opacity = 1
    )  %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = pal_b$legend_table$color,
      labels = l_b,
      title = legendNames[2], 
      group = groupNames[2],
      opacity = 1) %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = pal_u$legend_table$color,
      labels = l_u,
      title = legendNames[3], 
      group = groupNames[3],
      opacity = 1) %>%
    leaflet::addLegend(
      position = "bottomright", 
      colors = pal_w$legend_table$color,
      labels = l_w,
      title = legendNames[4], 
      group = groupNames[4],
      opacity = 1)
  
  
  cw <- indicator_maps %>%
    #Legende transparent
    leaflet::addControl(
      html = "<style>
    .leaflet-control,
    .leaflet-control .legend {
      background-color: rgba(255,255,255,1) !important;
      padding: 6px;
      border: 2px solid #aaa;
      opacity: 1 !important;
      box-shadow: none !important;
    }
  </style>",
      position = 'topright'
    )
  
  layer_to_legend <- as.list(legendNames)
  names(layer_to_legend) <- groupNames
  
  # JavaScript: nur Legende des aktiven Layers anzeigen
  output_map <- htmlwidgets::onRender(
    x = cw,  
    jsCode = "
    function(el, x, data) {
      var legendDivs = document.querySelectorAll('.legend');
      
      var layerToLegend = data;
      
      function showLegend(layerName) {
      var legendName = layerToLegend[layerName]
        legendDivs.forEach(function(div) {
          if(legendName && div.innerHTML.includes(legendName)) {
            div.style.display = 'block';
          } else {
            div.style.display = 'none';
          }
        });
      }
      
      // initial view legend
      var defaultLayer = Object.keys(layerToLegend)[0]
      showLegend(defaultLayer);
      
      var map = window.HTMLWidgets.find('#' + el.id).getMap();

      this.on('baselayerchange', function(e) {
        showLegend(e.name);
      });
    }
  ", 
    data = layer_to_legend
  )
  
  output_map
}  
