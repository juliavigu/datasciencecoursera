#Datasciencecourse
#R programming  module
#week2
#assignment 1
#part3

corr<-function(directory,threshold=0) {
  # 1. List files in desired directory
  studyfiles<- list.files(directory) 
  #Create empty vector of no length
  vector<- c()
  
  #2. iterate for each file in study files
  for (i in 1:length(studyfiles)) { 
    
    # 2.1 Open the file
    open_file<-read.csv(file.path(directory,studyfiles[i] ))
    # 2.2 Condition to calculate correlation: complete cases have to be above threshold
    runit <- sum(complete.cases(open_file))> threshold
    # 2.3. If file condition is satisfied...calculate correlation
    if (runit){ 
      clean_open_file<-open_file[complete.cases(open_file),] #only for the observations that do have data
      vector[i]<-cor(clean_open_file$nitrate, clean_open_file$sulfate) #populate vector with the correlation value
      }
    } 
  
  #output
  vector
  }
