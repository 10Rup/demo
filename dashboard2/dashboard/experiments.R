library(shiny)
library(readxl)
data <- read_xlsx(file.choose())
data


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



sales <- vroom::vroom("sales_data_sample.csv", col_types = list(), na = "")
sales %>% 
  select(TERRITORY, CUSTOMERNAME, ORDERNUMBER, everything()) %>%
  arrange(ORDERNUMBER)



ui <- fluidPage(
  selectInput("territory", "Territory", choices = unique(sales$TERRITORY)),
  selectInput("customername", "Customer", choices = NULL),
  selectInput("ordernumber", "Order number", choices = NULL),
  tableOutput("data")
)

server <- function(input, output, session) {
  territory <- reactive({
    filter(sales, TERRITORY == input$territory)
  })
  observeEvent(territory(), {
    choices <- unique(territory()$CUSTOMERNAME)
    updateSelectInput(inputId = "customername", choices = choices) 
  })
  
  customer <- reactive({
    req(input$customername)
    filter(territory(), CUSTOMERNAME == input$customername)
  })
  observeEvent(customer(), {
    choices <- unique(customer()$ORDERNUMBER)
    updateSelectInput(inputId = "ordernumber", choices = choices)
  })
  
  output$data <- renderTable({
    req(input$ordernumber)
    customer() %>% 
      filter(ORDERNUMBER == input$ordernumber) %>% 
      select(QUANTITYORDERED, PRICEEACH, PRODUCTCODE)
  })
}












shinyApp(ui, server)