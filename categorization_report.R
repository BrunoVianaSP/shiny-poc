getCategorizationReportTable <- function() {
  
  dataset <- read.csv("categorization.csv", sep = ",", header=T)
  dataset
}

getCategorizationReportPlot <- function() {
  
  dataset <- read.csv("categorization.csv", sep = ",", header=T)
  
  print(dataset)
  
  plot(x = dataset$date, y = dataset$action)
  
  # return(list(dataset$date, dataset$action))
}