library(shiny)

fluidPage(
  headerPanel("Two Horse Race Model"),
  plotOutput("plots"),
  hr(),
  
  fluidRow(
    column(3, br(),
    selectInput(inputId = "graph",
                label = "Type of graph:",
                choices = c("Histogram",
                            "Histogram with Inhibition",
                            "Sigmoidal Fit",
                            "All graphs")),
    sliderInput("obs", "Observations: ",
                min = 1, max = 1000, value = 600),
    h3("Code on:"),
    tags$a("Github", 
           href="https://github.com/karengu30/ShinyApp-Two-Horse-Race-Model"),
    br(),
    actionButton("calcButton", "Calculate")
        ),
    
    column(3, br(), 
       sliderInput("mean", "Mean: ",
                   min = 0, max = 5000, value = 1600),
       sliderInput("std", "Std: ",
                   min = 0, max = 500, value = 100),
       sliderInput("ssrt", "SSRT: ",
                   min = 0 , max = 1000, value = 250)
          ),
    column(3, br(),
       sliderInput("dif_1", "Delay 1: ",
                   min = -1000, max = 1, value = -800),
       sliderInput("dif_2", "Delay 2: ",
                   min = -1000, max = 1, value = -700),
       sliderInput("dif_3", "Delay 3: ",
                   min = -1000, max = 1, value = -600)
           ),
    column(3, br(),
       sliderInput("dif_4", "Delay 4: ",
                   min = -1000, max = 1, value = -500),
       sliderInput("dif_5", "Delay 5: ",
                   min = -1000, max = 1, value = -250),
       sliderInput("dif_6", "Delay 6: ",
                   min = -1000, max = 1, value = 1)
           )
    )
)
