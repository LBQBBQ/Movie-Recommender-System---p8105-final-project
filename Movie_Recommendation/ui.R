#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
  headerPanel('Movie Recommendation'),
  sidebarPanel(
    sliderInput("year", "Filter movie year", 1990, 2018, value = c(1990, 2000),
                sep = ""),
    selectInput('movie', 'select movie', "1", "1" ),
    selectInput('rate', 'select rate', "2", "2"),
    submitButton("Add rating"),
    submitButton("See recommendation")),
  mainPanel(
    textOutput("text")
))
 
server <- function(input, output){
 }
 
 shinyApp(ui = ui, server = server)