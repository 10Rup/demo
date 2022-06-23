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

# ui <- fluidPage(
#   useShinyalert()
# )
# 
# server <- function(input, output) {
#   shinyalert(
#     title = "Hello",
#     text = "This is a modal",
#     size = "s", 
#     closeOnEsc = TRUE,
#     closeOnClickOutside = FALSE,
#     html = FALSE,
#     type = "success",
#     showConfirmButton = TRUE,
#     showCancelButton = FALSE,
#     confirmButtonText = "OK",
#     confirmButtonCol = "#AEDEF4",
#     timer = 0,
#     imageUrl = "",
#     animation = TRUE
#   )
# }
# 
# 




# ui <- fluidPage(
#   textInput("viewname", "VIEW NAME"),
#   actionButton("preview", "Preview")
# )
# 
# server <- function(input, output, session) {
#   
#   condition<- reactive({
#     paste0("1")
#   })
#   
#   observeEvent(input$preview, {
#     # Show a modal when the button is pressed
#     req(input$viewname)
#     shinyalert("Oops!", "Something went wrong.", type = "error")
#   })
# }


# demo
# listOfAnns <- list("demo"," dadsdsdemo", "dsd", "sasd")
# listOfAnns
# 
# 
identical(listOfAnns,'demo', ignore.bytecode=FALSE)
VIEW_PATH <-"C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/Views.xlsx"
views<-readWorkbook(VIEW_PATH)
views$view_name
views["view_name"]
# 
# "demno" %in% list(views["view_name"])
# identical(views["view_name"],'demo')
# 
# "a" %in% "a"
a<-c(unique(views$view_name))
a
"demo" %in% a
indentical(a,"demo")


ui <- fluidPage(
  checkboxGroupInput('in1', 'Check some letters', choices = head(LETTERS)),
  selectizeInput('in2', 'Select a state', choices = c("", state.name)),
  plotOutput('plot')
)

server <- function(input, output) {
  output$plot <- renderPlot({
    validate(
      need(input$in1, 'Check at least one letter!'),
      need(input$in2 != '', 'Please choose a state.')
    )
    plot(1:10, main = paste(c(input$in1, input$in2), collapse = ', '))
  })
}

shinyApp(ui, server)

