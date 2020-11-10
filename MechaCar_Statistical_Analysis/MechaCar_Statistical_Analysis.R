library(tidyverse)

# read.csv method allows RStudio to extract data from .csv files
MechaCar <- read.csv(file='MechaCar_Statistical_Analysis/MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)

# Linear Regression to Predict MPG
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar)
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar))

# Summary
Suspension_Coil <- read.csv(file='MechaCar_Statistical_Analysis/Suspension_Coil.csv',check.names=F,stringsAsFactors = F)
total_summary <- Suspension_Coil %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI),SD=sd(PSI), .groups = 'keep') #create summary table with multiple columns
lot_summary  <- Suspension_Coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI),SD=sd(PSI), .groups = 'keep') #create summary table with multiple columns

# T-Test analysis
population_table <- Suspension_Coil
t.test(population_table$PSI,mu=mean(1498.78)) #compare sample versus population means


Lot1 <- population_table %>% filter(Manufacturing_Lot=='Lot1')
t.test(Lot1$PSI,mu=mean(1498.78)) #compare sample versus population means

Lot2 <- population_table %>% filter(Manufacturing_Lot=='Lot2')
t.test(Lot2$PSI,mu=mean(1498.78)) #compare sample versus population means

Lot3 <- population_table %>% filter(Manufacturing_Lot=='Lot3')
t.test(Lot3$PSI,mu=mean(1498.78)) #compare sample versus population means


# Correlation
matrix <- as.matrix(MechaCar[,c("vehicle_length", "vehicle_weight", "mpg")])
cor(matrix)

# Linear Regression analysis between Lots 1 & 2
t.test(Lot1$PSI,Lot2$PSI,paired = T) #compare the mean difference between two samples
