#R functions

#Let's try a very simple addition function

add2values <- function(x,y) {
    x+y
}

#Once the function is specified, we can use it
add2values(2,2)

#let's try another function that extracts the elements of a vector that are above 10
above10<- function(x) {
  use <- x>10
  x[use]
}

#imagine now we want to create a function that extracts elements that are above a specified number, that may be differnt every time
above<- function(x,n) {
  use <- x>n
  x[use]
}

#Lets try to use this last functions!
x<- 1:20
above10(x)
above(x,12)

#or we can speficy default values, where thee user does not need to specify the values
above<- function(x,n=10) { 
  use <- x>n
  x[use]
}

#let's try a loop function

columnmean<- function(x) {
  nc<-ncol(x)  #first we create a variable that stores the number of columns of the matrix x
  means<-numeric(nc) #we initialise a numeric vector that will store the means for each column, at first it just contains 0s
  for (i in 1:nc) {
    means[i]<-mean(x[,i]) #now for each column, we will store its mean  in our vector called mean
  }
  means #prints vvalue
}

#Let's see if this function works using the airquality dataset
columnmean(airquality)
#function without NAs
columnmean<- function(x, removeNA=TRUE) {
  nc<-ncol(x)  
  means<-numeric(nc) 
  for (i in 1:nc) {
    means[i]<-mean(x[,i], na.rm=removeNA) 
  }
  means 
}

columnmean(airquality) #now we get the means for each columnN!