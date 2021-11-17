library(tidyverse)

mpg

myfunction <- function(x){
 y <- as.character(x)
 return(y)
}

myfunction(mpg$displ)

apply(mpg,2,myfunction) #apply myfunction, column wise, to mpg


# divide all numeric values by 2

# Using mutate_if()
div2 <- function(x){
  return(x/2)
}

mpg %>% 
  mutate_if(is.numeric,div2)

# using my own function... if/else
div_by_2 <- function(x){
  if(is.numeric(x)){
    y <- x/2
  }else{
    y=x
  }
  return(y)
}

lapply(mpg, div_by_2) %>% 
  as.data.frame() %>% 
  glimpse()


# cool trick to pasting things together
paste0(3,1:10,"_",LETTERS[1:4])


# splitting names
myvec <- c("Greene, Missouri", "Newton, Missouri")
str_split(myvec,", ") %>% 
  map_chr(1)





library(purrr)

df <- read_csv("./Data/data-shell/names/timepoint_001/price_adjustment_001.csv")

df %>% 
  mutate(FirstName = str_split(ClientName, " ") %>% map_chr(1),
        LastName = str_split(ClientName, " ") %>% map_chr(2),
        formattedName = paste0(LastName, ", ", FirstName))


