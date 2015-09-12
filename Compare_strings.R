sent1 <- "I shot the sheriff."
sent2 <- "Dick Cheney shot a man."

compareSentences <- function(sentence1, sentence2) {
  sentence1 <- unlist(strsplit(sentence1, " "))
  sentence2 <- unlist(strsplit(sentence2, " "))
  
  commonWords <- intersect(sentence1, sentence2)
  
  return(list(
    sentence1 = paste(gsub(commonWords, paste(commonWords, "*", sep = ""), sentence1), collapse = " ")
    , sentence2 = paste(gsub(commonWords, paste(commonWords, "*", sep = ""), sentence2), collapse = " ")
  ))
}
compareSentences(sent1, sent2)


install.packages("stringdist")
