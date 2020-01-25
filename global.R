library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)
library(stringr)
library(d3heatmap)

prison <- read.csv('prison-admissions-beginning-2008.csv')

# to do list
# filter out not coded from gender 

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
prison$Age.Group <- cut(prison$Age.Admitted, breaks = c(0,18,31,45,66,200), labels = c("Juvenile","Young Adult","Adult", "Middle Age","Elderly"), right = F)


# Clean Data 
prison <- prison %>%
  filter(Gender != "Not Coded" &
           County != "Missing" & 
           County != "") %>% 
  select(-Last.Residence)

View(prison)

  
# unique(prison$Most.Serious.Crime)
# colnames(prison)

prisonheatmap <- 
  prison %>% 
  filter(Year == 2018) %>% 
  group_by(Month) %>% 
  summarise(Total = n())

d3heatmap(prisonheatmap, dendrogram = "none")


# View(prison)

# leaflet https://stackoverflow.com/questions/43446802/how-to-download-ny-state-all-county-data-in-r-for-leaflet-map


