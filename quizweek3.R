#Getting and cleaning data coursera 
#week 3
#quiz
setwd("C:/Users/rmjljvi/Desktop/datasciencecoursera/Getting and cleaning data week 3")
install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)
#question 1
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./quiz3data")
mydf<-read.csv("quiz3data")
#names(mydf)
agricultureLogical<-(mydf$ACR==3 & mydf$AGS==6)
which(agricultureLogical)

#question2
install.packages("jpeg")
library(jpeg)
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, destfile = "./quiz3pic.jpg", mode="wb")
mypic<-readJPEG("quiz3pic.jpg", native=TRUE)
quantile(mypic, probs=c(0.3, 0.8))
  

#question3
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile = "./quiz3gdpdat")
#The dataset has empty rows at the beginning and spaces have to be specified
gdpdat<-read.csv("quiz3gdpdat", skip=4, nrows=190)

#This dataset seems alreayd tidy
url2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url2, destfile = "./quiz3edudat")
edudat<-read.csv("quiz3edudat")
mergeddat<-merge(edudat, gdpdat, by.x="CountryCode", by.y="X")
dim(mergeddat)
sortedmergeddat<-arrange(mergeddat, desc(X.1))
sortedmergeddat[13,1]

#question4
unique(mergeddat$"Income.Group")
tapply(mergeddat$X.1, mergeddat$"Income.Group",mean)

#Why did this not woooork?
#byincome<- group_by(mergeddat, Income.Group)
#summarise(byincome, mean(mergeddat$X.1))

#question5
mergeddat$rankquantiles=cut(mergeddat$X.1, breaks=5)
table(mergeddat$rankquantiles, mergeddat$Income.Group)
                 
