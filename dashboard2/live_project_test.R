getwd()
setwd("C:/RUPMANDAL/r project/shiny project/Shiny Practice/dashboard2")
library(plotly)
library(readxl)
library(dplyr)
library(ggplot2)
# install.packages("esprima")
library(esprima)
data <- read_excel("NIFT_Data.xlsx")
data
#############1
campus<-select(data, Location,College,seat_type,no_of_seat,alloted_no,Available)
campus<- campus%>%group_by(Location)%>%
  summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
campus


######################
campus<-select(data, Course_Sh,Location,College,seat_type,no_of_seat,alloted_no,Available)
campus<- campus%>%group_by(Location)%>%
  summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
campus

cplot <- ggplot(data = campus, aes(x= Location, y = Total_Seat, fill = Location, customdata = Location))+
  geom_bar(stat = 'identity', width = 0.5)+
  labs(y = "Seat Count", x = "Campus")

ggplotly(cplot, tooltip = c("text", "size"), source = "c")%>%config(displayModeBar = FALSE)
#####################


data_new<- as.data.table(campus)
data_new
typeof(data_new)
library(data.table)
data_new
df1 <- melt(data_new, id.vars = "Location", 
           measure.vars = c("Total_Seat", "Available","Alloted"),
           variable.name = "seat",
           value.name="count"
           )
df1<- df[order(Location,seat)]
df1

# plot1<-ggplot(df, aes(x = Location , y= count, fill = seat)) +
#   geom_bar(position="dodge", stat = "identity")

# ggplotly(plot1, tooltip = c("text", "size"), source = "A")

plot_1<-ggplot(data = df1, aes(x = Location, y = count, group = seat,
                                 customdata = Location))%>%config(displayModeBar = FALSE)+
  # geom_bar(stat = 'identity',position ="dodge"
           # position="dodge"
           # fill = 'steelblue'
  # )+
  # geom_text(aes(label = count))+
  geom_col(aes(fill = seat), position = "dodge") +
  # geom_shadowtext(data = subset(df1, count <= 10),aes(label = count, y = count + 5),
  #                 # position = position_dodge(0.9),
  #                 vjust = 0 ,size =3)+
  geom_text(#data = subset(df1, count > 10),
            aes(label = count, y = count + 8),
            position = position_dodge(1),
            # nudge_y = 0.3,
            vjust = -0.5 ,size =3)+
  theme_minimal()+
  labs(y= "Seat Count",x= "Location")
ggplotly(plot_1, tooltip = c("text", "size"), source = "A")


bar1<-plot_ly(type = 'bar',x = ~campus$Location,y = ~campus$Total_Seat, name ="<b>Total Seat</b>",text = "")%>%
  #plot_ly()%>%
  #plot_ly(type = 'bar',x = ~campus$Location,y = ~campus$Total_Seat, text = "Total Seat",name = 'Total Seat')%>%
  add_trace(y = ~campus$Available,name = "<b>Available Seat</b>",text = "")%>%
  add_trace(y = ~campus$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
  layout(yaxis = list(title = "<b>Seat Count</b>"),
         xaxis = list(title = "<b>Locations</b>"),
         barmode = 'group',hovermode = "x unified")%>%config(displayModeBar = F)
bar1  
label<- "asd"
var1 <- onRender(bar1,"
    function(el) { 
      el.on('plotly_hover', function(d) { 
        console.log('Hover: ', d); 
      });
      el.on('plotly_click', function(d) { 
        console.log('Click: ', d);
        var label = (d['points'][0]['label']);
        console.log(d['points'][0]['label']);
        alert(label);
        return
      });
      el.on('plotly_selected', function(d) { 
        console.log('Select: ', d); 
      });
    }
  ")
var1
parse() 
# esprima_parse(var1)
Plotly.relayout()
callback <- 'function test(x, y){ 
  var z = x*y ;
  return z;
}'
js_typeof(callback)

paste("Today is", date())
label
# ggplotly(bar1, tooltip = c("text", "size"), source = "A")
#############1
#############2
seat<- select(data, seat_type, no_of_seat,alloted_no,Available )
seat<- seat%>%group_by(seat_type)%>%
  summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))
seat

bar2<- plot_ly(type = 'bar',x = ~seat$Total_Seat,y = ~seat$seat_type, name ="<b>Total Seat</b>",text = "")%>%
  add_trace(x = ~seat$Available,name = "<b>Available Seat</b>",text = "")%>%
  add_trace(x = ~seat$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
  layout(yaxis = list(title = "<b>Seat Type</b>"),
         xaxis = list(title = "<b>Seat Count</b>"),
         barmode = 'group',hovermode = "y unified")%>%config(displayModeBar = F)

  
bar2
#############2
#############3
courses<- select(data, Course_Sh,no_of_seat,alloted_no,Available)
courses<- courses%>%group_by(Course_Sh)%>%
  summarise_at(vars(Total_Seat = no_of_seat, Alloted = alloted_no, Available),list(sum))

course<- courses[order(courses$Course_Sh,decreasing = TRUE),]
course

bar3<- plot_ly(type = 'bar',x = ~course$Total_Seat,y = ~course$Course_Sh, name ="<b>Total Seat</b>",text = "")%>%
  add_trace(x = ~course$Available,name = "<b>Available Seat</b>",text = "")%>%
  add_trace(x = ~course$Alloted,name = "<b>Alloted Seat</b>",text = "")%>%
  layout(yaxis = list(title = "<b>Seat Type</b>",
                      categoryorder = "array",
                      categoryarray = ~course$Course_Sh),
         xaxis = list(title = "<b>Seat Count</b>"),
         barmode = 'group',hovermode = "y unified")%>%config(displayModeBar = F)
bar3
# xaxis=list(categoryorder="trace")
#############3










library(htmlwidgets)
plot_ly(mtcars, x = ~wt, y = ~mpg) %>%
  onRender("
    function(el) { 
      el.on('plotly_hover', function(d) { 
        console.log('Hover: ', d); 
      });
      el.on('plotly_click', function(d) { 
        console.log('Click: ', d);
      });
      el.on('plotly_selected', function(d) { 
        console.log('Select: ', d); 
      });
    }
  ")





library(htmlwidgets)

p <- plot_ly(mtcars, x = ~wt, y = ~mpg) %>%
  add_markers(
    text = rownames(mtcars),
    customdata = paste0("http://google.com/#q=", rownames(mtcars))
  )

onRender(
  p, "
  function(el) {
    el.on('plotly_click', function(d) {
      var url = d.points[0].customdata;
      window.open(url);
    });
  }
")


window.open()

library(purrr)

sales_hover <- txhousing %>%
  group_by(city) %>%
  highlight_key(~city) %>%
  plot_ly(x = ~date, y = ~median, hoverinfo = "name") %>%
  add_lines(customdata = ~map2(city, sales, ~list(.x, .y))) %>%
  highlight("plotly_hover")

onRender(sales_hover, readLines("js/tx-annotate.js"))



txt <- "
x <- 1
an error
"
sf <- srcfile("txt")
try(parse(text = txt, srcfile = sf))
getParseData(var1)

install.packages('listviewer')
library(listviewer)
schema()

callback <- 'function test(x, y){ 
  var z = x*y ;
  return z;
}'




windows()
plot.new()
