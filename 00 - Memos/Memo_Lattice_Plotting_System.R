library(lattice)
library(datasets)
xyplot(Ozone~Wind, data=airquality)

## Example of panel plot where each panel is defined by the given subset (by Month in the example below)
airquality = transform(airquality, Month=factor(Month))
xyplot(Ozone~Wind | Month, data=airquality, layout=c(5,1)) ##note : the Lattice plots are objects of class trellis

## Very similar example with a 2-panel plots
set.seed(10)
x = rnorm(100)
f = rep(0:1, each=50)
y = x + f - f * x +rnorm(100, sd=0.5)
f = factor(f, labels=c("group 1", "group 2"))
xyplot(y~x | f, data=airquality, layout=c(2,1)) 

##Custom panel function
xyplot(y~x | f, data=airquality, panel=function(x,y,...) {
  panel.xyplot(x,y,...)
  panel.abline(h=median(y), lty=2) ##adding a line in each panel to display the median
}) 

##Custom panel function
xyplot(y~x | f, data=airquality, panel=function(x,y,...) {
  panel.xyplot(x,y,...)
  panel.lmline(x, y, col=2) ##adding a line in each panel to display the linear regression line
  
})