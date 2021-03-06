library(tidyverse)
library(mice)
library(ggplot2)
library(VIM)
library(leaflet)
library(scales)
library(ggrepel)
library(plotly)

Death15_16 <- read_csv("2015_2016.csv")
USGender <- read.csv("USGender.csv")
USRace <- read.csv("USRace.csv")

# Factors
Death15_16$raceethnicity <- as.factor(Death15_16$raceethnicity)
Death15_16$gender <- as.factor(Death15_16$gender)
Death15_16$armed <- as.factor(Death15_16$armed)
Death15_16$age <- as.numeric(Death15_16$age)
Death15_16$state <- as.factor(Death15_16$state)
Death15_16$mannerofdeath <- as.factor(Death15_16$mannerofdeath)
Death15_16$city <- as.factor(Death15_16$city)
Death15_16$year <- as.factor(Death15_16$year)

# New variables for month number and season
Death15_16$monthno <- match(Death15_16$month, month.name)

Death15_16$season <- ifelse(Death15_16$monthno %in% 12 & 1:2, "Winter",
                     ifelse(Death15_16$monthno %in% 1:2, "Winter",
                    ifelse(Death15_16$monthno %in% 3:5, "Spring",
                           ifelse(Death15_16$monthno %in% 6:8, "Summer",
                                  ifelse(Death15_16$monthno %in% 9:11, "Fall", "Other")))))

Death15_16$season <- as.factor(Death15_16$season)

Encoding(Death15_16$name) <- "UTF-8"


# New dataframe with top 10 cities
Death15_16$deaths <- rep(1,2226)
cityag <- aggregate(deaths ~ city, data = Death15_16, FUN = sum)
citysort <- arrange(cityag, -deaths)
citysort
citysort10 <- head(citysort, 10)
citysort10

# New dataframe with top 10 states
stateag <- aggregate(deaths ~ state, data = Death15_16, FUN = sum)
statesort <- arrange(stateag, -deaths)
statesort10 <- head(statesort, 10)