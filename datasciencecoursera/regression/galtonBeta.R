library(UsingR)
library(ggplot2)
data(galton)
y <- galton$child - mean(galton$child)
x <- galton$parent - mean(galton$parent)
freqData <- as.data.frame(table(x,y))
names(freqData) <- c("child", "parent","freq")
freqData$child <- as.numeric(as.character(freqData$child))
freqData$parent <- as.numeric(as.character(freqData$parent))
myPlot <- function(β){
  g <- ggplot(as.data.frame(filter(freqData, freqData$freq > 0)),aes(x=freqData$parent,y=freqData$child))
  g <- g + scale_size(range = c(2,20), guide = "none")
  g <- g + geom_point(colour = "grey50", aes(size=freqData$freq+20,show_guide=FALSE))
  g <- g + geom_point(aes(colour = freqData$freq, size = freqData$freq))
  g <- g + scale_colour_gradient(low="lightblue", high = "white")
  g <- g + geom_abline(intercept = 0, slope = β, size = 3)
  mse <- mean((y-β*x)^2)
  g <- g + ggtitle(paste("β = ",β," mse = ",round(mse,3)))
  g
}
manipulate(myPlot(beta), beta = slider(0.6,1.2,step = 0.02))


