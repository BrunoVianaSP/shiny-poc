getCategorizationReportTable <- function() {
  
  dataset <- read.csv("categorization.csv", sep = ",", header=T)
  dataset
}

getCategorizationReportPlot <- function() {
  
  dataset <- read.csv("categorization.csv", sep = ",", header=T)
  
  for (index in 1:nrow(dataset)) {
    
  }
  
  
  # hist(dataset$date)
  
  # plot(x = dataset$date,  xlab = "Date", y = dataset$action, ylab = "Action", type="l" )
  
  # plot(data = dataset, x = dataset$date,  xlab = "Date", y = dataset$action, ylab = "Action", type="l" )
  
  matplot(dataset[, 2], dataset[, -2], type="l" )
  
  # return(list(dataset$date, dataset$action))
}