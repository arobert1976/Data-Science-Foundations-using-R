library(datasets)

##-------------------------------------------------------------------------------------------------------------------------
##When using the base plotting system, one first has to create the plot then annotate it (add lines, points, text, legends)
##-------------------------------------------------------------------------------------------------------------------------
hist(airquality$Ozone, lwd=10, col=10) ##histogram

with(airquality, plot(Wind, Ozone, pch=3)) ##scatterplot with + instead of default o
title(main = "my title") ##scatterplot with title
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue")) ##kind of replot the subset with a different color
legend("topright", pch=3, col=c("blue","black"), legend=c("May","Other months")) ##adding a legend
model = lm(Ozone~Wind, airquality)
abline(model, lwd=2)

x = rnorm(100)
y = rnorm(100)
g = gl(2,50, labels=c("Male","Female"))
plot(x,y,type="n") ##plot is created but points are not displayed
points(x[g=="Male"], y[g=="Male"], col="blue") ##adds the "male" points in blue
points(x[g=="Female"], y[g=="Female"], col="red") ##adds the "female" points in red

airquality = transform(airquality, Month=factor(Month))
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone", lty=2) ##boxplot
## check ?par for important graphics parameters
par("bg") ##gives the default background color
par("mar") ##gives the default margins
par("mfrow") ##gives the default nb_col and nb_rows  

par(mfrow=c(1,2)) #1 row, 2 cols
with(airquality, {
    plot(Wind, Ozone, main="ozone and wind")
    plot(Solar.R, Ozone, main="ozone and solar radiation")  
})

##-------------------------------------------------------------------------------------------------------------------------
##When the graphic device is not the screen but a file, one need to open the graphics device, make a plot and close the graphics device
##-------------------------------------------------------------------------------------------------------------------------
pdf(file="myplot.pdf") ##opens PDF device
airquality = transform(airquality, Month=factor(Month))
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone", lty=2)
dev.off() ##closes PDF device