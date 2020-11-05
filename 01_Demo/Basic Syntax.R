# To find out more about any one method enter ?<method name> into the console and the help menu will provide documentation

# Assignment operator
x <- 5
numList = c(0,1,2,3,4,5,6,7,8,9)
numList[2] # Outputs to console. Note: R;s index starts at 1

# read.csv method allows RStudio to extract data from .csv files
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)

# After importing the jsonlite library, the from JSON method can be used to extract data from a JSON file
library(jsonlite)
demo_table2 <- fromJSON(txt='demo.json')

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
# The summarize function ceates columns in our summary dataframe
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep')

# gather() can be used to simplify overcomplicated data frames so that it may be compatible with other methods
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
