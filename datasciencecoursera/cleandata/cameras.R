f (!file.exists("data")) {dir.create("data")}

fileURL <- "https://data.baltimorecity.gov/api/views/h5i4-nb9a/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv", method = "auto")
#method curl did not worked

list.files("./data")

dateDownloaded <- date()
dateDownloaded

#cameraData <- read.table("./data/cameras.csv",sep=",",header=TRUE)
cameraData <- read.table("./data/cameras.csv",sep=",",header=TRUE, comment.char="")
head(cameraData)

names(cameraData)
