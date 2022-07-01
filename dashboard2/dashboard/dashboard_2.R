library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)
library(openxlsx)
library(shinyjs)
library(shinyalert)
library(keypress)
library(KeyboardSimulator)
source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/server_dashboard.R")
source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/ui_dashboard.R")

getwd()
setwd("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views")

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
# 
# }


shinyApp(ui, server)