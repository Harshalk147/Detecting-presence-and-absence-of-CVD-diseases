getwd()
setwd('C:/IALY/New folder')
data<-read.csv("cardio_train.csv",sep = ";")
data<-data[-c(1)]
library(psych)
str(data)
describe(data)
library(ggplot2)
library(ggpubr)
library(dplyr)

a <- ggplot(data, aes(x = age/365))

# Change line color by sex
a + geom_histogram(aes(color = as.factor(cardio)), fill = "white", 
                   position = "dodge") +
  scale_color_manual(values = c("#00AFBB", "#E7B800")) 
# change fill and outline color manually 
a + geom_histogram(aes(color = factor(cardio), fill = factor(cardio)),
                   alpha = 0.2, position = "dodge") +
  scale_fill_manual(values = c("#00AFBB", "#E7B800")) +
  scale_color_manual(values = c("#00AFBB", "#E7B800"))+xlab("Age")+ylab("Count")



ggplot(data, aes(x = as.factor(data$cholesterol), fill = as.factor(data$cardio))) + geom_bar(position = position_dodge()) +theme_classic()
ggplot(data, aes(x = as.factor(data$gluc), fill = as.factor(data$cardio)))+geom_bar(position = position_dodge())+theme_classic()



# Check for missing values in dataset

sum(is.na(data))

# Removing outliers
dim(data)
d=c(data$height,data$weight)

print(sum((data$height<quantile(data$height,0.025) | data$height>quantile(data$height,0.975) )))

library(dplyr)

data<-data %>% filter(between(data$height, quantile(data$height, .025), quantile(data$height, .975)))
dim(data)
data<-data %>% filter(between(data$weight, quantile(data$weight, .025), quantile(data$weight, .975)))
dim(data)


blood_pressure=data.frame(c(data$ap_lo,data$ap_hi))

print(sum(data$ap_lo>data$ap_hi))

data<-data %>% filter(between(data$ap_hi, quantile(data$ap_hi, .025), quantile(data$ap_hi, .975)))
dim(data)
data<-data %>% filter(between(data$ap_lo, quantile(data$ap_lo, .025), quantile(data$ap_lo, .975)))
dim(data)
data['BMI']=data["weight"]/ (data["height"]/100)**2
head(data)

data[c(1,3,4,5,6,13)] <- lapply(data[c(1,3,4,5,6,13)], function(x) c(scale(x)))


data$gender <- ifelse(test = data$gender==1, yes = '1', no = "0")
data$gender <-as.factor(data$gender)
head(data)

str(data)

data$cholesterol <-as.factor(data$cholesterol)
data$gluc <-as.factor(data$gluc)
data$smoke<-as.factor(data$smoke)
data$alco <-as.factor(data$alco)
data$active<-as.factor(data$active)
data$cardio <-as.factor(data$cardio)

str(data)

data
# Splitting traing and testing data
smp_siz = floor(0.80*nrow(data))
smp_siz
set.seed(123)

train_ind = sample(seq_len(nrow(data)),size = smp_siz) 
train =data[train_ind,]
test=data[-train_ind,]

x_train <- model.matrix(cardio~. , train)[,-2]
y_train <- train$cardio
y_train
dim(x_train)
x_test <- model.matrix(cardio~. , test)[,-2]
y_test <- test$cardio
dim(y_train)
library(randomForest)
require(caTools)

rf<-randomForest(x_train,y_train)
rf
pred <- predict(rf, newx = x_test)
final <- cbind(y_test, pred)
library(e1071)

model=naiveBayes(x_train,y_train)
model
Predictions=predict(model,x_test)
final <- cbind(y_test, Predictions)

table(Predictions,y_test)

library(xgboost)
library(readr)
library(stringr)
library(caret)

xgb.fit <- xgboost(data = data.matrix(x_train), 
               label = train$cardio, 
               eta = 0.1,
               max_depth = 15, 
               nround=139, 
               subsample = 0.5,
               colsample_bytree = 0.5,
               seed = 1,
               eval_metric = "merror",
               objective = "multi:softprob",
               num_class = 12,
)

Predictions=predict(xgb.fit,x_test)
final <- cbind(y_test, Predictions)


