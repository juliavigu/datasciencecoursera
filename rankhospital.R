#R programming course
#Programming Assignment 3

setwd("C:/Users/rmjljvi/Desktop/datasciencecoursera")

install.packages("dplyr")
library(dplyr)

#Suppress warnings
options(warn=-1)

#Ranking hospitals by outcome in a state
rankhospital<-function(state, outcome, num="best"){
  ##Read outcome data
  dat<-read.csv("outcome-of-care-measures.csv")
  
  ##Check that state and outcome inputs are valid, or stop function otherwise
  if(! (state %in% levels(factor(dat$State)))){
    stop("invalid state")
  }
  
  if (! (outcome=="heart attack" || outcome=="heart failure" || outcome=="pneumonia")){
    stop("invalid outcome")
  }
  
  ##Output: return hospital name within the specified state with the given ranking
  ##For the state of interest
  statedat<-subset(dat, State==state) #this will eliminate observations with NA for State
  ##For each of the outcomes
  if (outcome== "heart attack") {i<-11}
  if (outcome== "heart failure") {i<-17}
  if (outcome== "pneumonia") {i<-23}
  ##The best hospital is...
  if (num == "best") {
      hospitalname<-statedat[which.min(statedat[,i]), 2] #which.min directly omits NAs
  }
  ##The worst hospital is...
  if (num == "worst") {
          hospitalname<-statedat[which.max(statedat[,i]), 2]#which.max directly omits NAs
    } else {
  ##the #th hospital is...
    ###transform outcomes to numeric
    statedat[,c(11,17,23)]<-sapply(statedat[,c(11,17,23)], as.numeric)
    ###exclude NA's for outcome
    Cstatedat<-subset(statedat, !is.na(statedat[,i]))
    ###return NA if ranking asked is larger than the number of hospitals in that state with data for this outcome
    if (num > length(Cstatedat) || num < 1 ){
      return(NA)
    } else {
      #rank hospitals from best to worst
      Cstatedat<- Cstatedat[order(Cstatedat[,i]),]
      hospitalname<-Cstatedat[num, ]$Hospital.Name
    }
  }
  #return hospital name with the ranking asked
  hospitalname
}

#Trials to see if it is correct
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
