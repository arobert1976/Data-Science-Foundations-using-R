set.seed(12345)
par(mar=rep(0.2,4))
dataMatrix = matrix(rnorm(400),nrow=40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1]) 

heatmap(dataMatrix) #heatmap clusters the raws and cols and there is no pattern in the data

##Let's add a pattern
set.seed(678910)
for(i in 1:40){
  #flip a coin
  coinFlip=rbinom(1, size=1, prob=0.5)
  #if coin is heads, add a common pattern to that raw
  if(coinFlip){
    dataMatrix[i,] = dataMatrix[i,] + rep(c(0,3), each=5)
  }
}

image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1]) #now there is a pattern in the underlying data
heatmap(dataMatrix) #and this pattern is even more visible if we use heatmap() 
# PATTERN : les colonnes de droite ont des valeurs plus importantes que celles de gauche 
# pour 1 ligne sur 2 environ

#patterns in raws and columns
par(mfrow=c(1,3))
image(t(dataMatrix)[,nrow(dataMatrix):1])
plot(rowMeans(dataMatrix), 40:1, xlab="Row Mean", ylab="Row", pch=19)
plot(colMeans(dataMatrix), xlab="Column", ylab="Column Mean", pch=19)
# mais on les voit encore mieux si on regroupe les lignes / colonnes proches
hh=hclust(dist(dataMatrix))
dataMatrixOrdered=dataMatrix[hh$order,]
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, xlab="Row Mean", ylab="Row", pch=19)
plot(colMeans(dataMatrixOrdered), xlab="Column", ylab="Column Mean", pch=19)

#SVD - Approche plus formelle pour mettre en évidence les patterns
svd1 = svd(scale(dataMatrixOrdered))
u = svd1$u #dim(u)=(40,10)
v = svd1$v #dim(v)=(10,10)
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(u[,1], xlab="U - First Left Singular Vector")
plot(v[,1], xlab="V - First Right Singular Vector")

#SVD - Variance expliquée
par(mfrow=c(1,2))
plot(svd1$d, xlab="Column", ylab="Singular Value")
plot(svd1$d^2/sum(svd1$d^2), xlab="Column", ylab="Property of Variance Explained")
## les composants sont ordonnés de sorte que le 1er composant explique la variation 
## la plus importante et le dernier la variation la moins importante


