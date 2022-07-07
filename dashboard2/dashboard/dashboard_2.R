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
source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/extra_functions.R")
getwd()
# setwd("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views")

header <- dashboardHeader()
sidebar <- dashboardSidebar(cvp.side_menu)
# body <-cvp.body





ui <-dashboardPage(
  header,
  sidebar,
  # body
  dashboardBody(
    # tags$html(
    #   tags$head(
    #     tags$title('My first page')
    #   ),
    #   tags$body(
    #     h1('My first heading'),
    #     p('My first paragraph, with some ', strong('bold'), ' text.'),
    #     div(
    #       id = 'myDiv', class = 'simpleDiv',
    #       'Here is a div with some attributes.'
    #     )
    #   )
    # ),
    tags$html(
      tags$style(
        
        'body {
          width: 100%;
          height: 100%;
          font-family: "Open Sans", sans-serif;
          padding: 0;
          margin: 0;
        }

        #context-menu {
        position: fixed;
        z-index: 10000;
        width: 150px;
        background: #1b1a1a;
        border-radius: 5px;
        display: none;
        }

        #context-menu .item {
        padding: 8px 10px;
        font-size: 15px;
        color: #eee;
        }
        
        
        #context-menu.visible{
        display: block;
        }'

      ),
      
      tags$script(
        'const contextMenu = document.getElementById("context-menu");
        const scope = document.querySelector("html");
        
        scope.addEventListener("contextmenu", (event) => {
          event.preventDefault();
          
          const { clientX: mouseX, clientY: mouseY } = event;
          
          contextMenu.style.top = `${mouseY}px`;
          contextMenu.style.left = `${mouseX}px`;
          
          contextMenu.classList.add("visible");
        });'
        
      ),
      
      tags$body(
        div(
          id="context-menu",
          div(class="item","Option 1"),
          div(class="item","Option 2"),
          div(class="item","Option 3"),
          div(class="item","Option 4")
        )
      )
    ),
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



