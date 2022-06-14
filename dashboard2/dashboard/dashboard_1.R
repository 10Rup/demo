setwd("C:/RUPMANDAL/r project/demo/dashboard2")


library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)

file <- "C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2/NIFT_Data.xlsx"
df <-read_excel(file)
# names(df)
# names(select_if(df,is.numeric))
# nums <- unlist(lapply(df, is.numeric), use.names = FALSE) 
# nums
# target <- c("Tom", "Lynn")
# target

# nums <- names(select_if(df, is.numeric))
# nums
# hs <- "Location"
# v1 <- df%>%group_by(Location)%>%
#   summarise_at(vars(nums), list(sum))
# v1

df["Location"]
v1 <- df%>%group_by(df["Location"])%>%summarise_at(vars(nums), list(sum))
v1


ui <-dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        title = "Title 3", width = "3", 
        solidHeader = TRUE, 
        status = "success",
        collapsible = TRUE,
        collapsed = TRUE,
        fileInput("file1","Choose cvs file", accept=".xlsx"),
        selectInput("Colm", label = "Group by", choices =NULL ),
        selectInput("col2", label = "Summarize", multiple = TRUE, choices =NULL ),
        textOutput("x1_value")
      ),
      box(
        title = "Table",
        width = "9",
        solidHeader = TRUE,
        collapsible = TRUE,
        collapsed = TRUE,
        tableOutput("table1")
       
      )
      
    ),
    fluidRow(
      
    )
    
  )
)

server <- function(input, output, session) {
  # file_name <- reactive({
  #   file = input$file1
  #   file$datapath
  #   # file <- tools::file_path_as_absolute(file$datapath)
  # })
  
  data_source<- reactive({
    file <- input$file1
    
    req(file)
    read_excel(file$datapath)
    
  })
  
  
  
  
  observeEvent(data_source(),{
    choices <- names(data_source()) 
    updateSelectInput(inputId = "Colm", choices = c(choices))
  })
  
  observeEvent(data_source(),{
    choices <- names(select_if(data_source(), is.numeric))
    updateSelectInput(inputId = "col2", choices = c(choices))
  })
  
  output$x1_value<- renderText({
    input$col2
  })
  
  
  output$table1<- renderTable({
    # req(input$Colm)
    # req(input$col2)
    
    # df%>%group_by(Location)%>%
    #     summarise_at(vars(nums), list(sum))
    df<- data_source()
    df<-df%>%group_by(df[input$Colm])%>%
    summarise_at(vars(input$col2),list(sum))
    df
  })
  
  
  
  # col2_data<- reactive({
  #   req(input$colms)
  # })
  # 
  
  
  output$text1 <- renderText({
    file_name()
    # file = input$file1
    # ext <- tools::file_ext(file$datapath)
    # file$datapath
    # file <- tools::file_path_as_absolute(file$datapath)
  })
  
  # output$table1 <- renderTable({
  #   file <- input$file1
  #   ext <-tools::file_ext(file$datapath)
  #   
  #   req(file)
  #   validate(need(ext == "xlsx", "upload a csv file"))
  #   
  #   read_excel(file$datapath)
  #   
  # })
  
  
}

shinyApp(ui, server)