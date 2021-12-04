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
          column(4,
                 selectInput("movie_1", label = "movie 1",choices = "1"),
                 submitButton("Select movie you like"),
          column(5,
                 selectInput("movie_2", label = "Movie 2",choices = "2"),
                 submitButton("Select movie you like again")),
          column(6,
                 selectInput("movie_3", label = "Movie 3",choices = "3"),
                 submitButton("Select movie you like (last time!)"))
          )
        )
      )
    )
    
    