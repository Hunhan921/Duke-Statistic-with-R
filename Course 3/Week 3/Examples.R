#load data
install.packages("DAAG")
library(DAAG)
data("allbacks")
library(statsr)
library(dplyr)
library(ggplot2)

#fit model
book_mlr <- lm(weight ~ volume + cover, data = allbacks)
summary(book_mlr)

#R square
states = read.csv("http://d396qusza40orc.cloudfront.net/statistics/lec_resources/states.csv")
#fit model
pov_slr = lm(data = states, poverty ~ female_house)
summary(pov_slr)
anova(pov_slr)

#load data 
cognitive = read.csv("http://bit.ly/dasi_cognitive")
#full model
cog_full = lm(kid_score ~ mom_hs + mom_iq + mom_work + mom_age, data = cognitive)
summary(cog_full)

#Calculate p value 
pt(2.201, df=429, lower.tail = FALSE)*2

#Calculate T-score
qt(0.025, df=429)

#Final model w R^2 as criteria
cog_final = lm(data = cognitive,kid_score ~ mom_hs + mom_iq + mom_work)

#checking linearity of x and y
plot(cog_final$residuals ~ cognitive$mom_iq)
#checking normal residual w histogram or QQ
hist(cog_final$residuals)
qqnorm(cog_final$residuals)
qqline(cog_final$residuals) #Adding the line comparing with qqnorm
#Checking constant variablity of residuals
plot(cog_full$residuals ~ cog_full$fitted.values)
plot(abs(cog_full$residuals) ~ cog_full$fitted.values)
#Checking independent residuals based on 
