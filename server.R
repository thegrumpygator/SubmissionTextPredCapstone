# Author: Brian L. Fuller
# Date: 17 April 2016

library(shiny)

# shinyServer(
#      function(input, output) {
#   
#           MyPredictedWords <- reactive({bmerge(input$textin)})
#    
#           
#           output$oPred1 <- renderText({MyPredictedWords()$word[1]})
#           output$oPred2 <- renderText({MyPredictedWords()$word[2]})
#           output$oPred3 <- renderText({MyPredictedWords()$word[3]})
#           output$oTable <- renderTable(MyPredictedWords())
#      }
# )


shinyServer(function(input, output) {
     output$oTable <- renderTable({
          reactive(bmerge(input$textin))() 
     })
     observe({
          # run whenever reset button is pressed
          input$reset
     })
})