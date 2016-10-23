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

# library(curl)
library(lubridate)
library(data.table)

# Creating a sequence of months given 2 dates
dateseq <- seq.Date(
    from = ymd(readline("From date (YYYY-MM-DD): ")),
    to = ymd(readline("To date (YYYY-MM-DD): ")),
    by = "month"
)

# Reading in station data
stations <- fread(
    readline("Path & filename of station list: "),
    check.names = T
)
stations <- stations[Station_Code != ""]

# Creating a table of filenames
station_tbl <- NULL
for (i in 1:length(dateseq)) {
    stations_copy <- copy(stations)

    stations_copy[, `:=`(
        Filename = paste0(
            "DAILYDATA_",
            Station_Code,
            "_",
            format(dateseq[i], "%Y%m"),
            ".csv"
        )
    )]

    station_tbl <- rbindlist(list(station_tbl, stations_copy))
}
rm(stations, stations_copy)

# Scraping data from SMS website files
weather_data <- NULL
for (i in 1:nrow(station_tbl)) {
    try({
        ## Downloading the data and reading in as data table
        point_data <- fread(
            paste0("http://www.weather.gov.sg/files/dailydata/",
                   station_tbl$Filename[i])
        )

        ## Cleaning the headers
        rev_headers <- gsub("[[:punct:]]", "", names(point_data))
        rev_headers <- gsub("\\s", "_", rev_headers)

        setnames(
            point_data,
            rev_headers
        )

        ## Adding station code for easier merging later
        point_data[, Station_Code := station_tbl$Station_Code[i]]

        ## Inserting rows
        weather_data <- rbindlist(list(weather_data, point_data))
    }, silent = T)
}
rm(point_data)

# Combine weather data with station table
weather_data <- merge(
    weather_data,
    unique(station_tbl[, c("Lat", "Long", "Station_Code"), with = F]),
    by = "Station_Code"
)

# Write data out to csv file
write.csv(
    weather_data,
    readline("Path & filename of output csv: "),
    row.names = F
)

# Clear all variables
rm(list = ls())
