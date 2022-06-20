setwd("C:/RUPMANDAL/r project/demo/dashboard2")


library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)
library(writexl)

file <- "C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2/NIFT_Data.xlsx"
df <-read_excel(file)
# names(df)
# names(select_if(df,is.numeric))
# nums <- unlist(lapply(df, is.numeric), use.names = FALSE) 
# nums
# target <- c("Tom", "Lynn")
# target

nums <- names(select_if(df, is.numeric))
typeof(nums)
nums
# hs <- "Location"
# v1 <- df%>%group_by(Location)%>%
#   summarise_at(vars(nums), list(sum))
# v1

# -------------------------------------------------------------------------


df["Location"]
v1 <- df%>%group_by(df["Location"])%>%summarise_at(vars(nums), list(sum))
v1
view_folder_path<-"C:\\RUPMANDAL\\r project\\demo\\dashboard2\\dashboard\\views\\"



ui <-dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      id =  "sidebar1",
      menuItem("Create Views", tabName = "page1"),
      menuItem("Visualization", tabName = "page2"),
      menuItem("view", tabName = "page3")
      # conditionalPanel(
      #   'input.sidebar1 == "page2"',
      #   textInput("page", "Create a new View")
      #   
      # )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "page1","This is Page 1",br(),
        fluidRow(
          box(
            title = "Title 3", width = "3", 
            solidHeader = TRUE, 
            status = "success",
            collapsible = TRUE,
            collapsed = TRUE,
            textInput("view_name", "VIEW NAME"),
            fileInput("file1","Choose cvs file", accept=".xlsx"),
            selectInput("Colm", label = "Group by", choices =NULL ),
            selectInput("col2", label = "Summarize", multiple = TRUE, choices =NULL ),
            # textOutput("x1_value")
            actionButton("create", "Create View",class = "btn-primary btn-lg")
          ),
          box(
            title = "Table",
            width = "9",
            solidHeader = TRUE,
            collapsible = TRUE,
            collapsed = TRUE,
            tableOutput("table1")
            
          )
          
        )
      ),
      
      tabItem(
        tabName = "page2", "This is Page 2"
      ),
      
      tabItem(
        tabName = "page3", "This is Page 3"
      )
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
  
  # output$x1_value<- renderText({
    # input$col2
  # })
  
  
  view_data<-reactive({
    req(input$Colm)
    req(input$col2)
    
    # df%>%group_by(Location)%>%
    #     summarise_at(vars(nums), list(sum))
    df<- data_source()
    df<-df%>%group_by(df[input$Colm])%>%
      summarise_at(vars(input$col2),list(sum))
    df
  })
  
  output$table1<- renderTable({
    view_data()
  })
  
  observeEvent(input$create,{
    req(view_data())
   
    id <- 1
    df<- data.frame(input$view_name,input$Colm,input$col2)
    colnames(df) <- c('view','groupby','cols')
    df <- df%>%group_by(view)%>%
      summarise(groupby=toString(sort(unique(input$Colm))),
                cols = toString(sort(unique(input$col2))))
    df<- df        
    write_xlsx(df,paste(view_folder_path,"Views",".xlsx",sep=""))
  })
  # 
  
  # output$text1 <- renderText({
    # file_name()
    # file = input$file1
    # ext <- tools::file_ext(file$datapath)
    # file$datapath
    # file <- tools::file_path_as_absolute(file$datapath)
  # })
  
  
  
  
}

shinyApp(ui, server)