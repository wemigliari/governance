library(dplyr)
library(readxl)
library(varhandle)
library(yarrr)
library(XLConnect)


corona_test <- read_excel("/Users/wemigliari/Documents/R/data/corona_test.xlsx")
corona_test1 <- corona_test %>% filter(country == "Iceland"| country == "Finland" | country == "Norway" |
                       country == "Denmark" | country == "Sweden")



iceland <- corona_test1 %>% filter(country == "Iceland")
finland <- corona_test1 %>% filter(country == "Finland")
norway <- corona_test1 %>% filter(country == "Norway")
denmark <- corona_test1 %>% filter(country == "Denmark")
sweden <- corona_test1 %>% filter(country == "Sweden")


par(mfrow=c(1,2), cex.lab=0.7, cex.axis=0.5, cex.main=0.9)

barplot(iceland$tests_done/1000, names = iceland$year_week,
        main = "Number of Tests January-November (per 1,000), Iceland",
        col = "lightblue",
        las = 2)
lines(iceland$new_cases/1000, col="gold")

barplot(finland$tests_done/1000, names = finland$year_week,
        main = "Number of Tests January-November (per 1,000), Finland",
        col = "steelblue",
        las = 2)
lines(finland$new_cases/1000, col="gold")

par(mfrow=c(1,2), cex.lab=0.7, cex.axis=0.5, cex.main=0.9)

barplot(norway$tests_done/1000, names = norway$year_week,
        main = "Number of Tests January-November (per 1,000), Norway",
        col = "red",
        las = 2)
lines(norway$new_cases/1000, col="gold")

barplot(denmark$tests_done/1000, names = denmark$year_week,
        main = "Number of Tests January-November (per 1,000), Denmark",
        col = "#ffb2b2",
        las = 2)
lines(denmark$new_cases/1000, col="gold")

par(mfrow=c(1,2), cex.lab=0.7, cex.axis=0.5, cex.main=0.9)

barplot(sweden$tests_done/1000, names = sweden$year_week,
        main = "Number of Tests January-November (per 1,000), Sweden",
        col = "#0000cc",
        las = 2)
lines(sweden$new_cases/1000, col="gold")

plot(iceland$testing_rate, col = "lightblue", type = "l",
     main = "Testing Rate per 100,000, Jan-Nov, Nordic Region",
     ylab = "Tests",
     xlab = "Number of Weeks",
     ylim = c(0, 8000))
lines(finland$testing_rate, col = "steelblue")
lines(norway$testing_rate, col = "red")
lines(denmark$testing_rate, col = "#ffb2b2")
lines(sweden$testing_rate, col = "#0000cc")

colors = c("lightblue", "steelblue", "red", "#ffb2b2", "#0000cc")

legend(x = "topleft", legend = c("Iceland", "Finland", "Norway",
                                        "Denmark", "Sweden"), 
       fill = colors, bty = "n", y.intersp = 2, cex = 0.5)








