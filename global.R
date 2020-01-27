library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)
library(stringr)
library(RColorBrewer)

prison <- read.csv('prison-admissions-beginning-2008.csv')


# rename columns
colnames(prison) = c("Year",
                     "Admission.Month",
                     "Month",
                     "Admission.Type",
                     "County",
                     "Last.Residence",
                     "Gender",
                     "Age.Admitted",
                     "Most.Serious.Crime")

# title format 
prison$Gender = str_to_title(prison$Gender)
prison$Admission.Month = str_to_title(prison$Admission.Month)
prison$Admission.Type = str_to_title(prison$Admission.Type)
prison$County = str_to_title(prison$County)
prison$Last.Residence = str_to_title(prison$Last.Residence)
prison$Gender = str_to_title(prison$Gender)

# categorize age column
prison$Age.Group <- cut(prison$Age.Admitted, 
                        breaks = c(0,18,31,45,66,200), 
                        labels = c("Juvenile","Young Adult","Adult", "Middle Age","Elderly"), 
                        right = F)


# Clean Data 
prison <- prison %>%
  filter(Gender != "Not Coded" &
           County != "Missing" & 
           County != "") %>% 
  select(-Last.Residence) 


# Categorizing Top Crimes
prison$Crime.Category <- case_when(
  grepl("MURDER", prison$Most.Serious.Crime) == "TRUE" ~ "Murder",
  grepl("MURDER", prison$Most.Serious.Crime) == "TRUE" ~ "Murder",
  grepl("FORGE", prison$Most.Serious.Crime) == "TRUE" ~ "Forgery",
  grepl("ASSAULT", prison$Most.Serious.Crime) == "TRUE" ~ "Assault",
  grepl("ARSON", prison$Most.Serious.Crime) == "TRUE" ~ "Arson",
  grepl("CONTEMPT", prison$Most.Serious.Crime) == "TRUE" ~ "Contempt",
  grepl("CONSPIRACY", prison$Most.Serious.Crime) == "TRUE" ~ "Conspiracy",
  grepl("TAX", prison$Most.Serious.Crime) == "TRUE" ~ "Tax Related",
  grepl("STRANGUL", prison$Most.Serious.Crime) == "TRUE" ~ "Strangulation",
  grepl("BAIL", prison$Most.Serious.Crime) == "TRUE" ~ "Bail Related",
  grepl("MISCHIEF", prison$Most.Serious.Crime) == "TRUE" ~ "Criminal Mischief",
  grepl("KIDNAPPING", prison$Most.Serious.Crime) == "TRUE" ~ "Kidnapping",  
  grepl("COERC", prison$Most.Serious.Crime) == "TRUE" ~ "Coercion",  
  grepl("RECK ENDANG", prison$Most.Serious.Crime) == "TRUE" ~ "Reckless Endangerment",  
  grepl("UNLICENSED D", prison$Most.Serious.Crime) == "TRUE" ~ "Unlicensed Driver",
  grepl("CONTRAB", prison$Most.Serious.Crime) == "TRUE" ~ "Contraband Possession",
  # Manslaughter
  (grepl("MANSLAUG", prison$Most.Serious.Crime) | 
     grepl("MANSL", prison$Most.Serious.Crime)) == "TRUE" ~ "Manslaughter", 
  # Weapons
  (grepl("WEAP", prison$Most.Serious.Crime) |
     grepl("FIREARM", prison$Most.Serious.Crime)) == "TRUE" ~ "Weapon Related",
  # Fraud, identity theft 
  (grepl("IDENTITY THEFT", prison$Most.Serious.Crime) |
     grepl("FRAUD", prison$Most.Serious.Crime)) == "TRUE" ~ "Fraud",
  # Drug Related  
  (grepl("CPCS", prison$Most.Serious.Crime) |
     grepl("DRUG", prison$Most.Serious.Crime) |
     grepl("MARI", prison$Most.Serious.Crime) |
     grepl("DRGS", prison$Most.Serious.Crime) |
     grepl("CONTROLLED", prison$Most.Serious.Crime) |
     grepl("METH", prison$Most.Serious.Crime) |
     grepl("CSCS", prison$Most.Serious.Crime)) == "TRUE" ~ "Drug Related",
  # DUI
  (grepl("IMPAIR", prison$Most.Serious.Crime) |
     grepl("INTOX", prison$Most.Serious.Crime) |
     grepl("DWI", prison$Most.Serious.Crime)) == "TRUE" ~ "DUI",
  # Sexual Crimes
  (grepl("RAPE", prison$Most.Serious.Crime) |
     grepl("CRIM SEX ACT", prison$Most.Serious.Crime) |
     grepl("SEX", prison$Most.Serious.Crime) |
     grepl("PORN", prison$Most.Serious.Crime) |
     grepl("PROSTI", prison$Most.Serious.Crime) |
     grepl("INDEC", prison$Most.Serious.Crime) |
     grepl("SODOMY", prison$Most.Serious.Crime)) == "TRUE" ~ "Sexual Crime" ,
  # Theft
  (grepl("BURGLARY", prison$Most.Serious.Crime) | 
     grepl("LARCEN", prison$Most.Serious.Crime) |
     grepl("LAR", prison$Most.Serious.Crime) |
     grepl("STOLEN", prison$Most.Serious.Crime) |
     grepl("ROBBERY", prison$Most.Serious.Crime)) == "TRUE" ~ "Theft",
  # Youthful 
  (grepl("YO", prison$Most.Serious.Crime) | 
     grepl("YOUTHFUL", prison$Most.Serious.Crime)) == "TRUE" ~ "Youthful Offender",
  TRUE ~ as.character(prison$Most.Serious.Crime)
)






