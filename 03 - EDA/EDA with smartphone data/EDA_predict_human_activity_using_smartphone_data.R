## I'm using the train dataset for this EDA

## ------------------------------
## Preparing the dataset
## ------------------------------
## Merging the subject, train into one dataframe + setting descriptive names
subjects = read.table("UCI HAR dataset/train/subject_train.txt") #dim(subjects)=(7352,1)
measures = read.table("UCI HAR dataset/train/X_train.txt") #dim(subjects)=(7352,561)
activities = read.table("UCI HAR dataset/train/y_train.txt") #dim(activities)=(7352,1)
data = cbind(measures, activities, subjects) #dim(data)=(7352,563)
features = read.table("UCI HAR dataset/features.txt")
names(data) = c(features$V2, "activity", "subject") #setting variable names
## Setting descriptive activity names (WALKING, WALKING_UPSTAIRS, ...) instead of activity codes (1, 2, ...) 
data[,562] = factor(data$activity, labels=c("walk","walkup", "walkdown", "sitting", "standing", "laying" ))

## --------------------------------
## EDA : Nb of records per activity
## --------------------------------
table(data$activity)

## -------------------------------------------------------
## EDA : Plotting average accelaration for the 1st subject
## -------------------------------------------------------
par(mfrow=c(1,2), mar=c(5,4,1,1))
sub1 = subset(data, subject==1)
plot(x=1:347, y=sub1[,1], col=sub1$activity, ylab=names(sub1[1]))
plot(x=1:347, y=sub1[,2], col=sub1$activity, ylab=names(sub1[2]))
legend("bottomright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=1)
## L'accélération moyenne (pour les axes X et Y) est à peu près constante tout au long de l'expérience lorsque le sujet ne bouge pas
## L'accélération moyenne (pour les axes X et Y) est à peu près constante tout au long de l'expérience lorsque le sujet se déplace

## ---------------------------------------------------
## EDA : Clustering based just on average acceleration
## ---------------------------------------------------
par(mfrow=c(1,1))
hclustering = hclust(dist(sub1[,1:3]))
source("myplclust.R")
myplclust(hclustering, lab.col=unclass(sub1$activity))
legend("topright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=1)
## On retrouve la distinction "en mouvement" et "immobile" mais au sein de ces 2 grandes catégories, on ne retrouve pas des clusters permettant d'identifier une activité

## -----------------------------------------------------
## EDA : Plotting max acceleration for the first subject
## -----------------------------------------------------
par(mfrow=c(1,2))
plot(x=1:347, y=sub1[,10], col=sub1$activity, ylab=names(sub1[10]), pch=19)
plot(x=1:347, y=sub1[,11], col=sub1$activity, ylab=names(sub1[11]), pch=19)
legend("topright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=19)
## walkdown : acc-max()-X qui est supérieure

## ---------------------------------------------------
## EDA : Clustering based just on maximum acceleration
## ---------------------------------------------------
par(mfrow=c(1,1))
hclustering = hclust(dist(sub1[,10:12]))
myplclust(hclustering, lab.col=unclass(sub1$activity))
legend("topright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=1)
## On retrouve la distinction "en mouvement" et "immobile" mais au sein de ces 2 grandes catégories, 
## on ne retrouve pas des clusters permettant d'identifier une activité
## à l'exception de walkdown qui forme un cluster distinct de walk+walkup

## ----------------------------------
## EDA : Singular Value Decomposition
## ----------------------------------
svd1 = svd(scale(sub1[,1:561])) #dim(svd1$u)=(347,347) dim(svd1$v)=(561,347)
par(mfrow=c(1,2))
plot(x=1:347, y=svd1$u[,1], col=sub1$activity, ylab="First Left Singular Vector", pch=19)
plot(x=1:347, y=svd1$u[,2], col=sub1$activity, ylab="Second Left Singular Vector", pch=19)
legend("topright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=19)
## Sur le 1er plot, on retrouve bien évidemment la distinction "mobile" et "immobile"
## On a aussi une plage de valeurs entre 0 et 0.25 qui contient essentiellement du "walkup"
## Dans le 2nd plot : ce 2nd Left Singular Vector sépare bien le "walkup" de "walk+walkdown" 
## de façon plus claire que sur le 1er plot

## ------------------------------------------------------
## EDA : Find maximum contributor : quelle feature est 
## la plus responsable des variations que l'on observe dans les observations
## ?? pourquoi on prend svd1$v[,2] ??
## ------------------------------------------------------
par(mfrow=c(1,1))
plot(svd1$v[,2], pch=19)
maxContrib=which.max(svd1$v[,2]) ##maxContrib = 296 (296ème feature parmi les 561)
distance=dist(sub1[,c(10:12, maxContrib)]) ##dim(sub1[,c(10:12, maxContrib)])=(347,4)
## on fait le même clustering que précédemment mais on ajoute aux 3 valeurs acc-max()-XYZ, la 296ème feature
hclustering=hclust(distance)
myplclust(hclustering, lab.col=unclass(sub1$activity))
legend("topright", legend=unique(sub1$activity), col=unique(sub1$activity), pch=19)
## Maintenant, on arrive bien à distinguer walk, walkup et walkdown

## ------------------------------------------------------
## EDA : Trying another clustering technique K-Means
## ------------------------------------------------------
kClust = kmeans(sub1[,1:561], centers=6)
table(kClust$cluster, sub1$activity)
## le cluster 5 regroupe toutes les observations où le sujet "walk" 
## le cluster 6 regroupe toutes les observations où le sujet "walkup" 
## les 4 autres clusters mélangent des observations où le sujet a des activités différentes.

kClust = kmeans(sub1[,1:561], centers=6, nstart=100)
table(kClust$cluster, sub1$activity)
## meilleur résultat que précédemment mais il reste délicat de séparer sitting/standing/laying

## -------------------------------------------------------------
## EDA : Cluster 1 variable centers 
## Dans cet espace de 561 dimensions, chaque cluster a un centre
## -------------------------------------------------------------
plot(kClust$center[1,], pch=19, ylab="cluster 1 center", xlab="feature") #le centre du 1er cluster qui regroupe les observations où le sujet walkdown
## en superposant les centres de 2 clusters, on doit pouvoir en déduire quelle(s) feature(s) sépare le plus les 2 clusters 