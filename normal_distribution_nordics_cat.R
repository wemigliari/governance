dlibrary(readxl)
library(pastecs) # Summary of descriptive statistics
library(lubridate)

## Model

model <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_barna.xlsx",
                   sheet = "esp_cat_swedes")

model1 <- format(as.Date(model$Total_month_thousands), "%A, %d-%b. %Y") 

model <-cbind(model1, model)

model[2] <- NULL

model <- model %>% rename(
Total_month_thousands = model1
)

library(varhandle)
model <- unfactor(model)


model_mlr_ar_n1 <- lm(model$Arrivals_cat ~ model$Arrivals_cat_dk + 
                        model$Arrivals_cat_fin + 
                        model$Arrivals_cat_nor +
                        model$Arrivals_cat_se, data = model) 

summary(model_mlr_ar_n1)
max(predict(model_mlr_ar_n1, newdata = model, interval = "prediction")) ## Function predict used after capturing the max value found in the model.




pairs(model, pch = 16, col = "green", main = "Nordics in Catalonia")

prediction_total_nordics <- data.frame(model$Arrivals_cat_total_nordics)
prediction_total_dk <- data.frame(model$Arrivals_cat_dk)
prediction_total_fin <- data.frame(model$Arrivals_cat_fin)
prediction_total_nor <- data.frame(model$Arrivals_cat_nor)
prediction_total_se <- data.frame(model$Arrivals_cat_se)

# P1 (Extract the values of min, max, meand and sd with stat.desc function, package pastecs)
stat1 <- data.frame(stat.desc(prediction_total_nordics))

#min	0.000000e+00
#max	1.300880e+05
#mean	5.134520e+04
#std.dev	2.920672e+04

x1 <- seq(-2931, 2931, by = 0.1)
y1 <- dnorm(x1, mean = 1554, sd = 456)

# P2

stat2 <- data.frame(stat.desc(prediction_total_dk))

#min	0.000000e+00
#max	4.940700e+04
#mean	1.337437e+04
#std.dev	1.018790e+04

x2 <- seq(-100, 100, by = 0.1)
y2 <- dnorm(x2, mean = 13, sd = 10)

# P3

stat3 <- data.frame(stat.desc(prediction_total_fin))

#min	0.000000e+00
#max	1.672400e+04
#mean	2.561294e+03
#std.dev	4.642227e+03

x3 <- seq(-100, 100, by = 0.1)
y3 <- dnorm(x3, mean = 2.5, sd = 4.6)

# P4

stat4 <- data.frame(stat.desc(prediction_total_nor))

#min	0.000000e+00
#max	4.890400e+04
#mean	1.551896e+04
#std.dev	1.312869e+04

x4 <- seq(-100, 100, by = 0.1)
y4 <- dnorm(x4, mean = 15, sd = 13)

# P5

stat5 <- data.frame(stat.desc(prediction_total_se))

#min	0.000000e+00
#max	6.107600e+04
#mean	1.989057e+04
#std.dev	1.284376e+04

x5 <- seq(-100, 100, by = 0.1)
y5 <- dnorm(x5, mean = 19, sd = 12)


#### Plotting overlapping bell curves
dev.off()
par(mfrow = c(1,1), family= "Arial", cex = 0.5, oma = c(4, 1, 1, 4))
#plot(x1, y1, col = "lightgreen", type = "l", lwd = 1, xlim = c(0,3000), ylim = c(0, 0.05))
plot(x2, y2, col = "lawngreen",  type = "l", lty = 1, lwd = 1, 
     xlim = c(-20,50), ylim = c(0,0.09),
     xlab = "Total of Arrivals per month in Catalonia (thousands). Data Series Oct. 2015-Dec. 2019.",
     ylab = "Proabilities")
lines(x3, y3, col = "darkgreen", type = "l", lty = 1, lwd = 1)
lines(x4, y4, col = "yellowgreen", type = "l", lty = 1, lwd = 1)
lines(x5, y5, col = "olivedrab", type = "l", lty = 1, lwd = 1)

legend(40, 0.08, legend=c("Denmark", "Finland", "Norway", "Sweden"),
       col=c("lawngreen", "darkgreen", "yellowgreen", "olivedrab"), lty=1, cex=1, box.lty = 0)


### Plotting boxplots and normal distributions

model <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_barna.xlsx",
                   sheet = "esp_cat_swedes")

model1 <- format(as.Date(model$Total_month_thousands), "%A, %d-%b. %Y") 

model <-cbind(model1, model)

model[2] <- NULL

model <- model %>% rename(
  Total_month_thousands = model1
)

library(varhandle)
model <- unfactor(model)


model_mlr_ar_n1 <- lm(model$Arrivals_cat ~ model$Arrivals_cat_dk + 
                        model$Arrivals_cat_fin + 
                        model$Arrivals_cat_nor +
                        model$Arrivals_cat_se, data = model) 

### Ploting boxplots and normal distributions

par(mfrow = c(2,2), family= "Arial", cex = 0.6, oma = c(1, 1, 1, 1))

qqnorm(model$Arrivals_n_s/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Nordics in Spain") +
  qqline(model$Arrivals_n_s/1000, col = "darkgreen", lwd = 2)

qqnorm(model$Arrivals_cat_total_nordics/1000, pch = 1, frame = FALSE,  main = "Normal Q-Q Plot Arrivals of Nordics in Catalonia") +
  qqline(model$Arrivals_cat_total_nordics/1000, col = "darkgreen", lwd = 2)

boxplot(model_mlr_ar_n1[["model"]][2:5]/1000, 
        col = c("lawngreen", "darkgreen", "yellowgreen", "olivedrab"),
        names = c("Denmark", "Finland", "Norway", "Sweden"),
        ylim = c(-10, 70),
        sub = "Boxplot on Monthly Total Arrivals in Catalonia (thousands). Data Series Oct. 2015-Dec. 2019.",
        outline = FALSE) #Plotting list "model" columns 2 to 5.

plot(x2, y2, col = "lawngreen",  type = "l", lty = 1, lwd = 1, 
     xlim = c(-20,50), ylim = c(0,0.09),
     xlab = "",
     ylab = "Proabilities",
     sub = "Total Monthly Arrivals in Catalonia (thousands). Data Series Oct. 2015-Dec. 2019.")
lines(x3, y3, col = "darkgreen", type = "l", lty = 1, lwd = 1)
lines(x4, y4, col = "yellowgreen", type = "l", lty = 1, lwd = 1)
lines(x5, y5, col = "olivedrab", type = "l", lty = 1, lwd = 1)

legend(23, 0.08, legend=c("Denmark", "Finland", "Norway", "Sweden"),
       col=c("lawngreen", "darkgreen", "yellowgreen", "olivedrab"), 
       lty=1, box.lty = 0, cex = 0.6)


### Coments

library(broom)

output_model <- tidy(model_mlr_ar_n1)
write_xlsx(output_model, "/Users/wemigliari/Documents/R/tabelas/public_health_coefficients_model.xlsx")
pairs(model[,10:13]/1000, pch  = 4, col = c("lawngreen", "darkgreen", "yellowgreen", "olivedrab"),
      labels = c("Denmark", "Finland", "Norway", "Sweden"))

library(GGally)

par(mar = c(1,1,1,1), family = "Arial", cex = 0.7)
ggpairs(test[,10:14])

library(plotly)
test <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_barna.xlsx",
                   sheet = "esp_cat_swedes")
test1<- data.frame(test)


plot_ly(test1, x = ~test1$Total_month_thousands, type = "scatter", mode = "markers",
        marker = list(size = ~test1$Arrivals_cat_total_nordics/10000, opacity = 0.5, color = 'rgb(255, 65, 54)'))%>%
add_markers(y = ~test1$Arrivals_cat_dk)%>%
add_markers(y = ~test1$Arrivals_cat_fin)%>%
add_markers(y = ~test1$Arrivals_cat_nor)%>%
add_markers(y = ~test1$Arrivals_cat_se)




