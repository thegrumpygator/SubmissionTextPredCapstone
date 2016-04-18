# user interface
# Author: Brian L. Fuller
# Date: 6 April 2016

# THIS IS FOR GRADING SUBMISSION

library(shiny)
# shinyUI(pageWithSidebar( 
#      headerPanel("Text Prediction Test App"), 
#      sidebarPanel( 
#           h4('Left bar label')
#      ), 
#      mainPanel(
#           h3('Text Input Area'),
#           textInput('textin', 'entered text', width = NULL),
#           submitButton('Submit'),
#           h4('Prediction 1'),
#           verbatimTextOutput("oPred1"),
#           h4('Prediction 2'),
#           verbatimTextOutput('oPred2'),
#           h4('Prediction 3'),
#           verbatimTextOutput('oPred3'),
#           tableOutput('oTable')
#      ) 
# ))

shinyUI(fluidPage(
     titlePanel("Text Prediction App"),
     
     fluidRow(
          column(4, wellPanel(
               textInput('textin', "Your Text: ")#,
               #actionButton("reset", "Reset Text")
          )),
          column(8, wellPanel(
               tableOutput("oTable")
          ))
     )
))