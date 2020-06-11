#R programming course
#Programming Assignment 3

setwd("C:/Users/rmjljvi/Desktop/datasciencecoursera")

install.packages("dplyr")
library(dplyr)

options(warn=-1)


#1. Load outcome of care measures doc and investigate it
outcome<-read.csv("outcome-of-care-measures.csv", colClasses="character") #we originally read the data as characters
head(outcome)
ncol(outcome)
names(outcome)
outcome[,11]<-as.numeric(outcome[,11]) #here we ask to consider column 11 as numeric

#Column 11 is the 30 day mortality rates for heart attack. We can plot the histogram for frequency of events in each hospital
hist(outcome[,11])

#2. Finding the best hospital in a state
best<- function(state, outcome){
  
  #Read outcome data
  dat<-read.csv("outcome-of-care-measures.csv")
  
  #Check that state and outcome inputs are valid, or stop function otherwise
  if(! (state %in% levels(factor(dat$State)))){
    stop("invalid state")
  }
  
  if (! (outcome=="heart attack" || outcome=="heart failure" || outcome=="pneumonia")){
    stop("invalid outcome")
  }
  
  #Return hospital name in that state with the lowest 30 day death rate
  ##For the state of interest
  statedat<-subset(dat, State==state)
  ##The best hospital is...
  if (outcome== "heart attack") {
    besthospital<-statedat[which.min(statedat[,11]), 2]
  } 
  if (outcome=="heart failure") {
    besthospital<-statedat[which.min(statedat[,17]), 2]
  }
  if (outcome=="pneumonia") {
    besthospital<-statedat[which.min(statedat[,23]), 2]
  }
  ##Output: return hospital name within the specified state with the minimum death rates
 besthospital
}
