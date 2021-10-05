# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150
even <- seq(2,150,2)
iris_even_row <- iris[even,] 
  print(iris_even_row)

# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class

iris_chr <- as.character(iris)

# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width

Sepal.Area <- dat$Sepal.Length*dat$Sepal.Width


# 4.  Add Sepal.Area to the iris data frame as a new column

iris$Sepal.Area <- Sepal.Area

# 5.  Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
      # (name it big_area_iris)
area_row <- iris$Sepal.Area > 20
big_area_iris <- iris[area_row,]

# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
      # to canvas
      # I should be able to run your R script and get all the right objects generated

