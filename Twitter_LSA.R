setwd("~/src/r/twitter-analytics/twitter-hashtag-analytics")
source("utilities.R")
source("get_tweets.R")
source("munge_tweets.R")
source("semantic_analysis.R")

# get tweets from #LAK13
lak13 <- GetTweetsBySearch('#LAK13', 500)
lak13 <- PreprocessTweets(lak13)
corpus <- ConstructCorpus(lak13$text, removeTags=TRUE, removeUsers=TRUE, stemming=TRUE)

# compute distance matrix
td.mat <- as.matrix(TermDocumentMatrix(corpus))
td.mat.lsa <- lw_bintf(td.mat) * gw_idf(td.mat) # weighting
lsaSpace <- lsa(td.mat.lsa) # create LSA space
dist.mat.lsa <- dist(t(as.textmatrix(lsaSpace))) # compute distance matrix

# MDS
fit <- cmdscale(dist.mat.lsa, eig=TRUE, k=2)
points <- data.frame(x=fit$points[, 1], y=fit$points[, 2])
qplot(x, y, data = points, geom = "point", alpha = I(1/5))