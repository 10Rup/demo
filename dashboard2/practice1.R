library(ggplot2)
library(plotly)
library(shiny)
library(readxl)
library(dplyr)
library(shinydashboard)
setwd("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2")
data <- read_excel("NIFT_Data.xlsx")
data
#############1
# campus<-select(data, Course_Sh,Location,College,seat_type,no_of_seat,alloted_no,Available)
# campus<- campus%>%group_by(Location)%>%
#   summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
# campus
# bar1<-plot_ly(type = 'bar',x = ~campus$Location,y = ~campus$Total_Seat, name ="<b>Total Seat</b>",text = "", customdata =campus$Location)%>%
#   #plot_ly()%>%
#   #plot_ly(type = 'bar',x = ~campus$Location,y = ~campus$Total_Seat, text = "Total Seat",name = 'Total Seat')%>%
#   add_trace(y = ~campus$Available,name = "<b>Available Seat</b>",text = "")%>%
#   add_trace(y = ~campus$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
#   layout(yaxis = list(title = "<b>Seat Count</b>"),
#          xaxis = list(title = "<b>Locations</b>"),
#          barmode = 'group',hovermode = "x unified")%>%config(displayModeBar = F)
# bar1
# ggplotly(bar1, tooltip = c("text", "size"), source = "A")
#############1
#############2
# seat<- select(data, seat_type, no_of_seat,alloted_no,Available )
# seat<- seat%>%group_by(seat_type)%>%
#   summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
# seat
# 
# bar2<- plot_ly(type = 'bar',x = ~seat$Total_Seat,y = ~seat$seat_type, name ="<b>Total Seat</b>",text = "", customdata =seat$seat_type)%>%
#   add_trace(x = ~seat$Available,name = "<b>Available Seat</b>",text = "")%>%
#   add_trace(x = ~seat$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
#   layout(yaxis = list(title = "<b>Seat Type</b>"),
#          xaxis = list(title = "<b>Seat Count</b>"),
#          barmode = 'group'
#          # ,hovermode = "y unified"
#          )%>%config(displayModeBar = F)
# 
# 
# bar2
#############2
#############3
courses<- select(data, Course_Sh,no_of_seat,alloted_no,Available)
courses<- courses%>%group_by(Course_Sh)%>%
  summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))

course<- courses[order(courses$Course_Sh,decreasing = TRUE),]
course

bar3<- plot_ly(type = 'bar',x = ~course$Total_Seat,y = ~course$Course_Sh, name ="<b>Total Seat</b>",text = "", customdata =course$Course_Sh )%>%
  add_trace(x = ~course$Available,name = "<b>Available Seat</b>",text = "")%>%
  add_trace(x = ~course$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
  layout(yaxis = list(title = "<b>Seat Type</b>",
                      # categoryorder = "array",
                      categoryarray = ~course$Course_Sh),
         xaxis = list(title = "<b>Seat Count</b>"),
         barmode = 'group'
         # ,hovermode = "y unified"
         )%>%config(displayModeBar = F)
bar3
# xaxis=list(categoryorder="trace")
#############3
ui <-dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
   fluidRow(
    box( width = "100%",
      
      title = "Bar Plot 1",
      plotlyOutput("plot1", width = "100%",
                  ),
      textOutput("x_value")
    )),
    fluidRow(
      box(
      title = "Bar Plot 2",
      plotlyOutput("plot2", width = "100%",
      )),
      
      box(
      title = "Bar Plot 3",
      plotlyOutput("plot3", width = "100%",
      ))
    ),
   box(
     textOutput("x1_value"),
     textOutput("x2_value"),
     textOutput("x3_value")
   )
   
   
   )
)


server <- function(input, output) {
  output$plot1 <- renderPlotly({
    campus<-select(data, Course_Sh,Location,College,seat_type,no_of_seat,alloted_no,Available)
    campus<- campus%>%group_by(Location)%>%
      summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
    campus
    bar1<-plot_ly(type = 'bar',x = ~campus$Location,y = ~campus$Total_Seat, name ="<b>Total Seat</b>",text = "", customdata =~campus$Location)%>%
      add_trace(y = ~campus$Available,name = "<b>Available Seat</b>",text = "")%>%
      add_trace(y = ~campus$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
      layout(yaxis = list(title = "<b>Seat Count</b>"),
             xaxis = list(title = "<b>Locations</b>"),
             barmode = 'group',hovermode = "x unified")%>%config(displayModeBar = F)
    ggplotly(bar1, tooltip = c("text", "size"), source = "A")
  })
  
  clickinput<-reactive({
    d<- event_data(event = "plotly_click" , source = "A" )
    a<-unique(d$customdata)
    a
  })
  output$x1_value<-renderText({
    if (is.null(clickinput())) return()
    clickinput()
  })
  output$plot2 <- renderPlotly({
    seat<- select(data, seat_type, no_of_seat,alloted_no,Available )
    seat<- seat%>%group_by(seat_type)%>%
      summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
    seat
    
    bar2<- plot_ly(type = 'bar',x = ~seat$Total_Seat,y = ~seat$seat_type, name ="<b>Total Seat</b>",text = "", customdata =seat$seat_type)%>%
      add_trace(x = ~seat$Available,name = "<b>Available Seat</b>",text = "")%>%
      add_trace(x = ~seat$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
      layout(yaxis = list(title = "<b>Seat Type</b>"),
             xaxis = list(title = "<b>Seat Count</b>"),
             barmode = 'group'
             # ,hovermode = "y unified"
      )%>%config(displayModeBar = F)
    ggplotly(bar2, tooltip = c("text", "size"), source = "B")
  })
  output$plot3 <- renderPlotly({
    # plot_1
    ggplotly(bar3, tooltip = c("text", "size"), source = "C")
  })
  # 
  
}

shinyApp(ui, server)