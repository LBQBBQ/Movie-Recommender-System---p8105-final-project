#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)

mv = read_csv("./data/small/movies.csv")



cut_year = function(string){
  year_str = str_split(string, pattern = "\\(")[[1]]
  year_str = str_remove(year_str[length(year_str)], "\\)")
  return(as.integer(year_str))
}

mv_year = 
  filter(year >= 1990) %>% 
  mv %>%
  mutate(
    year = map(title, cut_year),
    year = as.integer(year)
  ) %>% 
  arrange(desc(year))

genres = movies$genres
genres = str_split(genres, "\\|", simplify = TRUE)
genres = as.character(genres)
genres = sort(unique(genres))

genre_name <- c()

# ui

ui <- fluidPage(
  headerPanel('Movie Recommendation'),
  sidebarPanel(
    sliderInput("year", "select year", 1990, 2018, value = c(1990, 2000),
                sep = ""),
    selectInput('genre', 'select genre', mv_genres),
    selectInput('movie', 'select movie', "1", "1" ),
    selectInput('rating', 'select rating(from 1 to 5)', seq(1.0, 5.0, 0.5)),
    actionButton('addRating', 'Add rating'),
    submitButton("See recommendation")),
  
  mainPanel(
    textOutput("text")
))

# server

server <- function(input, output){
  }
 

# ShinyApp
 shinyApp(ui = ui, server = server)