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

    # create a selection box 
    shinyUI(
      fluidPage(
        titlePanel("Movie Recommender"),
        fluidRow(
          column(10,
                 selectInput("select", label = "Movies 1",choices = "1"),
                 selectInput("select2", label = "Movies 2", choices = "2"),
                 selectInput("select3", label = "Movies 3", choices = "3"),
                 submitButton("Show the result")
          )
        )
      )
    )
    
    