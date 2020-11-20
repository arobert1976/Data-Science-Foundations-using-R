library(ggplot2) # ggplot2 is an implementation of the Grammar of Graphics
str(mpg)
 
#qplot stands for quick plot. Syntax somewhere between base and lattice. Gives nice plots but difficult to customize if you need to
#in that case, better use full ggplot2 power in that case
qplot(displ, hwy, data=mpg) # syntaxe proche de plot() mais résultat différent (grille, labels, petits points)
qplot(displ, hwy, data=mpg, color=drv) # adds colors and legend automatically
qplot(displ, hwy, data=mpg, color=drv, geom=c("point","smooth")) # to display the plots + a smooth line

qplot(hwy, data=mpg, fill=drv) # plots an histogram as there is only one variable hwy

qplot(displ, hwy, data=mpg, facets=.~drv) # displays facets (facet = panel in lattice)
qplot(hwy, data=mpg, facets=.~drv, binwidth=2) # histogram with facets 1 row and 3 columns
qplot(hwy, data=mpg, facets=drv~., binwidth=2) # histogram with facets 3 rows and 1 column

#basic components of ggplot2 plot
#aesthetic mappings (color, size) + geoms (points, lines, ...) + facets + stats (binning, quantiles, smoothing) 
#+ scales (what scale an aesthetic map uses? e.g. male=red and female=blue) + coordinate system
g = ggplot(mpg, aes(displ, hwy)) #print(g) does not display the plot
p = g + geom_point() #print(p) displays the plot
g + geom_point() #also works (auto-print) but ggplot object is not saved
g + geom_point() + geom_smooth() # adds a layer
g + geom_point() + geom_smooth(method="lm")
g + geom_point() + geom_smooth(method="lm") + facet_grid(.~drv) # adds another layer
#customization is possible if default behavior does not fulfill one's expectation 
#e.g. xlab(), theme(legend.position="none"), theme_bw(), the geom functions have options
g + geom_point(color="steelblue", size=4, alpha=1/2)
g + geom_point(aes(color=drv), size=4, alpha=1/2)
g + geom_point(aes(color=drv), size=4, alpha=1/2) + labs(title="MY TITLE") + labs(y="my Y label")

#managing axis limits
x = rnorm(n=100)
y = rnorm(n=100)
y[50] = 100 # adding an outlier
df = data.frame(x,y)
g = ggplot(df, aes(x, y))
g + geom_line() ##outlier is included so it's hard to analyze the normal data
g + geom_line() + ylim(-3,3) # removes the outlier so only 99 points are displayed
g + geom_line() + coord_cartesian(ylim=c(-3,3)) # is an alternative if you want to show that there is an outlier

