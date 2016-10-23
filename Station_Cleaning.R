################################################################################
# Cleaning of list of SMS weather stations
# Last updated: 2016-10-23
#
# Because the Singapore Meteorological service stores information on their
# weather stations in a pdf document, this script extracts a list of details of
# each station, including: station names and lat/long coordinates.
################################################################################

library(pdftools)

# Defining folder
fldr <- readline("Path of folder: ")

# Reading in only the text from the document
text <- pdf_text(file.path(fldr, readline("Filename of pdf doc: ")))

# Splitting each line by carriage-return text
textpg1 <- unlist(strsplit(text[1], "\\r\\n"))
textpg2 <- unlist(strsplit(text[2], "\\r\\n"))
textpg3 <- unlist(strsplit(text[3], "\\r\\n"))

# Combining all character vectors minus the repeated table headers
textcomb <- c(textpg1, textpg2[5:35], textpg3[5:13])
# textcombsplit <- strsplit(textcomb, "\\s{2,}")

# Writing the character vector into a csv file.
write.csv(textcomb, file.path(fldr, readline("Filename of converted csv: ")))
