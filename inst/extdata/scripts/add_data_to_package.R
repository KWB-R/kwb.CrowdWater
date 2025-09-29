# 1. write data and save as .rda file in the package/data folder
# (the filename should be the same as the variable name)

# 2. add the variable to the global variables of the package in the
# package/R/zzz.R file to avoid the note about missing global bindings by the 
# devtool check

# 3. Document the dataset in the file data_properties_names.R in the package/R
# folder
# NULL can be assigned to the documentation to avoid the devtools warning
# message "Variables with usage in documentation ... but not in code"

#  Bounding boxes

bboxes <- list(
  "Berlin" = c(
    "top" = 52.67669, 
    "bottom" = 52.33667, 
    "left" = 13.113694, 
    "right" = 13.75839
  )
) 
usethis::use_data(bboxes, overwrite = TRUE)



# Property and category Names
props_and_cats <- list(
  "LAKE_USAGE" = data.frame(
    "cw_output" = c("Bathing", "Dog bathing", "Activities on the shore", 
                    "Water sports", "Fishing", "No visible usage", "^$"), 
    "order" = NA,
    "type" = "multiple",
    "german" = c("Baden", "Hundebadestelle", "Aktivitäten am Ufer", 
                 "Wassersport", "Angeln", "Keine sichtbare Nutzung", 
                 "Keine Antwort"),
    "english" = c("Bathing", "Dog bathing", "Activities on the shore", 
                  "Water sports", "Fishing", "No visible usage", "No answer"),
    "prop_german" = "Gewässernutzung",
    "prop_english" = "Lake usage",
    "dist_german" = c("Nutzung als Badestelle", "Nutzung als Hundebadestelle", 
                      "Aktivitäten am Ufer", 
                      "Nutzung für Wassersport", 
                      "Angeln", NA, NA),
    "dist_english" = c("Bathing", "Dog bathing", "Activities on the shore", 
                       "Water sports", "Fishing", NA, NA)), 
  "LAKE_ACCESS" = data.frame(
    "cw_output" = c("yes", "nein", "^$"),
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer"),
    "prop_german" = "Zugänglichkeit",
    "prop_english" = "Accessibility",
    "dist_german" = c("Zugänglichkeit", NA, NA),
    "dist_english" = c("Accessibility", NA, NA)), 
  "LAKE_SHORE_STATE" = data.frame(
    "cw_output" = c("partly built-in", "built-in", "natural", "^$"), 
    "order" = c(2,3,1,4),
    "type" = "single",
    "german" = c("Teilverbaut", "Verbaut", "Natürlich", "Keine Antwort"),
    "english" = c("Partly built-in", "Built-in", "Natural", "No answer"),
    "prop_german" = "Uferbeschaffenheit",
    "prop_english" = "Lake shore state",
    "dist_german" = c("Ufer teilverbaut", "Ufer komplett verbaut", 
                      "Ufer natürlich", NA),
    "dist_english" = c("Lake shore partly built-in", 
                       "lake shore completely built-in", "lake shore natural",
                       NA)), 
  "LITTER_IN_WATER" = data.frame(
    "cw_output" = c("No litter", "Some litter, but not prominent", "^$", 
                    "Abundant litter"), 
    "order" = c(1,2,4,3),
    "type" = "single",
    "german" = c("Kein Abfall", "Etwas Abfall, aber nicht auffallend", 
                 "Keine Antwort", "Viel Abfall"),
    "english" =  c("No litter", "Some litter, but not prominent", "No answer", 
                   "Abundant litter"),
    "prop_german" = "Abfall",
    "prop_english" = "Litter",
    "dist_german" = c("Kein Abfall", NA, "Viel Abfall", NA),
    "dist_english" = c("No litter", NA, "Abundant litter", NA)),
  "LAKE_SWIM" = data.frame(
    "cw_output" = c("yes", "nein", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer"),
    "prop_german" = "Würde hier schwimmen",
    "prop_english" = "Would swimm here",
    "dist_german" = c("Ich würde schwimmen gehen", NA, NA),
    "dist_english" = c("I would not go swimming", NA, NA)),
  "LAKE_TRANSPARENCY" = data.frame(
    "cw_output" = c("20 – 50  cm", "50 cm – 1 m", "deeper than 1 m", 
                    "a few cm", "^$"), 
    "order" = c(2,3,4,1,5),
    "type" = "single",
    "german" = c("20 – 50  cm", "50 cm – 1 m", "Tiefer als 1 m", "Ein paar cm", 
                 "Keine Antwort"),
    "english" = c("20 – 50  cm", "50 cm – 1 m", "Deeper than 1 m", 
                  "A few cm", "No answer"),
    "prop_german" = "Sichttiefe",
    "prop_english" = "Visibility depth",
    "dist_german" = c(NA, NA, "Sichttiefe größer als 1 m", 
                      "Sichttiefe ein paar cm", NA),
    "dist_english" = c(NA, NA, "Visibility depth deeper than 1 m", 
                       "Visibility depth a few cm", NA)) ,
  "LAKE_WATER_COLOUR" = data.frame(
    "cw_output" = c("clear", "gray", "brown", "green", "Beige", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Klar","Grau", "Braun", "Grün", "Beige", "Keine Antwort"),
    "english" =  c("Clear", "Gray", "Brown", "Green", "Beige", "No answer"),
    "prop_german" = "Wasserfarbe",
    "prop_english" = "Water color",
    "dist_german" = c("Klares Wasser", NA, "Braunes Wasser", "Grünes Wasser", NA, NA),
    "dist_english" = c("Clear water", NA, "Brown water", "Green water", NA, NA)),
  "LAKE_SMELL" = data.frame(
    "cw_output" = c("No odor", "Other odor", "Fishy", "Musty", 
                    "Other sewage odor", "Rotten eggs", "^$"), 
    "order" = c(1, 6, 3, 2, 5, 4,7),
    "type" = "single",
    "german" = c("Kein Geruch", "Anderer deutlicher Geruch", "Fischig", "Modrig",
                 "Sonstiger Abwassergeruch", "Faule Eier", "Keine Antwort"),
    "english" = c("No odor", "Other odor", "Fishy", "Musty", 
                    "Other sewage odor", "Rotten eggs", "No answer"),
    "prop_german" = "Geruch",
    "prop_english" = "Smell",
    "dist_german" = c("Kein Geruch", NA, NA, "Modriger Geruch", "Abwassergeruch",
                      "Geruch nach faulen Eiern", NA),
    "dist_english" = c("No oder", NA, NA, "Musty odor", "Sewage odor", 
                       "Odor of rotten eggs", NA)),
  "LAKE_SHORE_VEGETATION" = data.frame(
    "cw_output" = c("Reed", "Trees", "Lawn", "Other", "^$"), 
    "order" = NA,
    "type" = "multiple",
    "german" = c("Schilf", "Bäume", "Rasen", "Sonstige", "Keine Antwort"),
    "english" = c("Reed", "Trees", "Lawn", "Other", "No answer"),
    "prop_german" = "Ufervegetation",
    "prop_english" = "Lake shore vegetation",
    "dist_german" = c("Schilf am Ufer", "Bäume am Ufer", "Rasen am Ufer", NA, NA),
    "dist_english" = c("Reed on the shoreline", "Trees on the shoreline", 
                       "Lawn on the shoreline", NA, NA)),
  "LAKE_PLANTS_UNDERWATER" = data.frame(
    "cw_output" = c("yes", "nein", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer"),
    "prop_german" = "Unterwasserpflanzen",
    "prop_english" = "Underwater plants",
    "dist_german" = c("Pflanzen Unterwasser", NA, NA),
    "dist_english" = c("Plants underwater", NA, NA)),
  "FLOATING_LEAVE_PLANTS" = data.frame(
    "cw_output" = c("yes", "Non", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer"),
    "prop_german" = "Schwimmblattpflanzen",
    "prop_english" = "Floating leave plants",
    "dist_german" = c("Schwimmblattpflanzen", NA, NA),
    "dist_english" = c("Floating leave plants", NA, NA)),
  "DUCKWEED" = data.frame(
    "cw_output" = c("ca 1/4", "zero", "ca half", "ca 3/4", "completely", "^$"), 
    "order" = c(2,1,3,4,5,6),
    "type" = "single",
    "german" = c("Einviertel", "Nichts", "Hälfte", "Dreiviertel", "Komplett", 
                 "Keine Antwort"),
    "english" = c("Ca. 1/4", "No duckweed", "Ca. 1/2", "Ca. 3/4", 
                  "Completely covered", "No answer"),
    "prop_german" = "Wasserlinsenbedeckung",
    "prop_english" = "Duckweed",
    "dist_german" = c("geringe Bedeckung mit Wasserlinsen", 
                      "Keine Wasserlinsen", NA, NA, 
                      "Komplette Bedeckung mit Wasserlinsen", NA),
    "dist_english" = c("Low duckweed coverage", "No Duckweed", NA, NA,
                       "Surface completely covered by duckweed", NA)),
  "LAKE_MUSSELS" = data.frame(
    "cw_output" = c("large mussels", "triangular mussels", "no mussels", 
                    "other mussles", "^$"), 
    "order" = NA,
    "type" = "multiple",
    "german" = c("Großmuscheln", "Dreikantmuscheln", "Keine Muscheln", 
                 "Sonstige Muscheln", "Keine Antwort"),
    "english" = c("Large mussels", "Triangular mussels", "No mussels", 
                  "Other mussles", "No answer"),
    "prop_german" = "Muscheln",
    "prop_english" = "Mussels",
    "dist_german" = c("Großmuscheln", "Dreikantmuscheln", NA, NA, NA),
    "dist_english"= c("Large mussels", "Triangular mussels", NA, NA, NA)),
  "LAKE_DEADWOOD" = data.frame(
    "cw_output" =  c("yes, some", "yes, a lot", "none", "^$"), 
    "order" = c(2, 3, 1, 4),
    "type" = "single",
    "german" = c("Ein bisschen", "Viel", "Keins", "Keine Antwort"),
    "english" = c("Yes, some", "Yes, a lot", "None", "No answer"),
    "prop_german" = "Totholz",
    "prop_english" = "Deadwood",
    "dist_german" = c(NA, "Viel Totholz", "Kein Totholz", NA),
    "dist_english" = c(NA, "A lot deadwood", "No deadwood", NA)),
  "LAKE_ANIMALS" = data.frame(
    "cw_output" = c("waterfowl", "fish", "no visible animals", "dragonflies", 
                    "amphibians", "^$"), 
    "type" = "multiple",
    "order" = NA,
    "german" = c("Wasservögel", "Fische", "Keine Tiere sichtbar", "Libellen", 
                 "Amphibien", "Keine Antwort"),
    "english" = c("Waterfowl", "Fish", "No visible animals", "Dragonflies", 
                  "Amphibians", "No answer"),
    "prop_german" = "Tiere am Gewässer",
    "prop_english" = "Lake aninmals",
    "dist_german" = c("Wasservögle am Gewässer", "Fische sichtbar", NA,
                      "Libellen am Gewässer", "Amphibien am Gewässer", NA),
    "dist_english" = c("Waterfowls at the lake", "Fish in the water", NA,
                       "Dragonflies at the lake", "Amphibians at the lake", NA)),
  "LAKE_WATER_LEVEL" = data.frame(
    "cw_output" = c("none", "yes, small", "unknown", "yes, large", "^$"), 
    "order" = c(1,2,4,3,5),
    "type" = "single",
    "german" = c("Keine", "Ja, kleine", "Keine Ahnung", "Ja, große", 
                 "Keine Antwort"),
    "english" = c("None", "Yes, small", "Unknown", "Yes, large", "No answer"),
    "prop_german" = "Wasserstandsänderungen",
    "prop_english" = "Water level changes",
    "dist_german" = c("Keine Wasserschwankungen", NA, NA, 
                      "Große Wasserschwankungen", NA),
    "dist_english" = c("No Water level changes", NA, NA, 
                       "Large water level changes", NA)),
  "LAKE_DRIES_OUT" = data.frame(
    "cw_output" = c("yes", "non", "Unknown", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Ahnung", "Keine Antwort"),
    "english" = c("Yes", "No", "Unknown", "No answer"),
    "prop_german" = "Austrocknungsereignisse",
    "prop_english" = "Dry-out events",
    "dist_german" = c("See trocknet manchmal aus", NA, NA, NA),
    "dist_english" = c("Lake sometimes dries out", NA, NA, NA))
)
usethis::use_data(props_and_cats, overwrite = TRUE)

# District data
shp_path <- "Y:/iGB/Projects/AD4GD/Exchange/01_data/02_process/gis_data/bezirksgrenzen.shp"
library(sf)
berlin_district_shp <- st_read(shp_path, quiet = TRUE)
usethis::use_data(berlin_district_shp, overwrite = TRUE)


