source("C:/RUPMANDAL/r project/demo/dashboard2/dashboard/views/server_dashboard.R")

# ========================Create View Page=================================

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
        # textInput("viewname", "VIEW NAME"),
        selectizeInput("viewname", label = "VIEW NAME", choices =NULL,
                       options = list(
                         # plugins = list("remove_button"),
                         create = TRUE,
                         persist = TRUE # keep created choices in dropdown
                       )),
        textOutput("name")
      ),
      box(
        fileInput("reportfile","Choose cvs file", accept=".xlsx"),
        
      ),
      box(
        selectInput("groupby", label = "Group by", choices =NULL ),
      ),
      box(
        selectInput("summarize", label = "Summarize", multiple = TRUE, choices =NULL ),
        useShinyjs(),
        useShinyalert(),
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



# ==============xxxxxxxxxxxxxxxxxxx============================