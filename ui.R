#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict Tree size from Age"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderAge", "What is the Age of the tree?", 100, 2000, value = 1100, step = 100),
      sliderInput("sliderBreak", "What is the Age breaking point?", 600, 1500, value = 950, step = 50),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
        plotOutput("plot1"),
        h3("Predicted Age from Model 1:"),
        textOutput("pred1"),
        h3("Predicted Age from Model 2:"),
        textOutput("pred2"),
        br(),
        p(
"This tool allows you to test various age groupings' impact on a linear model prediction
at various points along the dataset, demonstrating its distortion around the breaking point"
        ),
        br(),
        p(
"The underlying data used here is a table of measured orange trees sizes related to the trees' ages."        
        )
      )
    )
  )
)
