---
title: "Exploring the BRFSS data"
output: 
  html_document: 
    fig_height: 4
    highlight: pygments
    theme: spacelab
---

## Setup

### Load packages

```{r load-packages, message = FALSE}
library(ggplot2)
library(dplyr)
```

### Load data

```{r load-data}
setwd("C:\\Users\\hunhan925\\Week 5")
load("brfss2013.RData")
```



* * *

## Part 1: Data

Observations collection method: State health departments use in-house interviewers or contract with telephone call centers or universities to administer the BRFSS surveys continuously through the year. The states use a standardized core questionnaire, optional modules, and state-added questions. The survey is conducted using Random Digit Dialing (RDD) techniques on both landlines and cell phones. In conducting the BRFSS landline telephone survey, interviewers collect data from a randomly selected adult in a household. In conducting the cellular telephone version of the BRFSS questionnaire, interviewers collect data from an adult who participates by using a cellular telephone and resides in a private residence or college housing.

Scope of inference: generalizability: Data analysist has to use weighting technique to generalize the result. And the result got from this data sample can not have causality value because the design of this study is crossectional and all the data was asked at the sametime, we dont know which happened first and later.    
* * *

## Part 2: Research questions

**Research question 1: Exploring the relationship between a child having asthma and the history of their mother/father having asthma** <br />
In this question, I want to see the effect of family's history in asthma, whether or not having a connection between a child and his/her parent in terms of having asthma. 

**Research question 2: Exploring the relationship between the number of children in a household and experiencing a stroke diagnosis grouped by gender of stroke survivors**<br />
I start with a null hypothesis that there is no relationship between the number of children in a household and having a stroke. That begins with the idea of stress in raising children of some parents. And stress can be a factor leading to experiencing a stroke.

**Research question 3: Exploring the relationship between daily taking aspirin and experiencing stroke diagnosis grouped by six age groups**<br />
This question I have no prior knowledge about the relationship between aspirin and stroke. I just come up with a new hypothesis and want to discover it.


* * *

## Part 3: Exploratory data analysis


**Research quesion 1:**

```{r}
names(brfss2013)
grep ("asthnow", names(brfss2013), value = TRUE)
grep("casthno2", names(brfss2013), value = TRUE)
grep("rcsrltn2", names(brfss2013), value = TRUE)
```
Define variable being analyzed. 3 variables are selected, asthnow "Still Have Asthma - Has a doctor, nurse, or other health professional ever told you that you had any of the following", casthno2 "Child Still Have Asthma", rcsrltn2 "Relationship To Child"  
```{r}
brfss2013 %>%
  group_by (asthnow) %>%
  summarise(count=n ())
brfss2013 %>%
  group_by (casthno2) %>%
  summarise(count=n ())
brfss2013 %>%
  group_by (rcsrltn2) %>%
  summarise(count=n ())
```
Define the number of missing value in 3 analyzing variables.
```{r}
brfss2013 %>%
    filter (!is.na(asthnow), !is.na(casthno2), rcsrltn2 == "Parent" ) %>%
    ggplot(aes(x=asthnow, y=casthno2))+geom_count()+labs(x="Mother/Father having asthma", y="Children having asthma", title = "The relationship between a child having asthma and the history of their mother/father having asthma")
brfss2013asth <- brfss2013 %>% filter (!is.na(asthnow), !is.na(casthno2), rcsrltn2 == "Parent" )
table(brfss2013asth$asthnow, brfss2013asth$casthno2)
```
Because we want to see the connection between the number of children having asthma and the number of their mother/father having asthma, we use filter function to exclude all missing value in 2 variables and draw a graph to see the relationship.
The number of children having asthma and at the same time their parents having asthma take majority of the sample (1296 cases). Meanwhile 347 children are experiencing asthma but their parents don't. However in this case, the relationship between the parents and children include: biologic, step, or adoptive parent. To investigate deeper, we need to requestion again the question about the relationship. 



**Research question 2:**

```{r}
grep ("cvdstrk3", names(brfss2013), value = TRUE)
grep("_chldcnt", names(brfss2013), value = TRUE)
grep("sex", names(brfss2013), value = TRUE)
```
Define the variables which will be analyzed. 4 variables are selected, cvdstrk3 "Ever diagnosed with a stroke", X_chldcnt "NUmber of children in household", sex "Gender of respondent" and rcsrltn2 "Relationship To Child", which was defined at the question number 1 
```{r}
brfss2013 %>%
  group_by (cvdstrk3) %>%
  summarise(count=n ())
brfss2013 %>%
  group_by (X_chldcnt) %>%
  summarise(count=n ())
brfss2013 %>%
  group_by (sex) %>%
  summarise(count=n ())
```
Define the number of missing value in 3 analyzing variables.
```{r}
brfss2013male <- brfss2013 %>% filter (sex=="Male", rcsrltn2 == "Parent", !is.na(cvdstrk3), !is.na(X_chldcnt)) 
table(brfss2013male$cvdstrk3, brfss2013male$X_chldcnt)
brfss2013female <- brfss2013 %>% filter (sex=="Female", rcsrltn2 == "Parent", !is.na(cvdstrk3), !is.na(X_chldcnt)) 
table(brfss2013female$cvdstrk3, brfss2013female$X_chldcnt)
```
Because we are looking at the relationship between having stroke of mother/father and the number of children. So of course there is no cases having 0 children in our analysis. We both see a trend in 2 sex groups: the number of children increases, the number of mother/father experiencing stroke decreases. However, when having the same number of children in household, the number of mother having stroke is tend to more than the number of father experiencing stroke.  
**Research quesion 3:**

```{r}
grep ("cvdasprn", names(brfss2013), value = TRUE)
grep("_age_g", names(brfss2013), value = TRUE)
```
Define the variables which will be analyzed. 3 variables are selected, cvdasprn "Take Aspirin Daily Or Every Other Day", X_age_g "Imputed Age In Six Groups", and cvdstrk3 "Ever diagnosed with a stroke", which was defined at the question number 2
```{r}
brfss2013 %>%
  group_by (cvdasprn) %>%
  summarise(count=n ())
brfss2013 %>%
  group_by (X_age_g) %>%
  summarise(count=n ())
```
Define the number of missing value in 2 analysing variables.
```{r}
brfss2013agr <- brfss2013 %>% filter(!is.na(cvdstrk3), !is.na(cvdasprn), !is.na(X_age_g))  
table(brfss2013agr$cvdstrk3, brfss2013agr$cvdasprn, brfss2013agr$X_age_g) 
```
In two youngest age groups, looking at the row of people having stroke, the number of people using daily aspirin always less than the number of not using daily aspirin. However, when age increases, this trend reverses. There is a trend of more people using daily aspirin experience stroke then people taking aspirin every other day, which is suggest us having deeper analysis about this topic 
