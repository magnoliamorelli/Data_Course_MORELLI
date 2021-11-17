library(tidyverse)
library(rvest)


# Reading in Website
simple <- read_html("https://dataquestio.github.io/web-scraping-pages/simple.html")

simple

# wanting to store text contained in <p> as variable
# use html_nodes() and html_text() to search for <p>
simple %>% 
  html_nodes("p") %>% 
  html_text()




# Reading in forecasts
forecasts <- read_html("https://forecast.weather.gov/MapClick.php?lat=37.7771&lon=-122.4196#.Xl0j6BNKhTY") %>% 
  html_nodes(".temp") %>% 
  html_text()

forecasts


# Formatting
library(readr)

parse_number(forecasts)




# more
library(dplyr)

# harvesting Position Number, Artist, song tile for hot 100
hot100page <- "https://www.billboard.com/charts/hot-100"
hot100 <- read_html(hot100page)

hot100
str(hot100)

# Gives list of nodes inside body of page
body_nodes <- hot100 %>% 
  html_nodes("body") %>% 
  html_children()
body_nodes
# Even deeper
body_nodes %>% 
  html_children()

# Collecting data we want
rank <- hot100 %>% 
  rvest::html_nodes("body") %>% 
  xml2::xml_find_all("//span[contains(@class, 'chart-element__rank__number')]") %>% 
  rvest::html_text()

artist <- hot100 %>% 
  rvest::html_nodes("body") %>% 
  xml2::xml_find_all("//span[contains(@class, 'chart-element__information__artist')]") %>% 
  rvest::html_text()

title <- hot100 %>% 
  rvest::html_nodes("body") %>% 
  xml2::xml_find_all("//span[contains(@class, 'chart-element__information__song')]") %>% 
  rvest::html_text()

# Combining into DataFrame
chart_df <- data.frame(rank, artist, title)

knitr::kable(
  chart_df %>% head(10)
)


# Creating function to get data for any time
get_chart <- function(date = Sys.Date(), positions = c(1:10), type = "hot-100") {
  
  # get url from input and read html
  input <- paste0("https://www.billboard.com/charts/", type, "/", date) 
  chart_page <- xml2::read_html(input)
  
  
  # scrape data
  rank <- chart_page %>% 
    rvest::html_nodes('body') %>% 
    xml2::xml_find_all("//span[contains(@class, 'chart-element__rank__number')]") %>% 
    rvest::html_text()
  
  artist <- chart_page %>% 
    rvest::html_nodes('body') %>% 
    xml2::xml_find_all("//span[contains(@class, 'chart-element__information__artist')]") %>% 
    rvest::html_text()
  
  title <- chart_page %>% 
    rvest::html_nodes('body') %>% 
    xml2::xml_find_all("//span[contains(@class, 'chart-element__information__song')]") %>% 
    rvest::html_text()
  
  # create dataframe, remove nas and return result
  chart_df <- data.frame(rank, artist, title)
  chart_df <- chart_df %>% 
    dplyr::filter(!is.na(rank), rank %in% positions)
  
  chart_df
  
}

# Testing function
test <- get_chart(date = "1997-10-24", positions = 1:10, type = "hot-100")
test




# More 

# Scraping webpage to get HTML code in lines
scrape_url <- "https://www.york.ac.uk/teaching/cws/wws/webpage1.html"
flat_html <- readLines(con = scrape_url) 



# Requesting data over FTP
# 1. Save ftp URL
# 2. Save names of files from the URL into an R object
# 3. Save files onto your local directory
library(RCurl)
library(RDocumentation)
ftp_url <- "ftp://cran.r-project.org/pub/R/web/packages/BayesMixSurv/"
get_files <- getURL(ftp_url, dirlistonly = TRUE)

get_files

extracted_filenames <- str_split(get_files, "\r\n")[[1]]
extracted_html_filenames <- unlist(str_extract_all(extracted_filenames, ".+(html)"))

extracted_html_filenames



# Scraping info from Wiki
library(XML)
wiki_url <- "https://en.wikipedia.org/wiki/Leonardo_da_Vinci"
wiki_read <- readLines(wiki_url, encoding = "UTF-8")
parsed_wiki <- htmlParse(wiki_read, encoding = "UTF-8")

wiki_intro_text <- parsed_wiki["//p"]
wiki_intro_text[[4]]

getHTMLLinks(wiki_read)


# Reading HTML tables
wiki_url1 <- "https://en.wikipedia.org/wiki/Help:Table"
wiki_read1 <- readLines(wiki_url1, encoding = "UTF-8")


length((readHTMLTable(wiki_read1)))
names(readHTMLTable(wiki_read1))

readHTMLTable(wiki_read1)$"The table's caption\n" 


# More webscraping tables
library(tidyverse)

content <- read_html("https://en.wikipedia.org/wiki/List_of_highest-grossing_films_in_the_United_States_and_Canada")
tables <- content %>% 
  html_table(fill = TRUE)

first_table <- tables[[1]]

#####
web <- read_html("https://simple.wikipedia.org/wiki/List_of_countries")
df <- web %>% 
  html_table()

the_table <- df[[1]]
