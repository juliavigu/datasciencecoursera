# Coursera R Programming 
# week 4 Project, part 4
# returns a 2-column data frame containing the hospital in 
# each state that has the ranking specied in num.


setwd("C:/Users/rmjljvi/Desktop/datasciencecoursera")

install.packages("dplyr")
library(dplyr)

#Suppress warnings
options(warn=-1)

#Function
rankall<-function(outcome, num="best"){
  ##Read outcome data
  dat<-read.csv("outcome-of-care-measures.csv")
  
  ##Check that outcome is valid, or stop function othe rwise
  if (! (outcome=="heart attack" || outcome=="heart failure" || outcome=="pneumonia")){
    stop("invalid outcome")
  }
 
  ##Create vector for all state names
  statesvector<-subset(dat$State, (!is.na(dat$State)))
  uniquestatesvector<-unique(statesvector)
  
  ##Create empty matrix output
  outputm<-data.frame(NA,length(uniquestatesvector),2)
  colnames(outputm)<-c("hospital", "state")
  
  ##For each state, find out the ranked hospital name
  for (state in uniquestatesvector) {
    #For each state, create state subset
    statedat<-subset(dat, State==state)
    #Find the name of the hospital in the specified ranking
    
    ##For each of the outcomes
    if (outcome== "heart attack") {o<-11}
    if (outcome== "heart failure") {o<-17}
    if (outcome== "pneumonia") {o<-23}
    ##The best hospital is...
    if (num == "best") { num<-1
      #outputm[(which(uniquestatesvector %in% state)), 1]<-statedat[which.min(statedat[,o]), 2] #set hospital name
     # outputm[(which(uniquestatesvector %in% state)),2]<-state #set state name
    }
    ##The worst hospital is...
    if (num == "worst") {
      outputm[(which(uniquestatesvector %in% state)), 1]<-statedat[which.max(statedat[,o]), 2]
      outputm[(which(uniquestatesvector %in% state)),2]<-state
    } else {
      ##the #th hospital is...
      ###transform outcomes to numeric
      statedat[,c(11,17,23)]<-sapply(statedat[,c(11,17,23)], as.numeric)
      ###exclude NA's for outcome
      Cstatedat<-subset(statedat, !is.na(statedat[,o]))
      ###return NA if ranking asked is larger than the number of hospitals in that state with data for this outcome
      if (num > length(Cstatedat) || num < 1 ){
        return(NA)
      } else {
        #rank hospitals from best to worst
        Cstatedatorder<- Cstatedat[c(order(Cstatedat[,2])),]
        Cstatedatorderrank<-Cstatedatorder[c(order(Cstatedatorder[,o])),]
        Cstatedatorderrank$Rank<-c(1:nrow(Cstatedat))
        dataofrank<-subset(Cstatedatorderrank, Cstatedatorderrank$Rank == num)
        outputm[(which(uniquestatesvector %in% state)),1]<-dataofrank[1,2]
        outputm[(which(uniquestatesvector %in% state)),2]<-state
        
      }
    }
  }
  

  #Return data frame with hospital names and state name
outputm
  
}

#Trial runs
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
  