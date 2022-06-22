# server codes
rs.server<- function(input, output, session) {
  # output$name <- renderText({
  #   paste0(input$viewname)
  # })
  
  data_source<- reactive({
    file <- input$reportfile
    req(file)
    read_excel(file$datapath)
    
  })
  
  
}