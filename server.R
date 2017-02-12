library(shiny)

shinyServer(function(input, output) {
  
  
  dataSet <- reactive({
  breakPoint <- input$sliderBreak
  
  dataSet <- Orange
  dataSet$ageGroup <- ifelse(dataSet$age - breakPoint > 0, dataSet$age - breakPoint, 0)

  return(dataSet)
  })
  
  model1 <- reactive({
  dataSet <- dataSet()
  ageInput <- input$sliderAge
  model1 <- lm(circumference ~ age, data = dataSet)
  })
  
  
  model1pred <- reactive({
    model1 <- model1()
    dataSet <- dataSet()
    ageInput <- input$sliderAge
    model1 <- lm(circumference ~ age, data = dataSet)
    predict(model1, newdata = data.frame(age = ageInput))
  })
  
  model2<- reactive({
  dataSet <- dataSet()
  breakPoint <- input$sliderBreak
  ageInput <- input$sliderAge
  model2 <- lm(circumference ~ age + ageGroup, data = dataSet)
  
  })
  
  model2pred <- reactive({
    model2 <- model2()
    dataSet <- dataSet()
    breakPoint <- input$sliderBreak
    ageInput <- input$sliderAge
    predict(model2, newdata = 
              data.frame(age = ageInput,
                         ageGroup = ifelse(ageInput - breakPoint > 0,
                                           ageInput - breakPoint, 0)))
  })
  
  output$plot1 <- renderPlot({
    dataSet <- dataSet()
    ageInput <- input$sliderAge
    breakPoint <- input$sliderBreak
    model1 <- model1()
    model2 <- model2()
    plot(dataSet$age, dataSet$circumference, xlab = "Tree age in days", 
         ylab = "circumference", bty = "n", pch = 16,
         xlim = c(0, 2000), ylim = c(10, 250))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        age = 1:2000, ageGroup = ifelse(1:2000 - breakPoint > 0, 1:2000 - breakPoint, 0)
      ))
      lines(1:2000, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(ageInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(ageInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})
