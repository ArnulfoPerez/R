require(datasets)
require(stats)
require(ggplot2)
data("InsectSprays")

g <- ggplot(data = InsectSprays,aes(y=count,x=spray,fill=spray))
g <- g + geom_violin(colour="black",size=2)
g <- g + xlab("Type of spray") + ylab("Insect count")
g