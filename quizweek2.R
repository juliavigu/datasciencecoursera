#Coursera course Getting and Cleaning data
#week 2
#quiz

#QUESTION 1

install.packages("jsonlite")
library(jsonlite)
install.packages("httpuv")
library(httpuv)
install.packages("httr")
library(httr)

# 1. Find OAuth settings for github:
oauth_endpoints("github") #endpoints are URLs that we call to request the authorization codes. 

# 2. Make my own application on github API
#Go to git hub, settings, developer settings, new github app: 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url


#    Replace key and secret below according to my app
myapp <- oauth_app("github",
                   key = "743036b8a7142eb6f70f",
                   secret = "617d60d44c2bb4af30a16bdf26b0d5d42d012ab0"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken) #request to extract data from the link

#extract content from link
json1 = content(req)

#structure info from json file into a more readable version
json2 = jsonlite::fromJSON(jsonlite::toJSON(json1))

#Now from this data frame called json2 which is in jsonlite format, we want to extract 
#on the time that the datasharing repo was created. 
json2[1, 1:10] #we can see there is a column called fullname which describes the different pushes to the repo
json2[json2$full_name == "jtleek/datasharing", "created_at"] #we subset to find the row of the push that
#shows us the data and time of the event when jtleek pused a commit to datasharing that said created at.

#QUESTION 2
#They have given us a link to an online doc, we can automatically download it
install.packages("RMySQL", type="source") 
library(RMySQL)
install.packages("sqldf") 
library(sqldf)
#Download  data into R
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" #save url link
download.file(url, destfile="./doc.csv") #download doc from link and save it inside the wd 
acs<- read.table("./doc.csv", sep=",", header=TRUE) #read data
View(acs)
#we can use the sqldf to send queries
#if we want to obtain a subset of the acs dataframe where we only get column pwgtp1 for ages less than 50
acs2 <- sqldf("select pwgtp1 from acs where AGEP < 50")

#QUESTION 3
# the equivalent of the function unique in the sql package is distinct
sqldf("select distinct AGEP from acs2") #will get us a list of the pwgtp1 rows with unique AGE values

#QUESTION 4
#Reading from html link
con=url ("http://biostat.jhsph.edu/~jleek/contact.html") #open connection with link
htmlCode=readLines(con) #read the info
close(con) #important to close the connection
#number of characters in the 10th, 20th, 30th, 100th lines of the imported data
nchar(htmlCode[c(10,20,30,100)])

#QUESTION 5
#read in the data set into R, data comes from a random link
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for" #save url link
download.file(url, destfile="./doc5") #download doc from link and save it inside the wd 
dataq5<- read.table("./doc5", sep=",") #read data, but this is a fixed width file format, so we need diff extraction method
dataq5 <- read.fwf("./doc5",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4) #we need to specify the widths
#because they have not been specified 
## skip =4 is for skipping the first 4 lines
#-1 -> leaves one blank(if you open the .for file in n++, you will see the space before 03JAN1990)
# 9 -> length of the date, 
# -5 -> leaves 5 blank, 
#4 ->takes the first Nino1+2 SST input
#4 -> takes the second Nino1+2 SST input and so on. 
sum(dataq5[, 4]) 



