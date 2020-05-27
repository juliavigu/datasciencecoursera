#Datasciencecourse
#R programming  module
#week2
#assignment 1
#part1

pollutantmean <- function(directory,pollutant,id){
  
  # 1. List files in desired directory
  monitorfiles<- list.files(directory) 
  
  # 2. Subset list of files according to id
  
  studyfiles<- monitorfiles[id] #select the files that we are interested in (those in id vector)
  
  # 3. Initiate 2 vectors: sums- recording the sum in each file and lengths- number of elements in the file
  
  sums_c<- numeric(length(id)) #initiate empty vector to store the sums of the pollutant columns in each file
  lengths_c<- numeric(length(id))  #initiate empty vector to store the number of observations of the pollutant columns in each file
  
  # 4. For loop over selected files in which we:
  
  for (i in 1:length(studyfiles)) {
    fitxer <- studyfiles[i]
    #  4.1 Open the file
    fitxer_obert<-read.csv(file.path(directory, fitxer))
    #  4.2 Select column
    temp_col <- fitxer_obert[pollutant]
    #  4.3 Update vectors
    runit <- !all(is.na(temp_col))  #do not run if all values are missing
    if (runit){ #if there are any non NAs, run
      sums_c[i] <- sum(temp_col, na.rm = TRUE) #populate sum vector
      lengths_c[i] <- sum(!is.na(temp_col)) #populate length vector
    }
    
  } 
  
  # 5. Sum elements of "sums" and "lengths" and return the division of both additions
  finalsum<- sum(sums_c)
  finallength<- sum(lengths_c)
  finalmean<- finalsum/finallength
  
  # Output: integer with the mean of values
  finalmean
}


