library(tm)
#my.corpus <- Corpus(DirSource("C:/Users/Elcot/Desktop/Reviews.csv"))
r<- read.csv("Reviews.csv",stringsAsFactors=FALSE)

r_t<- paste(r$text,collapse=" ")
rs <- VectorSource(r_t)
my.corpus <- Corpus(rs)

my.corpus <- tm_map(my.corpus, removeWords, stopwords("english"))
my.stops <- c("history","clio", "programming")
my.corpus <- tm_map(my.corpus, removeWords, my.stops)

install.packages("Snowball")
require("Snowball")
install.packages("SnowballC")
library("SnowballC")

my.corpus <- tm_map(my.corpus, stemDocument)

my.tdm <- TermDocumentMatrix(my.corpus)
inspect(my.tdm)
my.dtm <- DocumentTermMatrix(my.corpus, control = list(weighting = weightTfIdf, stopwords = TRUE))
inspect(my.dtm)

findFreqTerms(my.tdm, 2)
findAssocs(my.tdm, 'year', 0.20)

my.df <- as.data.frame(inspect(my.tdm))
my.df.scale <- scale(my.df)
d <- dist(my.df.scale,method="euclidean")
fit <- hclust(d, method="ward.D2")
plot(fit)



