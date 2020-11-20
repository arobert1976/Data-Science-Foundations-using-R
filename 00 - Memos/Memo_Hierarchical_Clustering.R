# Creating 3 clusters
set.seed(1234)
par(mar=c(0,0,0,0)) #sets the margins to 0
x = rnorm(12, mean=rep(1:3, each=4), sd=0.2) #12 valeurs : 4 autour de 1, 4 autour de 2, 4 autour de 3.
y = rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2) #12 valeurs : 4 autour de 1, 4 autour de 2, 4 autour de 1.
plot(x, y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))

# Calculating the dist between points
df = data.frame(x=x,y=y)
dist(df) #euclidian distance

# Generating the dendogram
distxy = dist(df) #class(distxy) = dist
hCluster = hclust(distxy) #class(hCluster) = hclust
plot(hCluster)



