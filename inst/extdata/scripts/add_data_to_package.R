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
                  "Water sports", "Fishing", "No visible usage", "No answer")), 
  "LAKE_ACCESS" = data.frame(
    "cw_output" = c("yes", "nein", "^$"),
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer")), 
  "LAKE_SHORE_STATE" = data.frame(
    "cw_output" = c("partly built-in", "built-in", "natural", "^$"), 
    "order" = c(2,3,1,4),
    "type" = "single",
    "german" = c("Teilverbaut", "Verbaut", "Natürlich", "Keine Antwort"),
    "english" = c("Partly built-in", "Built-in", "Natural", "No answer")), 
  "LITTER_IN_WATER" = data.frame(
    "cw_output" = c("No litter", "Some litter, but not prominent", "^$", 
                    "Abundant litter"), 
    "order" = c(1,2,4,3),
    "type" = "single",
    "german" = c("Kein Abfall", "Etwas Abfall, aber nicht auffallend", 
                 "Keine Antwort", "Viel Abfall"),
    "english" =  c("No litter", "Some litter, but not prominent", "No Answer", 
                   "Abundant litter")),
  "LAKE_SWIM" = data.frame(
    "cw_output" = c("yes", "nein", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer")),
  "LAKE_TRANSPARENCY" = data.frame(
    "cw_output" = c("20 – 50  cm", "50 cm – 1 m", "deeper than 1 m", 
                    "a few cm", "^$"), 
    "order" = c(2,3,4,1,5),
    "type" = "single",
    "german" = c("20 – 50  cm", "50 cm – 1 m", "Tiefer als 1 m", "Ein paar cm", 
                 "Keine Antwort"),
    "english" = c("20 – 50  cm", "50 cm – 1 m", "Deeper than 1 m", 
                  "A few cm", "No answer")) ,
  "LAKE_WATER_COLOUR" = data.frame(
    "cw_output" = c("clear", "gray", "brown", "green", "Beige", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Klar","Grau", "Braun", "Grün", "Beige", "Keine Antwort"),
    "english" =  c("Clear", "Gray", "Brown", "Green", "Beige", "No answer")),
  "LAKE_SMELL" = data.frame(
    "cw_output" = c("No odor", "Other odor", "Fishy", "Musty", 
                    "Other sewage odor", "Rotten eggs", "^$"), 
    "order" = c(1, 6, 3, 2, 5, 4,7),
    "type" = "single",
    "german" = c("Kein Geruch", "Anderer deutlicher Geruch", "Fischig", "Modrig",
                 "Sonstiger Abwassergeruch", "Faule Eier", "Keine Antwort"),
    "english" = c("No odor", "Other odor", "Fishy", "Musty", 
                    "Other sewage odor", "Rotten eggs", "No answer")),
  "LAKE_SHORE_VEGETATION" = data.frame(
    "cw_output" = c("Reed", "Trees", "Lawn", "Other", "^$"), 
    "order" = NA,
    "type" = "multiple",
    "german" = c("Schilf", "Bäume", "Rasen", "Sonstige", "Keine Antwort"),
    "english" = c("Reed", "Trees", "Lawn", "Other", "No answer")),
  "LAKE_PLANTS_UNDERWATER" = data.frame(
    "cw_output" = c("yes", "nein", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer")),
  "FLOATING_LEAVE_PLANTS" = data.frame(
    "cw_output" = c("yes", "non", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Antwort"),
    "english" = c("Yes", "No", "No answer")),
  "DUCKWEED" = data.frame(
    "cw_output" = c("ca 1/4", "zero", "ca half", "ca 3/4", "completely", "^$"), 
    "order" = c(2,1,3,4,5,6),
    "type" = "single",
    "german" = c("Einviertel", "Nichts", "Hälfte", "Dreiviertel", "Komplett", 
                 "Keine Antwort"),
    "english" = c("Ca. 1/4", "No duckweed", "Ca. 1/2", "Ca. 3/4", 
                  "Completely covered", "No answer")),
  "LAKE_MUSSELS" = data.frame(
    "cw_output" = c("large mussels", "triangular mussels", "no mussels", 
                    "other mussles", "^$"), 
    "order" = NA,
    "type" = "multiple",
    "german" = c("Großmuscheln", "Dreikantmuscheln", "Keine Muscheln", 
                 "Sonstige Muscheln", "Keine Antwort"),
    "english" = c("Large mussels", "Triangular mussels", "No mussels", 
                  "Other mussles", "No answer")),
  "LAKE_DEADWOOD" = data.frame(
    "cw_output" =  c("yes, some", "yes, a lot", "none", "^$"), 
    "order" = c(2, 3, 1, 4),
    "type" = "single",
    "german" = c("Ein bisschen", "Viel", "Keins", "Keine Antwort"),
    "english" = c("Yes, some", "Yes, a lot", "None", "No answer")),
  "LAKE_ANIMALS" = data.frame(
    "cw_output" = c("waterfowl", "fish", "no visible animals", "dragonflies", 
                    "amphibians", "^$"), 
    "type" = "multiple",
    "order" = NA,
    "german" = c("Wasservögel", "Fische", "Keine Tiere sichtbar", "Libellen", 
                 "Amphibien", "Keine Antwort"),
    "english" = c("Waterfowl", "Fish", "No visible animals", "Dragonflies", 
                  "Amphibians", "No answer")),
  "LAKE_WATER_LEVEL" = data.frame(
    "cw_output" = c("none", "yes, small", "unknown", "yes, large", "^$"), 
    "order" = c(1,2,4,3,5),
    "type" = "single",
    "german" = c("Keine", "Ja, kleine", "Keine Ahnung", "Ja, große", 
                 "Keine Antwort"),
    "english" = c("None", "Yes, small", "Unknown", "Yes, large", "No answer")),
  "LAKE_DRIES_OUT" = data.frame(
    "cw_output" = c("yes", "non", "Unknown", "^$"), 
    "order" = NA,
    "type" = "single",
    "german" = c("Ja", "Nein", "Keine Ahnung", "Keine Antwort"),
    "english" = c("Yes", "No", "Unknown", "No answer"))
)
usethis::use_data(props_and_cats, overwrite = TRUE)





