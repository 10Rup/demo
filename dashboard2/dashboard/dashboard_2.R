library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)
library(openxlsx)
library(shinyjs)
library(shinyalert)
source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/create_view_page.R")
source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/reactive_server.R")



header <- dashboardHeader()
sidebar <- dashboardSidebar(cvp.side_menu)
# body <-cvp.body





ui <-dashboardPage(
  header,
  sidebar,
  # body
  dashboardBody(
    tabItems(cvp.item1,cvp.item2,cvp.item3)
  )
)

# server <- function(input, output, session) {
  
# }
server<-rs.server
# server <- function(input, output, session) {
#   output$name <- renderText({
#     paste0("Hello ", input$viewname, "!")
#   })
# }


shinyApp(ui, server)