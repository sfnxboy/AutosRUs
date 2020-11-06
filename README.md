# AutosRUs

## Overview
In this project we take a focus on statistics, and the programming language R. Statistics is a cornerstone of data analytics, and helps us to contextual our data. Statistics take a critical role when it comes to making important decisions, and this is the case in any field. In the professional world, those who are familiar with statistics tend to be the go to people within a company when it comes to the decision making, troubleshooting, and resource planning. In this project we will review statistics and regression models, as well as explore more advanced statistical models commonly used in data analytics. Lastly, we will design and interpret statistical studies. The perfect tool to use for data analysis other than Python, is the R language, a language made by data analysts for data analysts. R was developed for data manipulation, statistical analysis, and visualization. The basics of R include reading a dataset, manipulating the data, performing calculation, and creating data visualizations with two dimensional plots. With all of its benefits, the biggest drawback of R is its licensing. R, as well as most of its libraries, are licensed as General Public license, as in any program or model using R will be forcibly be open source. Often time this will not be an issue because a data analyst plans on publishing their findings anyway. However, when working with a company with intellectual property, or propriety data and programs this can be an issue. In these cases, a company may use R for internal analysis, and use Python for any application or script that contains propriety information. Nonetheless, R is still a highly valuable programming language for data analysis, and is used by data professionals at all levels across all fields. We will be using the IDE RStudio to help us design and test R scripts. Similarly to Jupyter Notebook, RStudio enables programmers to test their code line by line to allow users to troubleshoot any problems efficiently and easily.

In this project I will be working with a mock company, AutosRUs, who have realized that their decision making process should be moved into the 21st century. I will be tasked with performing retrospective analysis of the companies historic data, analytical verification, validation of current automotive specifications, and study design of future project testing. The company recognizes that the most successful automobile models utilize data analytics in every decision making process. To make our project as fruitful as possible, we’ll have to ensure that our analysis contains a statistical backbone, a quantitative metric, and clear interpretation of the results. We will perform our statistical tests using the R programming language. We will have to provide summary statistics for different variables, visualizations for different data sets, and a personal interpretation of the statistical test results. We will also have to use our critical thinking skills to create a study design, hypothesis, and analysis workflow.

The R language has a large community, and great number of supportive documentation. Check out this site for more information on the methods used in this project https://www.rdocumentation.org/. For documentation on the tidyverse library check out this source, https://www.tidyverse.org/. 

## Process
•	Load, clean up, and reshape datasets using tidyverse in R.

In addition to the native statistical functions, there are many other useful data transformation and modelling libraries, such as the tidyverse package, that simplify the process of ETL and visualizations.
To install the tidyverse package, enter the following code into RStudio's Console: ```install.packages("tidyverse")```.

```demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)```

For this project we will also need to import the rjson file to load data from .json files, enter the following code into RStudio's console: ```install.packages("rjson")```.

```demo_table2 <- fromJSON(txt='demo.json')```

To filter a table, instantiate a variable, and define the column you wish to filter on with teh $ operator. Note the trailing comma.

```filter_table <- demo_table2[demo_table2$price > 10000,]```

The subset() method is a cleaner method to filter data.

```filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status)```.

Without the subset method, the code would look like this:

```filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),]```

After importing the tidyverse library, the mutate() method can be used to transform the data.

```demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE)```

Similarly to Pandas groupby() method, the group_by() method groups the data by a factor, as so:

```summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep')```

The gather() method can be used to simplify over complicated data frames so that it may be compative with other methods.

```
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
```

spread() can be used interchangeably with gather(). spread() spreads a key-value pair across multiple columns.

```wide_table <- long_table %>% spread(key="Metric",value="Score")```


•	Generate and interpret more complex plots such as boxplots and heatmaps using ggplot2.

Bar Plot
```
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + #plot a boxplot with labels
  theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees
```

Line Plot
```
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30)) #add line plot with labels
```

Scatter Plot
```
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive", size="City Fuel-Efficiency (MPG)") #add scatter plot with multiple aesthetics
```

Box Plot
```
plt + geom_boxplot(aes(colour = manufacturer), linetype = "dashed") + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees
```

Heatmap
```
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + #add heatmap with labels 
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees
```

•	Plot and identify distribution characteristics of a given dataset.

Its important to understand how data is categorized:
- Continuous: Numerical data that can be infinitely precise
- Ordinal: Categorical data that has direction, but the distance between values is ambiguous.
- Nominal: Data used as labels or names.
- Interval: Numerical data spaced evenly on a scale.
- Dichotomous: Data that is one of two possible values.

When it comes to data analysis, characterizing the distribution of numerical data is as important as characterizing the different data types. If we make incorrect assumptions about the distribution of our data, our statistical results could be meaningless. In general, most basic statistical tests assume that each numerical metric follows an approximate normal distribution. When numerical data is considered to be normally distributed, the probability of any data point follows the 68-95-99.7 rule, stating that 68.27%, 95.45%, and 99.73% (effectively 100%) of the values lie within one, two, and three standard deviations of the mean, respectively.

In statistics, the central limit theorem is a key concept that states if you take sufficiently large samples of data from a dataset with mean μ (mu) and standard deviation σ (sigma), then the distribution will approximate normal distribution. Therefore, if we are using relatively large sample sizes, we should expect data to become more normally distributed.

If we want to test the distribution of vehicle weights from the built-in mtcars dataset, our code would be as follows:

```ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot```

![image](https://user-images.githubusercontent.com/68082808/98382849-bbaed300-2019-11eb-92d4-3082355270f6.png)

Often times data analysts would use the Shapiro-Wilk test for normality. The shapiro.test() function requires only the numeric vector of values you wish to test. Since the p-value is greater than 0.05, we can consider the data to be normally distributed.

```shapiro.test(mtcars$wt)```



•	Formulate null and alternative hypothesis tests for a given data problem.

•	Implement and evaluate simple linear regression and multiple linear regression models for a given dataset.

•	Implement and evaluate the one-sample t-Tests, two-sample t-Tests, and analysis of variance (ANOVA) models for a given dataset.

•	Implement and evaluate a chi-squared test for a given dataset.

•	Identify key characteristics of A/B and A/A testing.

•	Determine the most appropriate statistical test for a given hypothesis and dataset.

