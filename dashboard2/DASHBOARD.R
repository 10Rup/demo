library(ggplot2)
library(shiny)
library(readxl)
library(dplyr)
library(plotly)
library(shinydashboard)
library(tidyverse)
library(gridExtra)
library(gganimate)
setwd("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2")
box_value1 <- "sasda"

# data <- read_excel("data.xlsx")
data <- read_excel("NIFT_Data.xlsx")
data
# demo <- select(data, course_id)
# unique(demo)
# names(data)
# data1 <- data%>%filter(Location == 'Chennai')
# data1











# Data for Box
total_seat <- data%>%summarise_at(vars(no_of_seat), list(sum))
total_seat





ui <-dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      column(
        width = 3,
        box(
          title ="TOTAL SEATS", 
          status = "success",  width = NULL,
          solidHeader = TRUE,
          align ="center",
          total_seat
        )
      )
      # column(
      #   width = 3,
      #   box(
      #     title = "Bar Plot" ,
      #     status = "warning", width = NULL,
      #     "Box content"
      #   )
      # ),
      # 
      #   
      #   valueBox(
      #     tagList("60", tags$sup(style="font-size: 20px", "%")),
      #     "Approval Rating", icon = icon("line-chart"), color = "green"
      #   )
      
      
    ),
    fluidRow(
      box( width = "100%",
           # height = "600",
           
           title = "CAMPUS WISE PLOT",
           plotlyOutput("campus_plot", width = "100%",#height = 300, width = 300,
           ),
           textOutput("campus_name")
      )
    ),
    fluidRow(
      box( width = "6",
        
        title = "Course Wise Campus Preference",
        plotlyOutput("plot1", width = "100%",#height = 300, width = 300,
        ),
        textOutput("x_value")
      ),
      box(
        width = "6",
        title = "Course Wise Campus Preference",
        plotlyOutput("plot2", width = "100%",#height = 300, width = 300,
        ),
        textOutput("x2_value")
      )
      
    ),
    # fluidRow(
    #   box(
    #     title = "Dynamic Bar Plot",
    #     plotlyOutput("dynamicplot1", width = "100%",#height = 300, width = 300,
    #     ),
    #     textOutput("x1_value")
    #     )
    #   
    #   
    # ),
    # fluidRow(
    #   box(tableOutput("DYNAMIC_TABLE")
    #   )
    # )
  )
)




server <- function(input, output) {
  data_table <- reactive({
    data <- read_excel("NIFT_Data.xlsx")
    data
  })
  
  
  output$campus_plot <- renderPlotly({
    data1 <- data_table()
    campus<-select(data1,Location,College,seat_type,no_of_seat,alloted_no,Available)
    campus<- campus%>%group_by(Location)%>%
      summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
    
    cplot <- ggplot(data = campus, aes(x= Location, y = Total_Seat, fill = Location, customdata = Location))+
      geom_bar(stat = 'identity', width = 0.5)+
      # geom_text()
      # geom_label()
      labs(y = "Seat Count", x = "Campus")+
      theme(axis.text.x = element_text(angle = 60, hjust = 1),
            legend.position = "none")
    # theme(plot.title = element_text(hjust = 0.5))
    
    
    ggplotly(cplot, tooltip = c("text", "size"), source = "A")%>%config(displayModeBar = FALSE)
  })
  clickinput_a<-reactive({
    d<- event_data(event = ("plotly_click"), source = "A" )
    d$customdata
  })
  
  
  
  output$campus_name<-renderText({
    if (is.null(clickinput_a())) return()
    clickinput_a()
  })
  
  
  plot_data1 <- reactive({
    if(is.null(clickinput_a())){
      data1 <- data_table()
    }
    else {
      data1 <- data%>%filter(Location == clickinput_a())
    }
    return(data1)
  })
  
  
  output$plot1 <- renderPlotly({
    
    data1 <- plot_data1()
    plot_<- data1%>%group_by(course_id,Course_Sh)%>%
      summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))

    plot_1<-ggplot(data = plot_, aes(x = Course_Sh, y = total_seat, fill = Course_Sh,customdata = course_id))+
      geom_bar(stat = 'identity',width = 0.6
               # fill = 'steelblue'
      )+
      geom_text(aes(label = total_seat), vjust = -1,color = 'black', size =4)+theme_minimal()+
      labs(title = if(is.null(clickinput_a())) "" else paste(clickinput_a()),y= "Seat Count",x= "Courses")+
      theme(plot.title = element_text(hjust = "center"), legend.position = "none")+
      coord_flip()
    ggplotly(plot_1, tooltip = c("text", "size"), source = "B")%>%config(displayModeBar = FALSE)

  })
  
  clickinput_b<-reactive({
    d<- event_data(event = ("plotly_click"), source = "B" )
    d$customdata
  })
  
  
  
  output$x_value<-renderText({
    if (is.null(clickinput_b())) return()
    clickinput_b()
  })
  
  
  
  
  plot_data2 <-reactive({
    if(is.null(clickinput_a()) & is.null(clickinput_b())){
      data2 <- data_table()
    }
    if(!is.null(clickinput_a())){
      data2 <- data%>%filter(Location == clickinput_a())
      if(!is.null(clickinput_b())){
        data2 <- data%>%filter(course_id == clickinput_b())
      }
    }
    
    
    
    else if(is.null(clickinput_a())){
      if(!is.null(clickinput_b())){
        data2 <- data%>%filter(course_id == clickinput_b())
      }
    }
    
    # else if(is.null(clickinput_b())){
    #   data2 <- data_table()
    # }
    else {
      data2 <- data%>%filter(course_id == clickinput_b())
    }
    return(data2)
  })
  
  output$plot2 <- renderPlotly({
    
    data2 <- plot_data2()
    plot_<- data2%>%group_by(seat_type)%>%
      summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
    
    plot_2<-ggplot(data = plot_, aes(x = seat_type, y = total_seat, fill = seat_type,customdata = seat_type))+
      geom_bar(stat = 'identity',width = 0.6
               # fill = 'steelblue'
      )+
      geom_text(aes(label = total_seat), vjust = -1,color = 'black', size =4)+theme_minimal()+
      labs(title = if(is.null(clickinput_b())) "" else paste(clickinput_b()),y= "Seat Count",x= "Courses")+
      theme(plot.title = element_text(hjust = "center"), legend.position = "none")+
      coord_flip()
    ggplotly(plot_2, tooltip = c("text", "size"), source = "C")%>%config(displayModeBar = FALSE)
    
  })
  
  
  
  # output$dynamicplot1 <- renderPlotly({
  #   plot_data <-  table_data()
  #   plot_<-ggplot(data = plot_data, aes(x = seat_type, y = total_seat, fill = seat_type,customdata = seat_type))+
  #     geom_bar(stat = 'identity',position = position_dodge())+
  #     geom_text(aes(label = total_seat), vjust = -0.1,color = 'black', size =3)
  #   plot_<-plot_+coord_flip()
  #   bar1<-ggplotly(plot_, tooltip = c("text", "size"), source = "B")
  #   
  #   
  #   
  # })
  
  # clickinput_b<-reactive({
  #   d<- event_data(event = ("plotly_click"), source = "B" )
  #   d$customdata
  #   
  #   
  # })
  # 
  # clickinput_a<-reactive({
  #   d<- event_data(event = ("plotly_click"), source = "A" )
  #   d$customdata
  # })
  
  # table_data<- reactive({
  #   if (is.null(clickinput_a())) {
  #     plot_data<- data%>%group_by(seat_type)%>%
  #       summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #     result <- plot_data
  #     
  #   }
  #   else
  #   {
  #     plot_data<- data%>%group_by(course,seat_type)%>%
  #       summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #     plot_data<- plot_data%>%filter(course %in% clickinput_a())
  #     result <- plot_data
  #   }
  #   return(result)
  # })
  # 
  # 
  # 
  # 
  # 
  # output$DYNAMIC_TABLE <- renderTable({
  #   if (is.null(clickinput_a())) {
  #     plot_data<- data%>%group_by(seat_type)%>%
  #       summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #     result <- plot_data
  #     
  #   }
  #   else
  #   {
  #     plot_data<- data%>%group_by(course,seat_type)%>%
  #       summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #     plot_data<- plot_data%>%filter(course %in% clickinput_a())
  #     result <- plot_data
  #   }
  #   return(result)
  # })
 
  # output$x_value<-renderText({
  #   if (is.null(clickinput_a())) return()
  #   clickinput_a()
  # })
  
  # output$x1_value<-renderText({
  #   clickinput_b()
  #   
  # })

}

shinyApp(ui, server)