#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

pageWithSidebar(
  headerPanel('Movie Recommendation'),
  sidebarPanel(
    selectInput('movie_1', 'movie_1', "1"),
    selectInput('movie_2', 'movie_2', "2"),
    selectInput('movie_3', 'movie_3', "3"),
    submitButton("Get Recommendations")),
  mainPanel(
    plotOutput('')))
