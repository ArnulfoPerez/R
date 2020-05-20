suppressPackageStartupMessages(library(googleVis))

M <- gvisMotionChart(Fruits, "Fruit", "Year",
                     
                     options=list(width=600, height=400))
plot(M)

print(M,"chart")

library(googleVis)
demo(googleVis)

df=data.frame(country=c("US", "GB", "BR"), 
              val1=c(10,13,14), 
              val2=c(23,12,32))
Line <- gvisLineChart(df)
plot(Line)


M <- gvisMotionChart(Fruits, "Fruit", "Year",
                     
                     options=list(width=600, height=400))
plot(M)

Motion=gvisMotionChart(Fruits, 
                       idvar="Fruit", 
                       timevar="Year")
plot(Motion)

suppressPackageStartupMessages(library(googleVis))
plot(gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400)))