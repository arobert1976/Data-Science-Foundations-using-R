##Creating a dataframe
set.seed(13435)
X = data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X = X[sample(1:5),]; X$var2[c(1,3)]=NA
X

## Adding a column to a dataframe
X$var4 = rnorm(5)
Y = cbind(X, rnorm(5))

## Adding a row to a dataframe
Z = rbind(X, rnorm(4))

##Subsetting a column
X[,1] #integer 

##Subsetting a column using the column name
X[,"var1"] #integer 
X$var1 #integer

##Subsetting columns
X[,2:3] #data.frame
X[,c("var2","var3")]

##Subsetting rows
X[1:2,] #data.frame
X[1,] #data.frame, not integer!

##Subsetting rows and columns
X[1:2,2:3] #data.frame

##Subsetting using logical conditions
X[X$var1 <= 3,]
X[(X$var1 <= 3 & X$var3>11),] #data.frame
X[(X$var1 <= 3 & X$var3>11),"var2"] #integer
X[(X$var1 <= 3 | X$var3>11),] #data.frame
X[X$var2 > 8,] #does not handle correctly NA values
X[which(X$var2 > 8),] #data.frame, handles correctly NA values

##Ordering dataframes
X[order(X$var2, na.last=TRUE),] ##data.frame ordered by var2 with NA values at the end
X[order(X$var1, X$var3),] ##data.frame ordered by "var2" then "var3"

##Ordering dataframes with plyr
library(plyr)
arrange(X,var1) # <=> X[order(X$var1),]
arrange(X,desc(var1))

##MErging dataframes using a key
reviews = data.frame("id"=11:15, "solution_id"=1:5, "author"=c("hemingway","shakespeare","hugo","dante","tolstoi"))
solutions = data.frame("id"=1:5, "scores"=c(12L, 20L, 5L, 17L, 10L))
mergeddata = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
mergeddata = merge(reviews, solutions, all=TRUE) ##par defaut, la cle est constituee des colonnes qui portent le meme nom dans les 2 dataframes
