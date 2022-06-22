library(shiny)

# ui <- fluidPage(
#   textInput("name", "What's your name?"),
#   textOutput("greeting")
# )
# 
# server <- function(input, output, session) {
#   output$greeting <- renderText({
#     paste0("Hello ", input$name, "!")
#   })
# }
# install.packages("shinyjs")
library(shinyjs)

# 
# ui = fluidPage(
#   useShinyjs(),  # Set up shinyjs
#   "Count:", textOutput("number", inline = TRUE), br(),
#   actionButton("btn", "Click me"), br(),
#   "The button will be pressed automatically every 3 seconds"
# )
# server = function(input, output) {
#   output$number <- renderText({
#     input$btn
#   })
#   
# 
#   observe({
#     click("btn")
#     # invalidateLater(3000)
#   })
# }
#   

# ui = fluidPage(
#   useShinyjs(),  # Set up shinyjs
#   p(id = "date", "Click me to see the date"),
#   p(id = "coords", "Click me to see the mouse coordinates"),
#   p(id = "disappear", "Move your mouse here to make the text below disappear"),
#   p(id = "text", "Hello")
# )
# server = function(input, output) {
#   onclick("date", alert(date()))
#   onclick("coords", function(event) { alert(event) })
#   onevent("mouseenter", "disappear", hide("text"))
#   onevent("mouseleave", "disappear", show("text"))
# }
# install.packages("shinyalert")
library(shinyalert)

ui <- fluidPage(
  useShinyalert()
)

server <- function(input, output) {
  shinyalert(
    title = "Hello",
    text = "This is a modal",
    size = "s", 
    closeOnEsc = TRUE,
    closeOnClickOutside = FALSE,
    html = FALSE,
    type = "success",
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#AEDEF4",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
}


shinyApp(ui, server)