library(collegeIncome) 
data(college)
library(broom) 
library(dplyr)
head(college)
summary(college)
table(college$major_category)
library(magrittr)
# college <- college[college$major_category != "Interdisciplinary",]
college <- college %>% filter(major_category != "Interdisciplinary") 
table(college$major_category)

par(mar = c(13,4.5,2,0.5)) 
boxplot(p25th ~ major_category, data = college, main = "25th percentile", las = 2, cex.axis = 0.75)
boxplot(median ~ major_category, data = college, main = "50th percentile", las = 2, cex.axis = 0.75)
boxplot(p75th ~ major_category, data = college, main = "75th percentile", las = 2, cex.axis = 0.75)
lmfit <- lm(median ~ major_category+perc_women+perc_college_jobs+perc_low_wage_jobs, data = college) 
summary(lmfit)

resid <- residuals(lmfit) 
fitted <- fitted.values(lmfit) 
plot(density(resid), xlab = "Residuals", ylab = "Density", main = "Residual distribution")

plot(fitted, resid, xlab = "Predicted values", ylab = "Residuals") 
abline(h = 0, col = "red", lty = "dashed")

tidy(lmfit)