################################################################################
# Scraping and combination of SMS daily weather data
# Last updated: 2016-10-23
#
# The Singapore Meteorological Service stores daily weather data captured in the
# past as csv files on their website at
# http://www.weather.gov.sg/climate-historical-daily/ . Unfortunately, they
# use javascript to make users pull data for each station by month, making it
# difficult for humans to pull data for a long date period. Fortunately, the
# data is stored in csv files which are accessible via urls. This script aims to
# download all of the data for a specified period and combine it into one table.
################################################################################

library(curl)
library(lubridate)
library(data.table)

fldr <- readline("Path of folder: ")

# Creating a sequence of months given 2 dates
dateseq <- seq.Date(
    from = ymd("2015-01-01"),
    to = ymd(Sys.Date()),
    by = "month"
)

# Reading in station data
stations <- fread(

)
