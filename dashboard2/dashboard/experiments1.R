library(shiny)
library(readxl)
library(dplyr)
library(tidyr)
library(shinydashboard)
library(openxlsx)

file <- "C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2/NIFT_Data.xlsx"

source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/create_view_page.R")

s<- c("a","b","c")
s

v<-toString(sort(unique(s)))
v


demo_func("sdads")


# data <- read_xlsx(file.choose())
# data
# variable.names(data)
# 
# select_file <- function(){
#   data <- read_xlsx(file.choose())
#   data
# }
# 
# select_file()

data <-read_xlsx("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/bbbb.xlsx")
data

# data_2<- data%>%
  # mutate(cols = strsplit(as.character(cols),","))%>%
  # unnest(cols)
# data_2<- data%>% separate_rows(cols)
data_2<- data%>%separate_rows(cols, sep = ", ", convert = TRUE)
data_2


# live_data<- read_xlsx("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2/NIFT_Data.xlsx")
# live_data

# c<-data["groupby"]
# group<-unique(data_2$groupby)
# group
# cols<-data_2$cols
# typeof(cols)
# cols
# df <- live_data%>%group_by(live_data[c])%>%summarise_at(vars(cols), list(sum))
# df

view_name = "me"
group_by = "gp_me"
columns = "sx, sy, ssz"
VIEW_PATH <-"C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/Views.xlsx"
df <- data.frame( view_name, group_by, columns)
df
cvp.append_func(VIEW_PATH,df)






# # df$id<- new_id

# new_id <-2
# df

# df_new <- cbind(new_id,df)
# df_new
VIEW_PATH <-"C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/Views.xlsx"
wb <- loadWorkbook(file = VIEW_PATH)
wb
view_df<-readWorkbook(VIEW_PATH)
view_df
new_id <- max(view_df$id)+1
df <- data.frame(new_id, view_name, group_by, columns)
df
writeData(wb,
          "Sheet1",
          df,
          colNames = FALSE,
          startRow = 1+nrow(view_df)+1)
saveWorkbook(wb, file = VIEW_PATH, overwrite = TRUE)

# append_func <- function(filepath,dataframe){
#   library(openxlsx)
#   wb <- loadWorkbook(file = VIEW_PATH)
#   view_df<-readWorkbook(VIEW_PATH)
#   id <- max(view_df$id)+1
#   df<- cbind(id,dataframe)
#   writeData(wb,"Sheet1",df,colNames = FALSE,startRow = 1+nrow(view_df)+1)
#   saveWorkbook(wb, file = VIEW_PATH, overwrite = TRUE)
#   return(paste("Updated"))
#   # filepath
# }
# 
# append_func(VIEW_PATH,df)



# ui <- fluidPage(
#   numericInput("min", "Minimum", 0),
#   numericInput("max", "Maximum", 3),
#   sliderInput("n", "n", min = 0, max = 3, value = 1)
# )
# server <- function(input, output, session) {
#   observeEvent(input$min, {
#     updateSliderInput(inputId = "n", min = input$min)
#   })  
#   observeEvent(input$max, {
#     updateSliderInput(inputId = "n", max = input$max)
#   })
# }


# ui <- fluidPage(
#   sliderInput("x1", "x1", 0, min = -10, max = 10),
#   sliderInput("x2", "x2", 0, min = -10, max = 10),
#   sliderInput("x3", "x3", 0, min = -10, max = 10),
#   actionButton("reset", "Reset")
# )
# 
# server <- function(input, output, session) {
#   observeEvent(input$reset, {
#     updateSliderInput(inputId = "x1", value = 0)
#     updateSliderInput(inputId = "x2", value = 0)
#     updateSliderInput(inputId = "x3", value = 0)
#   })
# }


# 
# sales <- vroom::vroom("sales_data_sample.csv", col_types = list(), na = "")
# sales %>% 
#   select(TERRITORY, CUSTOMERNAME, ORDERNUMBER, everything()) %>%
#   arrange(ORDERNUMBER)



# ui <- fluidPage(
#   selectInput("territory", "Territory", choices = unique(sales$TERRITORY)),
#   selectInput("customername", "Customer", choices = NULL),
#   selectInput("ordernumber", "Order number", choices = NULL),
#   tableOutput("data")
# )
# 
# server <- function(input, output, session) {
#   territory <- reactive({
#     filter(sales, TERRITORY == input$territory)
#   })
#   observeEvent(territory(), {
#     choices <- unique(territory()$CUSTOMERNAME)
#     updateSelectInput(inputId = "customername", choices = choices) 
#   })
#   
#   customer <- reactive({
#     req(input$customername)
#     filter(territory(), CUSTOMERNAME == input$customername)
#   })
#   observeEvent(customer(), {
#     choices <- unique(customer()$ORDERNUMBER)
#     updateSelectInput(inputId = "ordernumber", choices = choices)
#   })
#   
#   output$data <- renderTable({
#     req(input$ordernumber)
#     customer() %>% 
#       filter(ORDERNUMBER == input$ordernumber) %>% 
#       select(QUANTITYORDERED, PRICEEACH, PRODUCTCODE)
#   })
# }



library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  
  # title ----
  dashboardHeader(title = "Test Application"),
  
  # sidebar ----
  dashboardSidebar(
    sidebarMenu(id = "sidebarid",
                menuItem("Page 1", tabName = "page1"),
                menuItem("Page 2", tabName = "page2"),
                conditionalPanel(
                  'input.sidebarid == "page2"',
                  sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
                  selectInput("title", "Select plot title:", choices = c("Hist of x", "Histogram of x"))
                )
    )
  ),
  
  # body ----
  dashboardBody(
    tabItems(
      # page 1 ----
      tabItem(tabName = "page1", "Page 1 content. This page doesn't have any sidebar menu items."),
      # page 2 ----
      tabItem(tabName = "page2", 
              "Page 2 content. This page has sidebar meny items that are used in the plot below.",
              br(), br(),plotOutput("distPlot")
              )
    )
  )
)

# server -----------------------------------------------------------------------

server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "darkgray", border = "white", main = input$title)
  })
  
}

# shiny app --------------------------------------------------------------------

shinyApp(ui, server)