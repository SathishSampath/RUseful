install.packages("Rfacebook")
install.packages("httpuv")
install.packages("RColorBrewer")
install.packages("RCurl")
install.packages("rjson")
install.packages("httr")

library(Rfacebook)
library(htttpuv)
library(RColorBrewer)
library(RCurl)

myaccess_token=""
options(RCurloptions=list(verbose=FALSE,capath=system.file("curlSSL","cacert.pem",package="RCurl"),ssl.verifypeer=FALSE))
me<-getUSers("me",token=myaccess_token)
my_friends<-getFriends(token=myaccess_token,simplify=F)
str(my_friends)

pie(table(my_friends$relationship_status), col-brewer.pal(5,"Set1"))
pie(table(my_friends$location))
pie(table(my_friends$locale))

install.packages("igraph")
tmp<-getNetwork(myaccess_token,format="adj.matrix")
library(igraph)
network<-graph.adjacency(tmp,mode="undirected")
set.seed(1)
L<-layout.fruchterman.reingold(network)
L[,1]=(L[,1]-min[,1])/(max(L[,1])-min(L[,1])))*2-1
L[,2]=(L[,2]-min[,2])/(max(L[,2])-min(L[,2])))*2-1

pdf("network_pdf.pdf",width=50,height=50)

plot(network,layout=L,vertex.size=0,vertex.frame.color="#000000",edge.curved=FALSE,edge.color=rainbow(500),vertex.label.cex=3,edge.width=6)