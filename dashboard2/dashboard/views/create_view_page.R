library(openxlsx)


# xlsx update function
cvp.append_func <- function(filepath,dataframe){
  
  wb <- loadWorkbook(file = filepath)
  view_df<-readWorkbook(filepath)
  id <- max(view_df$id)+1
  df<- cbind(id,dataframe)
  writeData(wb,"Sheet1",df,colNames = FALSE,startRow = 1+nrow(view_df)+1)
  saveWorkbook(wb, file = VIEW_PATH, overwrite = TRUE)
  return(paste("Updated"))
}

# demo function
demo_func<- function(name){
  return(print(name))
}

# ui sidebar menu
cvp.side_menu<- sidebarMenu(
  id =  "side_menu1",
  menuItem("Create Views", tabName = "createview"),
  menuItem("Visualization", tabName = "visualize"),
  menuItem("View", tabName = "view")
)

cvp.item1<-tabItem(
  tabName = "createview","This is createview page",br(),
  fluidRow(
    box(
      title = "Title 3", width = "12", 
      solidHeader = TRUE, 
      status = "primary",
      collapsible = TRUE,
      collapsed = TRUE,
      box(
        textInput("viewname", "VIEW NAME"),
        textOutput("view_name")
      ),
      box(
        fileInput("file1","Choose cvs file", accept=".xlsx"),
        
      ),
      box(
        selectInput("Colm", label = "Group by", choices =NULL ),
      ),
      box(
        selectInput("col2", label = "Summarize", multiple = TRUE, choices =NULL ),
      ),actionButton("create", "Create View",class = "btn-primary btn-lg")
    )
  )
)


cvp.item2<-tabItem(
  tabName = "visualize","This is visualize",br(),
)

cvp.item3<-tabItem(
  tabName = "view","This is view",br(),
)



# ui body
cvp.body <-dashboardBody(
  fluidRow(
    box(
      title = "Title 3", width = "12", 
      solidHeader = TRUE, 
      status = "primary",
      collapsible = TRUE,
      collapsed = TRUE,
      box(
        textInput("view_name", "VIEW NAME"),
      ),
      box(
        fileInput("file1","Choose cvs file", accept=".xlsx"),
        
      ),
      box(
        selectInput("Colm", label = "Group by", choices =NULL ),
      ),
      box(
        selectInput("col2", label = "Summarize", multiple = TRUE, choices =NULL ),
      ),actionButton("create", "Create View",class = "btn-primary btn-lg")
    )
  )
)

# ui body with items
# cvp.body2<-dashboardBody(
#   
# )




# demo_func("rup")
