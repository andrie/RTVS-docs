# ---	
# title: "Introduction to R"	
# ---	


## Getting Started  	

### Some Brief History	
# R followed S. The S language was conceived by John Chambers, Rick Becker,
# Trevor Hastie, Allan Wilks and others at Bell Labs in the mid 1970s. 
# S was made publically available in the early 1980’s. R, which is modeled
# closely on S, was developed by Robert Gentleman and Ross Ihaka in the early 
# 1990's while they were both faculty members at the University of Auckland. 
# R was established as an open source project (www.r-project.org) in 1995. 
# Since 1997 the R project has been managed by the R Core Group. 
# When AT&T spun of Bell Labs in 1996, S was no longer freely available. 
# S-PLUS is a commercial implementation of the S language developed by the 
# Insightful corporation which is now sold by TIBCO software Inc.	

# The R Core Group: http://www.r-project.org/contributors.html  	
# Download R: http://cran.r-project.org/	


### How R is oganized	

# R is an interpreted functional language with objects. The core of 
# R language contains the the data manipulation and statistical functions. 
# Most of R's capabilities are delivered as user contributed packages that 
# may be downloaded from CRAN.R ships with the "base and recommended" 
# packages:	
# http://cran.r-project.org/doc/FAQ/R-FAQ.html#Which-add_002don-packages-exist-for-R_003f  	


###  R RESOURCES	

# What is R? the movie: http://www.youtube.com/watch?v=TR2bHSJ_eck   	
# Search for R topics on the web: http://www.rseek.org  	
# search or R packages: http://www.rdocumentation.org  	
# A list of R Resources: http://www.revolutionanalytics.com/what-is-open-source-r/r-resources.php    	
# Quick R: http://www.statmethods.net/  	
# R Reference Card: http://cran.r-project.org/doc/contrib/Short-refcard.pdf    	
# An online book: http://www.cookbook-r.com/  	
# Hadley Wickham's book, Advanced R: http://adv-r.had.co.nz  	
# CRAN Task Views: http://cran.r-project.org/web/views/    	  	
# Some help with packages: http://crantastic.org/  				                                   	
# the BIOCONDUCTOR PROJECT FOR GENOMICS: http://www.bioconductor.org/     	


### R Blogs	

# Revolutions blog: http://blog.revolutionanalytics.com/  	
# RBloggers: http://www.r-bloggers.com	


### Getting Help	

# If you are looking for help with technical questions about the language 
# please consult the community site (http://www.r-project.org) for frequently 
# asked questions. Ask for help on one of the several R mailing lists  
# http://www.r-project.org/mail.html or Stack Overflow http://stackoverflow.com/questions/tagged/r  	


### Packages used in this set of examples

# Package      | Use
# ----------   | ----------
# ggplot2      | Plots


### Looking at Packages	

# You can extend the functionality of R by installing and loading packages.
# A package is simply a set of functions, and sometimes data
# Package authors can distribute their work on CRAN, https://cran.r-project.org/,
# in addition to other repositors (e.g. BioConductor) and github
# For a list of contributed packages on CRAN, see https://cran.r-project.org/


installed.packages() # list all available installed packages on your machine
search() # list all "attached" or loaded packages	

# You "attach" a package to make it's functions available, using the library() function
# For example, the "foreign" package comes with R and contains functions to import data
# from other systems

library(foreign)

# You can get help on a package using:
library(help = foreign)

# To install a new package, use install.packages()
# Install the ggplot2 package for it's plotting capability

if (!require("ggplot2"))
  install.packages("ggplot2")

# Then load the package

library("ggplot2")
search() # notice that package:ggplot2 is now added to the search list


### A Simple Regression Example	

data(package = "ggplot2") # Look at the data sets that come with the package	
# (Notice that the results in RTVS may pop up, or pop under, in a new window)

# ggplot2 contains a dataset called diamonds
# make this dataset available using the data() function

data(diamonds, package = "ggplot2")

# Create a listing of all objects in the "global environment"
# Look for "diamonds" in the results
ls()
str(diamonds)

head(diamonds) # prints the first few rows


tail(diamonds) # print the last 6 lines	

class(diamonds) # Find out what kind of object it is

dim(diamonds) # look at the dimension of the data frame	



### Vectorized Code	
# This next bit of code shows off a very powerful feature of the R language: how many functions are "vectorized". The function sapply() takes the funcion class() that we just used on the data frame and applies it to all of the columns of the data frame.	

sapply(diamonds, class) # Find out what kind of animals the variables are	

### Plots in R	

# Create a random sample of the diamonds data
diamondSample <- diamonds[sample(nrow(diamonds), 5000),]
dim(diamondSample)

# R has three systems for static graphics: base graphics, lattice and ggplot2. For now we will see how easy it is to produce bare bones plots with the base graphics system.	

# In this sample you use ggplot2


ggplot(diamondSample, aes(x = carat, y = price)) +
  geom_point(colour = "blue")

# Add a log scale

ggplot(diamondSample, aes(x = carat, y = price)) +
    geom_point(colour = "blue") +
    scale_x_log10()

# Add a log scale for both scales

ggplot(diamondSample, aes(x = carat, y = price)) +
        geom_point(colour = "blue") +
        scale_x_log10() +
        scale_y_log10()

### Linear Regression in R	

# Now, let's build a simple regression model, examine the results of the model and plot the points and the regression line.	

model <- lm(log(price) ~ log(carat), data = diamondSample) # build the model	
summary(model) # look at results 	

# extract model coefficients
coef(model)
coef(model)[1]
exp(coef(model)[1])

ggplot(diamondSample, aes(x = carat, y = price)) +
        geom_point(colour = "blue") +
        geom_smooth(method = "lm", colour = "red", size = 2) +
        scale_x_log10() +
        scale_y_log10()


### Regression Diagnostics	

# It is easy to get regression diagnostic plots. The same plot function that plots points either with a formula or with the coordinates also has a "method" for dealing with a model object.	

par(mfrow = c(2, 2)) # Set up for multiple plots on the same figure	
plot(model, col = "blue") # Look at some model diagnostics	


### The Model Object	

# Finally, let's look at the model object. R packs everything that goes with the model, the fornula, and results into the object. You can pick out what you need by indexin into the model object.	

str(model)
model$coefficients
coef(model)
