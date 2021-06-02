#Example code for week 4
source ("http://bit.ly/dasi_inference")
paul = factor(c(rep("yes",8), rep ("no",0)), levels = c("yes", "no"))
inference (paul, est = "proportion", type = "ht", method = "simulation", 
           success = "yes", null=0.5, alternative = "greater")

back = factor(c(rep("correct",11), rep ("incorrect",1)))
inference (back, est = "proportion", type = "ht", method = "simulation", 
           success = "correct", null=0.1, alternative = "greater", nsim = 100)

#Calculation p value for Chisquare test
##Chiquare statistic=22.64 and df=4
pchisq (22.64, 4, lower.tail = FALSE)

loseweight = factor(c(rep("yes",225), rep ("no",275)), levels = c("yes", "no"))
inference (loseweight, est = "proportion", type = "ht", method = "simulation", 
           success = "yes", null=0.55, alternative = "twosided")
