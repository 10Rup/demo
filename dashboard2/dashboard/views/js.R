library(shinyjs)

# library(shiny)

# ui <- fluidPage(
#   tags$style(
#     "p, div {
#       color: red;
#     }"
#   ),
#   p("Hello World")
# )
# 
# server <- function(input, output) {}
# 
# shinyApp(ui, server)


library(shiny)

ui <- fluidPage(
  tags$script(
    "function changeColor(color){
       document.getElementById('id1').style.color = color;
     }
    "
  ),
  p(id = "id1", onclick="changeColor('red')", "Hello World")
)

server <- function(input, output, session) {}

shinyApp(ui, server)

