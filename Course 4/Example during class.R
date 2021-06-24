library(tidyverse)
library(statsr)

#Calculate the likelihood
p<- seq(from=0.1, to=0.9, by=0.1)
prior <- c(rep(0.06, 4), 0.52, rep(0.06, 4))
likelihood <- dbinom(4, size = 20, prob = p)

#Calculating the posterior
numerator <- prior*likelihood
denominator <- sum(numerator)
posterior <- numerator / denominator
sum(posterior)

p <- c(0.2, 0.4, 0.5, 0.6, 0.8)
prior <- c(rep(0.125, 4), 0.5, rep(0.125, 4))
likelihood <- dbinom(3, size = 3, prob = p )
likelihood

#Week 2
#Question: Assume that the number of Academy Award winners who
#die in a month has the Poisson distribution with mean 1.5.  What is the
#probability that two or more Academy Award winners die next month?
#P[2 or more] = 1 - P[ 0 or 1 die] = 1 - (1.5^0/0!)
#exp(-1.5) - (1.5^1/1!) exp(-1.5) 
1-(1.5^0/factorial(0))*exp(-1.5) - (1.5^1/factorial(1))*exp(-1.5)

#Week 2 practice quiz 
#Suppose that you sample 24 M&Ms from a bag and find that 3 of them are yellow. 
#Assuming that you place a Beta(1,1) prior on the proportion of yellow M&Ms pp, 
#what is the posterior probability that p < 0.2p<0.2
pbeta(q=0.2, shape1 = 1+3, shape2 = 1+24-3)

#posterior having 1 tail after having 2 tail is 

