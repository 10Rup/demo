library(shiny)
library(shinyjs)

library(keypress)
library(KeyboardSimulator)

# has_keypress_support()

# X<-keybd.press("W")
# 
# 
# ui = fluidPage(
#   useShinyjs(),  # Set up shinyjs
#   p(id = "date", "Click me to see the date"),
#   p(id = "coords", "Click me to see the mouse coordinates"),
#   p(id = "disappear", "Move your mouse here to make the text below disappear"),
#   p(id = "text", cat("You pressed key", x, "\n"))
# )
# server = function(input, output) {
#   onclick("date", alert(date()))
#   onclick("coords", function(event) { alert(event) })
#   onevent("dblclick", "disappear", hide("text"))
#   onevent("rclick", "disappear", show("text"))
# }


# X<-keybd.press("s")
# 
# mouse.get_cursor()
# mouse.click("right")
x <- keypress()
cat("You pressed key", x, "\n")


invisible(readline(prompt="Press [enter] to continue"))
cat ("Press [enter] to continue")
line <- readline()


readkey <- function(){
  cat ("Press [enter] to continue")
  line <- readline()
  return(line)
}

readkey()

onKeybd <- function(key)
{
  keyPressed <<- key
}

onKeybd("s")



readkey <- function()
{
  cat("[press [enter] to continue]")
  number <- scan(n=1)
}
readkey()

# ui = bootstrapPage(
#   verbatimTextOutput("results"),
#   tags$script('
#     $(document).on("keypress", function (e) {
#        Shiny.onInputChange("mydata", e.which);
#     });
#   ') 
# )
# server = function(input, output, session) {
#   
#   output$results = renderPrint({
#     input$mydata
#   })
# }

shinyApp(ui, server)



switch(menu(c("List letters", "List LETTERS")) + 1,
       cat("Nothing done\n"), letters, LETTERS)

