setwd("C:/RUPMANDAL/r project/demo/dashboard2")


library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)


# read.csv(file$datapath, header = input$header)
# target <- c("Tom", "Lynn")
# target


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1","Choose cvs file", accept=".xlsx")
    ),
    mainPanel(
      textOutput("text1"),
      tableOutput("table1")
    )
  )
  
)

server <- function(input, output, session) {
  file_name <- reactive({
    file = input$file1
    file$datapath
    # file <- tools::file_path_as_absolute(file$datapath)
  })
  
  
  output$text1 <- renderText({
    file_name()
    # file = input$file1
    # ext <- tools::file_ext(file$datapath)
    # file$datapath
    # file <- tools::file_path_as_absolute(file$datapath)
  })
  
  output$table1 <- renderTable({
    file <- input$file1
    ext <-tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "xlsx", "upload a csv file"))
    
    read_excel(file$datapath)
    
  })
  
  
}

shinyApp(ui, server)