library(shiny)
library(plotly)

d <- data.frame(x = c(1,2,3), y = c(9,99,999))

ui <- fluidPage(
  plotlyOutput("plot"),
  
  actionButton("button", "toggle visibility"))

server <- function(input, output) {
  
  output$plot <- renderPlotly({
    plot_ly(d)%>%
      add_lines(y=d$y, x= d$x)%>%
      layout(annotations = list(x = 2, y= 99 , text = "hi"))
  })
  
  observeEvent(input$button, {
    plotlyProxy("plot", session= shiny::getDefaultReactiveDomain()) %>%
      plotlyProxyInvoke("relayout", list(annotations= list(list(x = 2, y= 99 , 
                                                                text = "ho"))))})}



shinyApp(ui, server)
