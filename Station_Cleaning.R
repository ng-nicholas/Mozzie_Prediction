library(pdftools)

text <- pdf_text(readline())

textpg1 <- unlist(strsplit(text[1], "\\r\\n"))
textpg2 <- unlist(strsplit(text[2], "\\r\\n"))
textpg3 <- unlist(strsplit(text[3], "\\r\\n"))
textcomb <- c(textpg1, textpg2[5:35], textpg3[5:13])
# textcombsplit <- strsplit(textcomb, "\\s{2,}")

write.csv(textcomb, readline())
