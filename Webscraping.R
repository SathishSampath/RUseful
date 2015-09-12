library(XML)
URL <- 'http://data.worldbank.org/indicator/SP.POP.TOTL'
tables<-readHTMLTable(URL,stringsAsFactors=FALSE)
str(tables)
tables[[1]]
table1data<-tables[[1]]
names(table1data)
table1data<-table1data[,-c(6,7)]
names(table1data)

# load packages
library(RCurl)
library(XML)

# download html
html <- getURL("https://www.google.co.uk/search?gcx=c&sourceid=chrome&ie=UTF-8&q=r+project#pq=%22hello+%3C+world%22&hl=en&cp=5&gs_id=3r&xhr=t&q=phd+comics&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=phd+c&aq=0&aqi=g4&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=27ff09b2758eb4df&biw=1599&bih=904", followlocation = TRUE)
html2 <- getURL("https://www.google.co.in/search?q=tcs+innovation+labs&oq=TCS+Innova&aqs=chrome.0.0j69i57j69i59j0l3.2667j0j4&sourceid=chrome&es_sm=93&ie=UTF-8", followlocation = TRUE)

# parse html
doc = htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
cat(paste(plain.text, collapse = " "))

doc2 = htmlParse(html2, asText=TRUE)
plain.text2 <- xpathSApply(doc2, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
cat(paste(plain.text2, collapse = " "))

#r project - Google Search Web Images Videos Maps News Shopping Gmail More Translate Books Finance Scholar Blogs YouTube Calendar Photos Documents Sites Groups Reader Even more » Account Options Sign in Search settings Web History Advanced Search Results 1 - 10 of about 336,000,000 for r project . Everything More Search Options Show options... Web The R Project for Statistical Computing R , also called GNU S, is a strongly functional language and environment to statistically explore data sets, make many graphical displays of data from custom ... www. r - project .org/ - Cached - Similar [Trunc...]
#r project - Google Search Web Images Videos Maps News Shopping Gmail More Translate Books Finance Scholar Blogs YouTube Calendar Photos Documents Sites Groups Reader Even more » Account Options Sign in Search settings Web History Advanced Search Results 1 - 10 of about 336,000,000 for r project . Everything More Search Options Show options... Web The R Project for Statistical Computing R , also called GNU S, is a strongly functional language and environment to statistically explore data sets, make many graphical displays of data from custom ... www. r - project .org/ - Cached - Similar [Trunc...]

## Another Way

install.packages("rvest")
library(rvest)
lego_movie <- html("http://www.imdb.com/title/tt1490017/")
lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()


lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()




