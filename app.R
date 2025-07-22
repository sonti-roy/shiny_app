library(shiny)
library(ggplot2)
library(dplyr)
library(readr)

# Load default data
default_data <- read_csv("medical_data.csv")

ui <- fluidPage(
  titlePanel("Data Analytics Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("varselect_x"),
      uiOutput("varselect_y"),
      actionButton("update", "Update Plots")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary Stats", 
                 h4("Summary of Dataset"),
                 verbatimTextOutput("summary"),
                 h4("First 10 Rows"),
                 tableOutput("data_head")),
        tabPanel("Histogram", plotOutput("histPlot")),
        tabPanel("Scatter Plot", plotOutput("scatterPlot"))
      )
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    default_data
  })
  
  output$data_head <- renderTable({
    head(data(), 10)
  })
  
  output$summary <- renderPrint({
    summary(data())
  })
  
  output$varselect_x <- renderUI({
    selectInput("xcol", "X Variable", names(data()))
  })
  
  output$varselect_y <- renderUI({
    selectInput("ycol", "Y Variable", names(data()))
  })
  
  output$histPlot <- renderPlot({
    req(input$xcol)
    ggplot(data(), aes_string(x = input$xcol)) +
      geom_histogram(bins = 30, fill = "steelblue", color = "white") +
      theme_minimal()
  })
  
  output$scatterPlot <- renderPlot({
    req(input$xcol, input$ycol)
    ggplot(data(), aes_string(x = input$xcol, y = input$ycol)) +
      geom_point(color = "tomato") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)
