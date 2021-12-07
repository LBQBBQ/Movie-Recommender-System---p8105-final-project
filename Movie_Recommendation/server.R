#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
"shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
"
#output$table <- renderTable({
#    movie_recommendation(#input$select, #input$select2, #input$select3)
#})

#}
#)
    
#"Adventure" = selectInput("Choose one genre", "Genre_1",
#                          choices = "a",
#                          selected = "a"),
#"Animation" = selectInput("Choose one genre", "Genre_1",
#                          choices = "a",
#                          selected = "a"),
#"Children" = selectInput("Choose one genre", "Genre_1",
#                         choices = "a",
#                         selected = "a"),
#"Comedy" = selectInput("Choose one genre", "Genre_1",
#                       choices = "a",
#                       selected = "a"),
#"Fantasy" = selectInput("Choose one genre", "Genre_1",
#                        choices = "a",
#                        selected = "a"),
#"Romance" = selectInput("Choose one genre", "Genre_1",
#                        choices = "a",
#                        selected = "a"),
#"Drama" = selectInput("Choose one genre", "Genre_1",
#                      choices = "a",
#                      selected = "a"),
#"Action" = selectInput("Choose one genre", "Genre_1",
#                      choices = "a",
#                       selected = "a"),
#"Crime" = selectInput("Choose one genre", "Genre_1",
#                      choices = "a",
#                      selected = "a"),
#"Thriller" = selectInput("Choose one genre", "Genre_1",
#                         choices = "a",
#                         selected = "a"),
#"Horror" = selectInput("Choose one genre", "Genre_1",
#                       choices = "a",
#                       selected = "a"),
#Sci-Fi" = selectInput("Choose one genre", "Genre_1",
#                       choices = "a",
#                       selected = "a"),
#"Mystery" = selectInput("Choose one genre", "Genre_1",
#                        choices = "a",
#                        selected = "a"),
#"War" = selectInput("Choose one genre", "Genre_1",
#                    choices = "a",
#                    selected = "a"),
#"Musical" = selectInput("Choose one genre", "Genre_1",
#                        choices = "a",
#                        selected = "a"),
#"Documentary" = selectInput("Choose one genre", "Genre_1",
#                            choices = "a",
#                            selected = "a")
    