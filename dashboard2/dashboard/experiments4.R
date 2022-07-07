# library(shiny)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#   
#   # Application title
#   titlePanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       numericInput("bins",
#                    "Number of bins:",
#                    min = 1,
#                    max = 50,
#                    value = 30
#       )
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot", click = "plotclick"),
#       uiOutput("plotClickInfo")
#     )
#   )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#   
#   output$distPlot <- renderPlot({
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2] 
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     
#   })
#   
#   output$plotClickInfo <- renderUI({
#     click <- input$plotclick
#     ## Find the KPI
#     if (!is.null(click)){
#       aText <- "More text"
#       aLabel <- 'my label'
#       # calculate point position INSIDE the image as percent of total dimensions
#       # from left (horizontal) and from top (vertical)
#       left_pct <- (click$x - click$domain$left) / (click$domain$right - click$domain$left)
#       top_pct <- (click$domain$top - click$y) / (click$domain$top - click$domain$bottom)
#       
#       # calculate distance from left and bottom side of the picture in pixels
#       left_px <- click$range$left + left_pct * (click$range$right - click$range$left)
#       top_px <- click$range$top + top_pct * (click$range$bottom - click$range$top)
#       
#       # create style property fot tooltip
#       # background color is set so tooltip is a bit transparent
#       # z-index is set so we are sure are tooltip will be on top
#       style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); max-width: 200px;",
#                       "left:", left_px + 2, "px; top:", top_px + 2, "px;")
#       
#       # actual tooltip created as wellPanel
#       wellPanel(
#         style = style,
#         p(HTML(paste0("<b> KPI: </b>", aLabel, "<br/>",
#                       "<b> Information: </b>", aText)))
#       )
#     }
#     else return(NULL)
#   })
#   
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)




# SHINYJS

# library(shiny)
# 
#   ui = fluidPage(
#     useShinyjs(), # Set up shinyjs
#     # Add a CSS class for red text colour
#     inlineCSS(list(.red = "background: red")),
#     actionButton("btn", "Click me"),
#     p(id = "element", "Watch what happens to me")
#   )
#   server = function(input, output) {
#     observeEvent(input$btn, {
#       # Change the following line for more examples
#       toggleClass("element", "red")
#     })
#   }
# shinyApp(ui = ui, server = server)
#   
# ## Not run:
# # The shinyjs function call in the above app can be replaced by
# # any of the following examples to produce similar Shiny apps
# toggleClass(class = "red", id = "element")
# addClass("element", "red")
# removeClass("element", "red")
# ## End(Not run)
# ## toggleClass can be given an optional `condition` argument, which
# ## determines if to add or remove the class
# library(shiny)
# 
# ui = fluidPage(
#   useShinyjs(),
#   inlineCSS(list(.red = "background: red")),
#   checkboxInput("checkbox", "Make it red"),
#   p(id = "element", "Watch what happens to me")
# )
# server = function(input, output) {
#   observe({
#     toggleClass(id = "element", class = "red",
#                 condition = input$checkbox)
#   })
# }
# 
# 
# shinyApp(ui = ui, server = server)




library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot", click = "plotclick"),
      uiOutput("plotClickInfo")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$plotClickInfo <- renderUI({
    click <- input$plotclick
    ## Find the KPI
    if (!is.null(click)){
      aText <- "More text"
      aLabel <- 'my label'
      # calculate point position INSIDE the image as percent of total dimensions
      # from left (horizontal) and from top (vertical)
      left_pct <- (click$x - click$domain$left) / (click$domain$right - click$domain$left)
      top_pct <- (click$domain$top - click$y) / (click$domain$top - click$domain$bottom)
      
      # calculate distance from left and bottom side of the picture in pixels
      left_px <- click$range$left + left_pct * (click$range$right - click$range$left)
      top_px <- click$range$top + top_pct * (click$range$bottom - click$range$top)
      
      # create style property fot tooltip
      # background color is set so tooltip is a bit transparent
      # z-index is set so we are sure are tooltip will be on top
      style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); max-width: 200px;",
                      "left:", left_px + 2, "px; top:", top_px + 2, "px;")
      
      # actual tooltip created as wellPanel
      wellPanel(
        style = style,
        p(HTML(paste0("<b> KPI: </b>", aLabel, "<br/>",
                      "<b> Information: </b>", aText)))
      )
    }
  }
)
  
}


# Run the application 
shinyApp(ui = ui, server = server)





library(shiny)
library(shinyjs)
ui <- fluidPage(
  tags$style(
    "p, div {
      color: red;
    }"
  ),
  p("Hello World"),
  div("A block")
)

server <- function(input, output) {}

shinyApp(ui, server)


library(shiny)

ui <- fluidPage(
  tags$script(
    "function changeColor(color){
       document.getElementById('hello').style.color = color;
     }
    "
  ),
  p(id = "hello", onclick="changeColor('green')", "Hello World")
)

server <- function(input, output, session) {}

shinyApp(ui, server)


