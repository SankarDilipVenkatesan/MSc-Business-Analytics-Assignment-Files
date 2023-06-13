############################################################
##Module Name and Code: Applied Customer Analytics MS5108  #
#Student Name and ID:  Dilip Venkatesan Sankar 22225743    #
############################################################

set.seed(7)
#Question1
#Creating two vectors x1 and x1 using rnorm() and rexp() function
x1 <- rnorm(50)
x2 <- rexp(50)

#printing x1 and x2 vectors
x1
x2

#Creating another vector y using linear combination of x1 and x2
y <- 1*x1+1*x2
y

#Creating a dataframe for all three vectors
df = data.frame(x1,x2,y)
df

#Constructing scatter plot to check correlation
plot(df)

#Creating a simple linear regression function using lm() function
value = lm(y~x1+x2,data=df)

#Displaying the results of lm() function
summary(value)


#Question2
#Creating vectors subject,height and weight from the given table
subject <- 1:10
height <- c(1.82,1.56,1.74,1.55,1.63,1.91,2.05,1.84,1.80,1.71)
weight <- c(80.4,66.2,68.9,70.1,75,83.7,105.6,79.5,68,69.4)

#Converting the vectors into a dataframe
df = data.frame(height,weight)
df

#Calculating BMI and storing 
df$BMI <- ((df$weight/df$height)/df$height)
df

#Calculation of mean, SD of height,weight and BMI for df
mean(df$height)
sd(df$height)
mean(df$weight)
sd(df$weight)
mean(df$BMI)
sd(df$BMI)

#Filtering results from df and storing in sample dataframe
sample <- df[df$height >= 1.70 & df$weight < 70,]
sample

#Calculation of mean, SD of height,weight and BMI for sample
mean(sample$height)
sd(sample$height)
mean(sample$weight)
sd(sample$weight)
mean(sample$BMI)
sd(sample$BMI)

##############################################################

