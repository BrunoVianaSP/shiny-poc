# load the package that contains the full dataset and the data viz package.
dataset <- read.csv("categorization.csv", sep = ",", header=T)


# splitting the dataset into the training set and test set
# install.packages('caTools')
library(caTools)
set.seed(123)
#
split = sample.split(dataset$offer,
                     SplitRatio = 2/3) # need pass only dependent variable

trainingSet = subset(dataset, split==TRUE)
testSet = subset(dataset, split==FALSE)

# fitting simple linear regression to training set
# regressor = lm(formula = offer ~ year, data = trainingSet)

regressor <- lm(year ~ demand + offer + import, data=trainingSet)



# prediction
yPred = predict(regressor, newdata = testSet)

library(ggplot2) # for some nice looking graphs!
# Trainint set results visualization
ggplot() +
  geom_point(aes(x= trainingSet$year, y = trainingSet$offer),
             colour = 'red') +
  geom_line(aes(x=trainingSet$year, y = predict(regressor, newdata = trainingSet)),
            colour = 'blue') +
  ggtitle('Ano vs Oferta (Base de treinamento)')+
  xlab('Anos de Empresa') +
  ylab('Oferta')



# library(ggplot2) # for some nice looking graphs!
# Test set results visualization
ggplot() +
  geom_point(aes(x= testSet$year, y = testSet$offer),
             colour = 'red') +
  geom_line(aes(x=trainingSet$year, y = predict(regressor, newdata = trainingSet)),
            colour = 'blue') +
  ggtitle('Ano vs Oferta')+
  xlab('Anos de Empresa') +
  ylab('Oferta') + 
  scale_x_continuous(breaks = pretty(dataset$year, n = 1))





