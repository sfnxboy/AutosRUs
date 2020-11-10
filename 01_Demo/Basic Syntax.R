# To find out more about any one method enter ?<method name> into the console and the help menu will provide documentation

# Assignment operator
x <- 5
numList = c(0,1,2,3,4,5,6,7,8,9)
numList[2] # Outputs to console. Note: R;s index starts at 1

# read.csv method allows RStudio to extract data from .csv files
demo_table <- read.csv(file='01_Demo/demo.csv',check.names=F,stringsAsFactors = F)

# After importing the jsonlite library, the from JSON method can be used to extract data from a JSON file
library(jsonlite)
demo_table2 <- fromJSON(txt='01_Demo/demo.json')

# Create a filtered table var by calling the table, and using the $ operator to select a column/row
# Note the reailing comma.
filter_table <- demo_table2[demo_table2$price > 10000,]

# The subset method can be used to filter by price and drivetrain, you can chain operators
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status)

# Using subset() is cleaner than using brackets, which would look like this.
filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),]

# The sample() method uses few arguments to create a sampled vector from a larger vector
sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4)
# Output: "chicken" "sheep"   "duck"    "dog" 

# To sample a 2D data structure, you must supply the index of each row we want to sample
# The nrow() method counts the number of rows in a dataframe
demo_table[sample(1:nrow(demo_table), 3),]

# After importing the tidyverse library, you can use mutate() to transform data
library(tidyverse)
#add columns to original data frame
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE)

# Create a summary table using group_by(), a method which groups by a factor
# The summarize function creates columns in our summary dataframe
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep')

# gather() can be used to simplify over complicated data frames so that it may be compatible with other methods
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)

# spread() can be used interchangeably with gather(). spread() spreads a key-value pair across multiple columns
wide_table <- long_table %>% spread(key="Metric",value="Score")


# Bar Plot

# ggplot() can be used to create visualizations
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar plot

mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot
plt + geom_col() #plot a bar plot
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") #plot bar plot with labels

plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + #plot a boxplot with labels
  theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees


# Line Plot

mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
plt + geom_line() # geom_line() produces a line plot
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30)) #add line plot with labels


# Scatter Plot

plt <- ggplot(mpg,aes(x=displ,y=cty)) #import dataset into ggplot2
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") #add scatter plot with labels
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") #add scatter plot with labels
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive", size="City Fuel-Efficiency (MPG)") #add scatter plot with multiple aesthetics


# Box Plot

plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot(aes(colour = manufacturer), linetype = "dashed") + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees


# Heatmap Plot

mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + #add heatmap with labels 
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees


# Add Layers to Plots
# There are two types of plot layers:
# 1) Layering additional plots that use the same variables and input data as the original plot
# 2) Layering of additional plots that use different but complementary data to the original plot

plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
  theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
  geom_point() #overlay scatter plot on top
# By layering our data points on top of our boxplot, we can see the general distribution of values within each box
# as well as the number of data points.


# facet() allows us to plot our measurements but keep each level of our grouping variable seperate
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees

# facet_wrap() allows us to facet, but places the plots side by side
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
  theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels


# Qualitative test for normality, geo_density() plots distribution
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot


# Select random rows from a table with sample_n()
population_table <- read.csv('01_Demo/used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

# One-tailed test
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

# Two-tailed test
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

# Pair T-Test
mpg_data <- read.csv('01_Demo/mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
summary(aov(hp ~ cyl,data=mtcars_filt))


# Correlation

plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient

used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

# Linear Regression
lm(qsec~hp,mtcars) #summarize linear model6

model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model

lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics

# Chi-squared test
table(mpg$class,mpg$year) #generate contingency table
tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions
