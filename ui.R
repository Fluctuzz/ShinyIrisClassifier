library(shiny)
shinyUI(fluidPage(
  titlePanel("Find out the species of your iris flower"),
  p("This website tries to determine the species of your iris flower. 
    The species is predicted by a decision tree, which was trained on the famous (Fisher's or Anderson's) iris data set.
    The decision tree can be seen in middle of the website. Furthermore you can explore the iris dataset by yoursleft in the last graph."),
  splitLayout(
  numericInput("petalWidth", label = h3("Petal width in cm:"), value = 2),
  numericInput("petalLength", label = h3("Petal length in cm:"), value = 3)
  ),
  h3(textOutput("resultFlower")),

  
  h2("Visual Representation of decision tree"),
  plotOutput("tree"),
  
  h2("Explore the dataset"),
  sidebarLayout(
    sidebarPanel(
        selectInput("selX", label = h3("x-Axis of Graph"), 
                    choices = list("Sepal Length" = 1, "Sepal Width" = 2, "Petal Length" = 3, "Petal Width" = 4), 
                    selected = 1),
        selectInput("selY", label = h3("y-Axis of Graph"), 
                    choices = list("Sepal Length" = 1, "Sepal Width" = 2, "Petal Length" = 3, "Petal Width" = 4), 
                    selected = 2)
    ),
    mainPanel(
       plotOutput("flowerPlot")
    )
  )
))
