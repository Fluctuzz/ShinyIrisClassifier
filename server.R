library(shiny)
library(ggplot2)
library(rpart)
library(rpart.plot)

data("iris")
fit <- rpart(formula = Species ~ ., data = iris, method = "class", control=rpart.control(cp=0.05))
names(iris) <- gsub(".", " ", names(iris), fixed= TRUE)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$resultFlower <- renderText({
        pred <- predict(fit, newdata =  data.frame("Sepal.Width" = c(1), "Sepal.Length" = c(1),
                                         "Petal.Width" = c(as.numeric(input$petalWidth)), 
                                         "Petal.Length" = c(as.numeric(input$petalLength))))
      flower <- colnames(pred)[which.max(pred)]
      prob <- as.character(round(max(pred),2))
      paste0("Your flower is from the species ", flower, " with a probality of ", prob,".")
      })

  output$tree <- renderPlot(rpart.plot(fit, extra=0))
  output$flowerPlot <- renderPlot({
    
    
    # draw the histogram with the specified number of bins
    xvar <- iris[, as.numeric(input$selX)]
    yvar <- iris[, as.numeric(input$selY)]
    
    ggplot(data = iris, aes(x=xvar, y=yvar, color=Species)) +
        xlab(paste0(names(iris)[as.numeric(input$selX)], " in cm")) +
        ylab(paste0(names(iris)[as.numeric(input$selY)], " in cm"))+
         geom_point()
   # rpart.plot(fit, extra = 0)
  })
  
})
