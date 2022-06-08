library(shiny)
library(dplyr)
library(plotly)

ui <- fluidPage(
  plotlyOutput("bars"),
  verbatimTextOutput("click")
)

classes <- sort(unique(mpg$class))

server <- function(input, output, session) {
  
  output$bars <- renderPlotly({
    ggplot(mpg, aes(class, fill = drv, customdata = drv)) +
      geom_bar()
  })
  
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) return("Click a bar")
    d
    # mpg %>%
    #   filter(drv %in% d$customdata) %>%
    #   filter(class %in% classes[d$x])
  })
  
}

shinyApp(ui, server)



library(maps)
library(ggplot2)
library(plotly)
data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = pop), colour = "red", alpha = 1/2)
ggplotly(viz, tooltip = c("text", "size"))








getwd()
setwd("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2")
library(ggplot2)
library(shiny)
library(readxl)
library(dplyr)
library(shinydashboard)
data <- read_excel("data.xlsx")
data
plot_<- data%>%group_by(course)%>%
  summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
plot_

plot_1<-ggplot(sourse = "a",data = plot_, aes(x = course, y = total_seat, fill = course,
                                              customdata = course))+
  geom_bar(stat = 'identity',
           # fill = 'steelblue'
  )+
  geom_text(aes(label = total_seat), vjust = -1,color = 'black', size =4)+
  theme_minimal()+
  labs(y= "Seat Count",x= "Courses")

ggplotly(plot_1, tooltip = c("text", "size"), source = "A")






library(ggplot2)
plot_data2<- data%>%group_by(seat_type)%>%
  summarise_at(vars(total_seat = no_of_seat, consumed_seat = alloted_no),list(sum))
plot_data2

plot_1<-ggplot(data = plot_data2, aes(x = seat_type, y = total_seat, fill = seat_type,
                                      customdata = seat_type))+
  geom_bar(stat = 'identity',position = position_dodge())
plot_1<-plot_1+coord_flip()
plot_1
bar2<-ggplotly(plot_1, tooltip = c("text", "size"))
bar1



library(tcltk)
tk_messageBox(type = c("ok", "okcancel", "yesno", "yesnocancel",
                       "retrycancel", "abortretryignore"),
              message, caption = "", default = "", ...)




