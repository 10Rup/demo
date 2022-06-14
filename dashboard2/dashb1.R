library(ggplot2)
library(shiny)
library(readxl)
library(dplyr)
library(plotly)
library(shinydashboard)
library(tidyverse)
library(gridExtra)
# install.packages('tcltk')
library(gganimate)
setwd("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2")
# s<- "C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2"
# strsplit(s,"/")
# 
# list.files()
# files <- list.files(pattern = "xlsx")
# files
# 
# wd <- "C:/Users/lspl-desk-nas/JaspersoftWorkspaceV2/MyReports/WORK/2022/may"
# getwd()
# setwd("C:/Users/lspl-desk-nas/JaspersoftWorkspaceV2/MyReports/WORK/2022/may")
# dir_list <- list.dirs(wd,full.names = FALSE, 
#                       recursive = FALSE)
# print (dir_list)


data <- read_excel("data.xlsx")
data
plot_<- data%>%group_by(course)%>%
  summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
plot_
total_seat <- plot_%>%summarise_at(vars(total_seat), list(sum))
total_seat

plot_1<-ggplot(data = plot_, aes(x = course, y = total_seat, fill = course,
                                              customdata = course))+
  geom_bar(stat = 'identity',
           # fill = 'steelblue'
  )+
  geom_text(aes(label = total_seat), vjust = -1,color = 'black', size =4)+
  theme_minimal()+
  labs(y= "Seat Count",x= "Courses")



# plot_1<-ggplot(data = df1, aes(x = Location, y = count, fill = seat,
#                                customdata = Location))%>%config(displayModeBar = FALSE)+
#   geom_bar(stat = 'identity',position ="dodge"
#            # position="dodge"
#            # fill = 'steelblue'
#   )+
#   geom_text(aes(label = count))+
#   # geom_text(aes(label = count),hjust= 1, color = 'black', size =3)+
#   theme_minimal()+
#   labs(y= "Seat Count",x= "Location")
 # ggplotly(plot_1, tooltip = c("text", "size"), source = "A")







ui <-dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(# width = "50%",
        
        title = "Bar Plot",
        plotlyOutput("plot1", width = "100%",#height = 300, width = 300,
        ),
        textOutput("x_value") 
      ),
      box(
        title = "Dynamic Bar Plot",
        plotlyOutput("dynamicplot1", width = "100%",#height = 300, width = 300,
        ),
        textOutput("x1_value")
        
        
      )
      
      
    ),
    fluidRow(
      box(tableOutput("DYNAMIC_TABLE")
      )
    ),
    
    column(width = 4,
           box(
             status = "warning", width = NULL,
             "Box content"
           ),
           box(
             title = "Title 3", width = NULL, solidHeader = TRUE, status = "warning",
             "Box content"
           ),
           box(
             title = "Title 5", width = NULL, background = "light-blue",
             "A box with a solid light-blue background"
           )
    )
  )
)



#  
#   fluidPage(
#   fluidRow(
#     plotOutput("plot1", height = 300, width = 300,
#                click = "plot1_click",
#     )
#   ),
#   verbatimTextOutput("x_value")
#   # verbatimTextOutput("selected_rows")
# )

server <- function(input, output) {
  output$plot1 <- renderPlotly({
    # plot_1
    ggplotly(plot_1, tooltip = c("text", "size"), source = "A")%>%config(displayModeBar = FALSE)
  })
  
  output$dynamicplot1 <- renderPlotly({
    # plot_1
    plot_data <-  table_data()
    plot_<-ggplot(data = plot_data, aes(x = seat_type, y = total_seat, fill = seat_type,customdata = seat_type))+
      geom_bar(stat = 'identity',position = position_dodge())+
      geom_text(aes(label = total_seat), vjust = -0.1,color = 'black', size =3)
      # transition_states(states = course, transition_length = 2, state_length = 1)+ 
      # enter_fade() + exit_shrink() +ease_aes('sine-in-out')
    plot_<-plot_+coord_flip()
    # a_gif <- animate(plot_, width = 940, height = 480)
    bar1<-ggplotly(plot_, tooltip = c("text", "size"), source = "B")
    
    
      
  })
  
  clickinput_b<-reactive({
    d<- event_data(event = ("plotly_click"), source = "B" )
    d$customdata
    
    
  })
  
  clickinput_a<-reactive({
    d<- event_data(event = ("plotly_click"), source = "A" )
    d$customdata
  })
  
  table_data<- reactive({
    if (is.null(clickinput_a())) {
      plot_data<- data%>%group_by(seat_type)%>%
        summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
      result <- plot_data
      
    }
    else
    {
      plot_data<- data%>%group_by(course,seat_type)%>%
        summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
      plot_data<- plot_data%>%filter(course %in% clickinput_a())
      result <- plot_data
    }
    return(result)
  })
  
  
  
  
  
  output$DYNAMIC_TABLE <- renderTable({
    if (is.null(clickinput_a())) {
      plot_data<- data%>%group_by(seat_type)%>%
            summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
      result <- plot_data
      
    }
    else
    {
      plot_data<- data%>%group_by(course,seat_type)%>%
        summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
      plot_data<- plot_data%>%filter(course %in% clickinput_a())
      result <- plot_data
    }
    return(result)
  })
  
  
  # clickinput1<-reactive({
  #   d<- event_data(event = ("plotly_click"), source = "B" )
  #   d$customdata
  # })
  output$x_value<-renderText({
  # d<- event_data(event = ("plotly_click"), source = "A" )
  # if (is.null(d$customdata)) return("NA")
  # d$customdata
  if (is.null(clickinput_a())) return()
  clickinput_a()
  })
  
  output$x1_value<-renderText({
    # if (is.null(clickinput_a())) return()
    # clickinput_a()
    clickinput_b()
    
  })
  # output$x1_value<-renderPrint({
  #   # d<- event_data(event = ("plotly_click"), source = "A" )
  #   # if (is.null(d$customdata)) return("NA")
  #   # d$customdata
  #   if (is.null(clickinput1)) return()
  #   clickinput1()
  # })
  # clickinput<- reactive({
  #   paste0(output$x_value)
  # })
  # output$dynamicplot1<- renderPlotly({
  #   # d<- event_data(event = ("plotly_click"),source = )
  #   #   d$customdata
  #   data
  #   # clickinput <-"CR16"
  #   plot_data<- data%>%group_by(course,seat_type)%>%
  #     summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #   
  #   plot_data<- plot_data%>%filter(course %in% clickinput())
  #   plot_<-ggplot(data = plot_data, aes(x = seat_type, y = total_seat, fill = seat_type,
  #                                       customdata = seat_type))+
  #     geom_bar(stat = 'identity',position = position_dodge())+
  #     geom_text(aes(label = total_seat), vjust = -0.1,color = 'black', size =3)
  #   plot_<-plot_+coord_flip()
  #   
  #   
  #   plot_data2<- data%>%group_by(seat_type)%>%
  #     summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
  #   plot_data2
  #   plot_1<-ggplot(data = plot_data2, aes(x = seat_type, y = total_seat, fill = seat_type,
  #                                         customdata = seat_type))+
  #     geom_bar(stat = 'identity',position = position_dodge())+
  #     geom_text(aes(label = total_seat), hjust = 1,color = 'black', size =3)
  #   plot_1<-plot_1+coord_flip()
  #   bar1<-ggplotly(plot_, tooltip = c("text", "size"), source = "B")
  #   bar2<-ggplotly(plot_1, tooltip = c("text", "size"), source = "c")
  #   
  #   if (is.null(clickinput())) return(bar2)
  #   bar1
  # })
  
  # Print the name of the x value
  # output$x_value <- renderPrint({
  # if (is.null(input$plot1_click$x)) return("NA")
  # round(input$plot1_click$x)
  # list <- c(plot_$course)
  # list[round(input$plot1_click$x)]
  # if (is.null(input$plot1_click$x)) return()
  # lvls <- c(plot_$course)
  # lvls <- levels(ToothGrowth$supp)
  # lvls[round(input$plot1_click$x)]
  # })
  
  # Print the rows of the data frame which match the x value
  # output$selected_rows <- renderPrint({
  #   if (is.null(input$plot1_click$x)) return()
  #  
  #   keeprows <- round(input$plot1_click$x) == as.numeric(ToothGrowth$supp)
  #   ToothGrowth[keeprows, ]
  # })
}

shinyApp(ui, server)