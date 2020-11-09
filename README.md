# AutosRUs

## Overview
In this project we take a focus on statistics, and the programming language R. Statistics is a cornerstone of data analytics, and helps us to contextual our data. Statistics take a critical role when it comes to making important decisions, and this is the case in any field. In the professional world, those who are familiar with statistics tend to be the go to people within a company when it comes to the decision making, troubleshooting, and resource planning. In this project we will review statistics and regression models, as well as explore more advanced statistical models commonly used in data analytics. Lastly, we will design and interpret statistical studies. The perfect tool to use for data analysis other than Python, is the R language, a language made by data analysts for data analysts. R was developed for data manipulation, statistical analysis, and visualization. The basics of R include reading a dataset, manipulating the data, performing calculation, and creating data visualizations with two dimensional plots. With all of its benefits, the biggest drawback of R is its licensing. R, as well as most of its libraries, are licensed as General Public license, as in any program or model using R will be forcibly be open source. Often time this will not be an issue because a data analyst plans on publishing their findings anyway. However, when working with a company with intellectual property, or propriety data and programs this can be an issue. In these cases, a company may use R for internal analysis, and use Python for any application or script that contains propriety information. Nonetheless, R is still a highly valuable programming language for data analysis, and is used by data professionals at all levels across all fields. We will be using the IDE RStudio to help us design and test R scripts. Similarly to Jupyter Notebook, RStudio enables programmers to test their code line by line to allow users to troubleshoot any problems efficiently and easily.

In this project I will be working with a mock company, AutosRUs, who have realized that their decision making process should be moved into the 21st century. I will be tasked with performing retrospective analysis of the companies historic data, analytical verification, validation of current automotive specifications, and study design of future project testing. The company recognizes that the most successful automobile models utilize data analytics in every decision making process. To make our project as fruitful as possible, we’ll have to ensure that our analysis contains a statistical backbone, a quantitative metric, and clear interpretation of the results. We will perform our statistical tests using the R programming language. We will have to provide summary statistics for different variables, visualizations for different data sets, and a personal interpretation of the statistical test results. We will also have to use our critical thinking skills to create a study design, hypothesis, and analysis workflow.

The R language has a large community, and great number of supportive documentation. Check out this site for more information on the methods used in this project https://www.rdocumentation.org/. For documentation on the tidyverse library check out this source, https://www.tidyverse.org/. 

## Process
###	Load, clean up, and reshape datasets using tidyverse in R.

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


###	Generate and interpret more complex plots such as boxplots and heatmaps using ggplot2.

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

###	Plot and identify distribution characteristics of a given dataset.

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

![image](https://user-images.githubusercontent.com/68082808/98383262-442d7380-201a-11eb-93cf-a14b65839cd1.png)

When dealing with relatively small data sets, our distributions may often be asymmetrical. Compared to the normal distribution, where each tail of the distribution mirrors eachother, the asymmetrical distribution has one distribution tail that is longer than the other. This asymmetrical distribution is commonly referred to as a skewed distribution, and there are two types, left skew and right skew. As with most problems in data analytics, we must approach skewness on a case-by-case basis. Depending on the severity of the skewness and the size of the dataset, there are multiple means of dealing (or not dealing) with skewness. If our dataset is large, or the skewness is very subtle, we would simply point out that our data distribution shows signs of skew during reporting or presentation. In these cases, our mean and median will be roughly the same value, and there should be minimal impact to any downstream analysis.

If our dataset is smaller, or the skewness does impact the overall shape of our distribution, more action is needed. There are a few different things we can try:

- If possible, add more data points to our dataset to alleviate the effect of skew. However, this might not be possible or might not improve the distribution.
- Resample or regenerate data if we think that the data might not be representative of the original conditions or dataset.
- Transform our data values by normalization, using another numerical variable, or by transforming the data using an operator. The concept of transforming skewed data is very popular with scientists who deal with datasets where values can differ by orders of magnitude. One of the easiest means of transforming data is using a log-transform, where each value in the numeric dataset is transformed taking either natural log, or log10. By using a log-transformation, the effects of extreme values are reduced, and this transformation can help make each distribution tail more symmetrical.

###	Formulate null and alternative hypothesis tests for a given data problem.

Although data collection and research are important, the backbone of the scientific method is hypothesis testing. Hypotheses are utilized by the scientific method to help narrow the scope of research and testing as well as provide a clear outcome of our results. Without generating a set of hypotheses, it becomes exponentially more difficult to quantify results and provide measurable outcomes to our analyses. As data analysts, it's our job to match a set of hypotheses to an appropriate statistical test to ensure that results are interpreted correctly. In other words, we use statistical hypothesis testing to determine which of our hypotheses are most likely to be true. There are two types of statistical hypothesis:

- The null hypothesis is also known as H0 and is generally the hypothesis that can be explained by random chance.
- The alternate hypothesis is also known as Ha and is generally the hypothesis that is influenced by non-random events.

Regardless of the complexity of the dataset or the proposed question, hypothesis testing uses the same five steps:

1. Generate a null hypothesis, its corresponding alternate hypothesis, and the significance level.
2. Identify a statistical analysis to assess the truth of the null hypothesis.
3. Compute the p-value using statistical analysis.
4. Compare p-value to the significance level.
5. Reject (or fail to reject) the null hypothesis and generate the conclusion.

Outside of statistics, you may see others refer to this process as "accepting or rejecting" the null hypothesis. While this is not entirely untrue, many statisticians believe that there is no way of making a definitive choice between either hypothesis without an infinitely large dataset. Therefore, we use p-values and significance levels to determine the probability that our observations were obtained assuming the null hypothesis.

After determining which statistical analysis is most appropriate and analyzing our data, we must quantify our statistical results using probability. In our example, we are calculating probability directly; however, most statistical tests will produce probability in the form of a p-value. The **p-value**, or probability value, tells us the likelihood that we would see similar results if we tested our data again, if the null hypothesis is true. Therefore, we use the p-value to provide quantitative evidence as to which of our hypotheses are true. To determine which hypothesis is most likely to be true, we compare the p-value against a **significance level**. A significance level (also denoted as alpha or ɑ) is a predetermined cutoff for our hypothesis test. When designing our hypothesis, we would determine the significance level based on the importance of our findings. In most cases, a significance level of 0.05 is sufficient, but if our hypotheses are being used for critical decision-making (such as the performance of a drug or the durability of a helmet), we might want to use smaller cutoffs such as 0.01 or 0.001. Regardless of what significance level we select, we want to predetermine our cutoff prior to computing the p-value as to not introduce bias into our results. Refer to the following chart:

![image](https://user-images.githubusercontent.com/68082808/98399221-14896600-2030-11eb-8ab3-469ebf2a4353.png)


###	Characterize the Sample Space

In data analysis and statistics, an ideal dataset is one that contains measurements and results from every possible outcome, condition, or consideration. These datasets are known as a **population dataset** and contain all possible elements of a study or experiment. Often, such an exhaustive dataset is prohibitively expensive or logistically impossible to generate. In this case, we must use a **sample** or subset of the population dataset, where not all elements of a study or experiment are collected or measured.

One of the most straightforward ways to characterize a sample versus its population data is to compare the mean and standard deviation of both datasets. Ideally, a sample dataset will have a similar distribution to the population data, and therefore the mean and standard deviation would be about equal. **Random sampling** is a technique in data science in which every subject or data point has an equal chance of being included in the sample. This technique increases the likelihood that even a small sample size will include individuals from each "group" within the population.

```
population_table <- read.csv('01_Demo/used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot
```

![image](https://user-images.githubusercontent.com/68082808/98399307-3387f800-2030-11eb-871b-cceeec4ecae4.png)

Now that we've characterized our population data using our density plot, we'll create a sample dataset using dplyr's sample_n() function. The sample_n() function selects random rows from the table, which is a great way to sample data from an exhaustive dataset. This function takes two arguments, then name of the input table, and the number of rows to return.

```
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot
```
![image](https://user-images.githubusercontent.com/68082808/98399645-b90ba800-2030-11eb-86e2-a3ba45895f97.png)

By using dplyr's sample_n() function, we can create a random sample dataset from our population data that contains minimal bias and (ideally) represents the population data. Depending on the size of the population data, we may need to also adjust the size argument in our sample_n() function to ensure that our sample data is representative of the underlying population data. There are two basic ways to check that our sample data is representative of the underlying population: a qualitative assessment of each density plot or a quantitative statistical test such as the one-sample t-test.


###	Implement and evaluate the one-sample t-Tests, two-sample t-Tests, and analysis of variance (ANOVA) models for a given dataset.

In statistics, we use a t-test to compate the mean of one dataset to another under a few assumptions. There are two main forms of the t-test: the one-sample t-test, and the two-sample t-test.

**The One-Sample T-Test**

A one sample t-test is used to determine whether there is a statistical difference between the means of a sample dataset and a hypothesized population dataset. Simply, a one sample t-test is used to test whether or not there is a statistical difference between the observed sample mean and the presumed population mean. Before we can apply any statistical test to our data, there are a few things we must confirm about our datasets:

1. The input data is numerical and continuous. This is because we are testing the distribution of two datasets.
2. The sample data was selected randomly from its population data.
3. The input data is considered to be normally distributed.
4. The sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
5. The variance of the input data should be very similar.

We can perform a one-sided and a two-sided t-test in R with the t.test() method. It takes 3 notable arguments, firstly a numeric vector of sample data, the calculated mean of the population data, and a character string specifying whether the hypothesis is one-sided or two-sided. The default method is two-sided.

```t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means```

![image](https://user-images.githubusercontent.com/68082808/98483486-d24e5900-21d6-11eb-8be6-9fb97955f84c.png)


Assuming our significance level was the common 0.05 percent, our p-value is below our significance level. Therefore, we have sufficient evidence to reject the null hypothesis, and we would state that the two means are statistically different. If our significance level was the common 0.05 percent, our p-value was above our significance level, we would not have sufficient evidence to reject the null hypothesis, and we would state that the two means are statistically similar.


**The Two-Sample T-Test**

The two-sample t-Test determines whether the means of two samples are statistically different. In other words, a two-sample t-Test is used to test whether or not there is a statistical difference between the observed sample means of two datasets. Before we can apply any statistical test to our data, there are a few things we must confirm about our datasets:

1. The input data is numerical and continuous.
2. Each sample data was selected randomly from the population data.
3. The input data is considered to be normally distributed.
4. The sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
5. The variance of the input data should be very similar.

We will first produce our two samples using the following code. Afterwhich we will use the t.test() function again to take a two-sided t-test.

```
# Two-tailed test
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples
```

![image](https://user-images.githubusercontent.com/68082808/98483820-3a9e3a00-21d9-11eb-8f95-aa0339018e10.png)

The p-value is above the assumed significance level of 0.05. Therefore, we would state that there is not enough evidence to reject the null hypothesis and we can confirm our two samples are not statistically different. Essentially, we fail to reject the null hypothesis.


**The Pair T-Test**
Two-sample t-tests can be used to compare two samples from different populations, this is known as a pair t-test because we pair observations in one dataset with observations in another. For instance, we can use the pair t-test to compare measurements on the same subjects across a single span of time, such as fuel efficiency before and after an oil change, as well as to compare different meaasures of measurement, such as testing tire pressure using two different tire pressure gauges. The biggest difference between paired and unpaired t-tests is how the means are calculated. In an unpaired t-test, the means are calculated by adding up all observations in a dataset, and dividing by the number of data points. In a paired t-test, the means are determined from the difference between each paired observation. As a result of the new mean calculations, our paired t-test hypotheses will be slightly different. We will be testing to see if the difference between our paired observations is, or is not, equal to zero.

First we will generate two data samples, one selecting data points where the year is 1999, and the other selecting data points where the year is 2008. Now that we have our paired datasets, we can use a paired t-test to determine if there is a statistical difference in overall highway fuel efficiency between vehicles manufactured in 1999 versus 2008. In other words, we are testing our null hypothesis—that the overall difference is zero. Using our t.test() function in R, our code would be as follows:

```
mpg_data <- read.csv('01_Demo/mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples
```

![image](https://user-images.githubusercontent.com/68082808/98484272-3c1d3180-21dc-11eb-912c-147a8cc0111c.png)

The p-value is above the assumed significance level. Therefore, we would state that there is not enough evidence to reject the null hypothesis and there is no overall difference in fuel efficiency between vehicles manufactured in 1999 versus 2008.


**The ANOVA Test**

When dealing with large real-world numerical data, we're often interested in comparing the means across more than two samples or groups. The most straightforward way to do this is to use the **analysis of variance (ANOVA) test**, which is used to compare the means of a continuous numerical variable across a number of groups (or factors in R). Depending on your dataset and questions you wish to answer, an ANOVA can be used in multiple ways. For the purposes of this course, we'll concentrate on two different types of ANOVA tests. A **one-way ANOVA** is used to test the means of a single dependent variable across a single independent variable with multiple groups. (e.g., fuel efficiency of different cars based on vehicle class). A **two-way ANOVA** does the same thing, but for two different independent variables (e.g., vehicle braking distance based on weather conditions and transmission type). The statisitcal hypothesis of an ANOVA test are the same, we either test to see if the mean of all groups are equal, or if at least one of the means is different from the rest.

Additionally, both ANOVA tests have assumptions about the input data that must be validated prior to using the statistical test:

1. The dependent variable is numerical and continuous, and the independent variables are categorical.
2. The dependent variable is considered to be normally distributed.
3. The variance among each group should be very similar.

R's aov() function can perform either a one-way or a two-way ANOVA test. Unlike the t.test() function, where each group was a separate numeric vector, the aov() function expects that all of the observations and grouping information are contained within a single data frame. Once we have our cleaned and labeled data frame, we're ready to perform our ANOVA test using the aov() function.

```
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
```

![image](https://user-images.githubusercontent.com/68082808/98484560-6e2f9300-21de-11eb-9a94-49832ad63011.png)

Due to the fact that the ANOVA model is used in many forms, the initial output of our aov() function does not contain our p-values. To retrieve our p-values, we have to wrap our aov()function in a summary() function as follows:

```summary(aov(hp ~ cyl,data=mtcars_filt))```

When using the formula statement, each independent variable will be shown as a separate row, with an additional "Residuals" row that tells us what the residual error is for our ANOVA model. For our purposes, we are only concerned with the "Pr(>F)" column, which is the same as our p-value statistic.

Depending on how small our p-value is, there may be symbols on the right side that indicate which significance level the p-value is below. In this case, our p-value is 1.32 ✕ 10^-8^, which is much smaller than our assumed 0.05 percent significance level. Therefore, we would state that there is sufficient evidence to reject the null hypothesis and accept that there is a significant difference in horsepower between at least one engine type and the others.

###	Implement and evaluate simple linear regression and multiple linear regression models for a given dataset.

In data analytics, we'll often ask the question "is there any relationship between variable A and variable B?" This concept is known in statistics as correlation. Correlation analysis is a statistical technique that identifies how strongly (or weakly) two variables are related. Correlation is quantified by calculating a correlation coefficient, and the most common correlation coefficient is the Pearson correlation coefficient. The Pearson correlation coefficient is denoted as "r" in mathematics and is used to quantify a linear relationship between two numeric variables. The Pearson correlation coefficient ranges between -1 and 1, depending on the direction of the linear relationship.

![image](https://user-images.githubusercontent.com/68082808/98488102-3bdd6000-21f5-11eb-9a25-f7caf104d84b.png)

Lets plot the horsepower variable and the quarter-mile time and observe any general correlation between the two.

![image](https://user-images.githubusercontent.com/68082808/98488048-ef922000-21f4-11eb-869a-d841c3d6becf.png)

The cor() function quantifies the strength of the correlation between the two variables.

```cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient```

###	Implement and evaluate a chi-squared test for a given dataset.

###	Identify key characteristics of A/B and A/A testing.

###	Determine the most appropriate statistical test for a given hypothesis and dataset.
