# load required libraries
library(tm)
library(ggplot2)
library(lsa)

# 1. Prepare mock data
text <- c("transporting food by cars will cause global warming. so we should go local.",
          "we should try to convince our parents to stop using cars because it will cause global warming.",
          "some food, such as mongo, requires a warm weather to grow. so they have to be transported to canada.",
          "a typical electronic circuit can be built with a battery, a bulb, and a switch.",
          "electricity flows from batteries to the bulb, just like water flows through a tube.",
          "batteries have chemical energe in it. then electrons flow through a bulb to light it up.",
          "birds can fly because they have feather and they are light.", "why some birds like pigeon can fly while some others like chicken cannot?",
          "feather is important for birds' fly. if feather on a bird's wings is removed, this bird cannot fly.")
view <- factor(rep(c("view 1", "view 2", "view 3"), each = 3))
df <- data.frame(text, view, stringsAsFactors = FALSE)

# prepare corpus
corpus <- Corpus(VectorSource(df$text))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, function(x) removeWords(x, stopwords("english")))
corpus <- tm_map(corpus, stemDocument, language = "english")
corpus  # check corpus

# 2. MDS with raw term-document matrix compute distance matrix
td.mat <- as.matrix(TermDocumentMatrix(corpus))
dist.mat <- dist(t(as.matrix(td.mat)))
dist.mat  # check distance matrix

##       1     2     3     4     5     6     7     8
## 2 2.828
## 3 3.000 3.873
## 4 3.742 4.000 3.873
## 5 4.000 4.243 4.123 3.464
## 6 3.742 4.000 3.873 2.828 2.828
## 7 3.317 3.606 3.464 3.317 3.606 3.000
## 8 3.317 3.606 3.464 3.317 3.606 3.317 2.000
## 9 5.099 5.292 5.196 5.099 5.292 5.099 3.000 3.606


# MDS
fit <- cmdscale(dist.mat, eig = TRUE, k = 2)
points <- data.frame(x = fit$points[, 1], y = fit$points[, 2])
ggplot(points, aes(x = x, y = y)) + geom_point(data = points, aes(x = x, y = y,color = df$view)) + geom_text(data = points, aes(x = x, y = y - 0.2, label = row.names(df)))


# 3. MDS with LSA
td.mat.lsa <- lw_bintf(td.mat) * gw_idf(td.mat)  # weighting
lsaSpace <- lsa(td.mat.lsa)  # create LSA space
dist.mat.lsa <- dist(t(as.textmatrix(lsaSpace)))  # compute distance matrix
dist.mat.lsa  # check distance mantrix

##         1       2       3       4       5       6       7       8
## 2  6.9720
## 3  8.2482 14.9605
## 4  9.6561 13.0836 12.8002
## 5  8.0963 11.9788 11.6686  2.4150
## 6  9.0802 12.6645 12.3715  2.4007  1.7214
## 7  7.6546 11.6848 11.3666  8.7133  6.3557  6.7759
## 8  7.5055 11.5876 11.2667  9.0778  6.6877  7.2384  0.6671
## 9  9.0005 12.6075 12.3132 10.5855  8.3089  8.4643  2.1678  2.2945


# MDS
fit <- cmdscale(dist.mat.lsa, eig = TRUE, k = 2)
points <- data.frame(x = fit$points[, 1], y = fit$points[, 2])
ggplot(points, aes(x = x, y = y)) + geom_point(data = points, aes(x = x, y = y,   color = df$view)) + geom_text(data = points, aes(x = x, y = y - 0.2, label = row.names(df)))

library(scatterplot3d)
fit <- cmdscale(dist.mat.lsa, eig = TRUE, k = 3)
colors <- rep(c("blue", "green", "red"), each = 3)
scatterplot3d(fit$points[, 1], fit$points[, 2], fit$points[, 3], color = colors,
              pch = 16, main = "Semantic Space Scaled to 3D", xlab = "x", ylab = "y",
              zlab = "z", type = "h")

