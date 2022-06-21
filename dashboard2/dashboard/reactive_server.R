# server codes
rs.server<-function(input, output, session){
  output$view_name<-renderText({
    input$viewname
  })
}
  

