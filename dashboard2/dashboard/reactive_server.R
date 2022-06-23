source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/create_view_page.R")
VIEW_PATH <-"C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/Views.xlsx"

# server codes
rs.server<- function(input, output, session) {
  output$name <- renderText({
    # views<-readWorkbook(VIEW_PATH)
    # existing_views<-c(unique(views$view_name))
    # validate(
    # need(input$viewname %in% existing_views == FALSE,"Already Exists")
    # )
    paste0(input$viewname)
  })
  
  observeEvent(input$viewname,{
    
    req(input$viewname)
    # validate(
    #   need(input$viewname %in% existing_views == FALSE,
    #        shinyalert(
    #          "Already Exists!",
    #          "",
    #          type = "warning",
    #          showConfirmButton = TRUE,))
    # )
    views<-readWorkbook(VIEW_PATH)
    existing_views<-c(unique(views$view_name))
    validate(
      need(input$viewname %in% existing_views == FALSE,"Already Exists")
    )

  })
  
  
  data_source<- reactive({
    file <- input$reportfile
    req(file)
    read_excel(file$datapath)
    
  })
  
  observeEvent(data_source(),{
    choices <- names(data_source()) 
    updateSelectInput(inputId = "groupby", choices = c(choices))
  })
  
  observeEvent(data_source(),{
    choices <- names(select_if(data_source(), is.numeric))
    updateSelectInput(inputId = "summarize", choices = c(choices))
  })
  
  new_data<- reactive({
    view_name<- input$viewname
    group<- input$groupby
  summarize<- input$summarize
  sumrz<-toString(sort(unique(summarize)))
  df<-data.frame(view_name,group,sumrz)
  })
  
  # on_click_create<-reactive({
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
  # })
  
  observeEvent(input$create,{
    # req(input$reportfile)
    req(input$viewname,input$reportfile)
    
    cvp.append_func(VIEW_PATH,new_data())
    shinyalert(
      "Updated!",
      "View Created", 
      type = "success",
      showConfirmButton = FALSE,)
    
  })
  
  # observeEvent({})
  # onclick(id = "create",alert("Data Updated"))
  # onclick(id = "create",on_click_create())

}
