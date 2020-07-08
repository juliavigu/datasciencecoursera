#Getting and Cleaning data module
#Week 4 quiz
#question 1
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile="./USsurvey.csv")
dat1<-read.csv("USsurvey.csv")
names(dat1) #we can see there are many variables names wgtpXX vars 109:188, we want to split all the names
splitnames<-strsplit(names(dat1),split="wgtp")  #we take all names of dat1 vars and split the characters wgtp out of them
splitnames[123] #we search for the value of element 1123

#question2
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="./gdpdata.csv")
dat2<-read.csv("gdpdata.csv", skip=4)
dat2$X.4<-gsub( ",","" , dat2$X.4) #remove commas from millions
class(dat2$X.4) #class is character
mean(as.numeric(dat2$X.4[1:190], na.rm=TRUE)) #transform class to numeric, remove NAs, and calculate mean gdp for the 190 countries

#question3
#variable x.3 contains country names. how many of them begin with the word United?
grep("^United", dat2$X.3) #will return the positions in the vector X.3 where the element starts with united. 
#there are 3 countries that begin with united
dat2$X.3[grep("^United", dat2$X.3)] #this will tell us which!

#question 4
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="./gdpdata2.csv")
dat3a<-read.csv("gdpdata.csv", skip=4, nrows=190)

url2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url2, destfile="./edudata.csv")
dat3b<-read.csv("edudata.csv")

#merge dat3a and dat3b based on the country code
dat3merged<-merge(dat3a, dat3b, by.x="X", by.y="CountryCode")
#some countries have info on the fiscal year end date
sum(grepl("Fiscal year end", dat3merged$Special.Notes))#there are 31 countries that have "fiscal year end" info
#how many ended in june?
grep("(Fiscal year end)+(.*)+([Jj]une)", dat3merged$Special.Notes)
sum(grepl("(Fiscal year end)(.*)([Jj]une)", dat3merged$Special.Notes)) #13 have "fsical year end" and "june" in it. 

#question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
#this is about dates, so lets install lubridate
install.packages("l
                 ubridate")
library(lubridate)
samples2012<-grep("2012", sampleTimes)
sum(grepl("2012", sampleTimes)) #250 observations have the number 2012 in it
#lets create vector with the weekdays of each observation
sampledays<-wday(sampleTimes, label=TRUE)[grepl("2012", sampleTimes)] #but we subset for those obs in 2012 only
sum(grepl("Mon", sampledays)) #how many of the obs in 2012 also happened on Mon?

