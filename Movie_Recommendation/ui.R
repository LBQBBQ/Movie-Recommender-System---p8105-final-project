#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)



    # Application title
    titlePanel("Movie Recommendation")
    
    # Create a genre list
    Genre <- c("Adventure", "Animation", "Children", "Comedy", "Fantasy", "Romance", "Drama", "Action", "Crime", "Thriller", "Horror", "Sci-Fi", "Mystery", "War", "Musical", "Documentary")
    
    # create a selection box 
    shinyUI(
      fluidPage(
        titlePanel("Movie Recommender"),
        fluidRow(
          column(5,
                 selectInput("Genre_1", label = "Genre 1",choices = Genre),
                 selectInput("Genre_2", label = "Genre 2", choices = Genre),
                 selectInput("Genre_3", label = "Genre 3", choices = Genre),
                 submitButton("Select movie you like"),
          column(5,
                 selectInput("movie_1", label = "Movie 1",choices = "1"),
                 selectInput("movie_2", label = "Movie 2", choices = "2"),
                 selectInput("movie_3", label = "Movie 3", choices = "3"),
                 submitButton("Get your movie recommendation"))
          )
        )
      )
    )
    
    