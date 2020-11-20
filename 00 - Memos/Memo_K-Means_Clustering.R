# Creating 3 clusters
set.seed(1234)
par(mar=c(0,0,0,0)) #sets the margins to 0
x = rnorm(12, mean=rep(1:3, each=4), sd=0.2) #12 valeurs : 4 autour de 1, 4 autour de 2, 4 autour de 3.
y = rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2) #12 valeurs : 4 autour de 1, 4 autour de 2, 4 autour de 1.
plot(x, y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))

# Creating the kmeans object 
df = data.frame(x=x,y=y)
kmeansObj = kmeans(df, centers=3) #K=3
names(kmeansObj) 
kmeansObj$cluster

# Plotting the clusters with their centers
plot(x, y, col=kmeansObj$cluster, pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))
points(kmeansObj$centers, col=1:3, pch=3, cex=2, lwd=3)

# Another way to look at the result of a K-means is to display a heatmap
dataMatrix = as.matrix(df)
par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1], yaxt="n") #les données de mon dataframe
image(t(dataMatrix)[,order(kmeansObj$cluster)], yaxt="n") #les mêmes données regroupées par cluster
