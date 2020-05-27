#Datasciencecourse
#R programming  module
#week2
#assignment 1
#part2

complete<- function(directory, id) {
  
  # 1. List files in desired directory
  monitorfiles<- list.files(directory) 
  
  # 2. Subset list of files according to id
  studyfiles<- monitorfiles[id] #select the files that we are interested in (those in id vector)
  
  #Initiate empty data frame
  table<- matrix(0, nrow=length(id), ncol=2)
  colnames(table)<-c("id", "nobs")
  
  #For loop over selected files to populate output table
  for (i in 1:length(studyfiles)) {
  fitxer <- studyfiles[i]
  #  4.1 Open the file
  fitxer_obert<-read.csv(file.path(directory, fitxer))
  #  4.2 Populate first column with ID value
  table[i,1]<- fitxer_obert$ID[i]
  #Populate second column with number of complete cases
  number_complete_observations<-sum(complete.cases(fitxer_obert))
  table[i,2]<- number_complete_observations
  
} 
  
  #Output
  table
  
}
