library(XML)
library(httr)
url <- "http://www.wikiart.org/en/claude-monet/mode/all-paintings-by-alphabet/"
hrefs <- list()
for (i in 1:23) {
  response <- GET(paste0(url,i))
  doc      <- content(response,type="text/html")
  hrefs    <- c(hrefs,doc["//p[@class='pb5']/a/@href"])
}
url      <- "http://www.wikiart.org"
xPath    <- c(pictureName = "//h1[@itemprop='name']",
              date        = "//span[@itemprop='dateCreated']",
              author      = "//a[@itemprop='author']",
              style       = "//span[@itemprop='style']",
              genre       = "//span[@itemprop='genre']")
get.picture <- function(href) {
  response <- GET(paste0(url,href))
  doc      <- content(response,type="text/html")
  info     <- sapply(xPath,function(xp)ifelse(length(doc[xp])==0,NA,xmlValue(doc[xp][[1]])))
}
pictures <- do.call(rbind,lapply(hrefs,get.picture))


install.packages("rNOMADS")
library(rNOMADS)
WebCrawler(url, depth = NULL, verbose = TRUE)



fqlQuery='select share_count,like_count,comment_count from link_stat where url="'
url="http://www.theguardian.com/world/2014/mar/03/ukraine-navy-officers-defect-russian-crimea-berezovsky"
queryUrl = paste0('http://graph.facebook.com/fql?q=',fqlQuery,url,'"')  #ignoring the callback part
lookUp <- URLencode(queryUrl) #What do you think this does?
lookUp

require(rjson)
rd <- readLines(lookUp, warn="F") 
dat <- fromJSON(rd)
dat


install.packages("jsonlite")
library(jsonlite)


getUrl <- function(address,sensor = "false") {
  root <- "https://maps.google.com/maps/api/geocode/json?"
  u <- paste0(root,"address=", address, "&sensor=false")
  return(URLencode(u))
}
getUrl("Kremlin, Moscow")



target <- getUrl("Kremlin, Moscow")
dat <- fromJSON(target)
latitude <- dat$results[[1]]$geometry$location["lat"]
longitude <- dat$results[[1]]$geometry$location["lng"]
place <- dat$results[[1]]$formatted_address

latitude
longitude
place
