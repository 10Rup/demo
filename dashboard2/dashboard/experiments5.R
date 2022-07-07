# 
# library(shiny) 
# library(timevis) 
# # install.packages("timevis")
# library(htmlwidgets) 
# library(data.table) 
# 
# rv <- reactiveValues() 
# rv$df <- data.frame( id = "", start = Sys.Date(), content = "", group = "") 
# rv$df2 <- data.frame(id = c(1,2), content = c("1","2")) 
# ## This should be added with the contextmenu dynamically 
# 
# ui <- fluidPage( timevisOutput("appts"), 
#                  div("Selected items:", textOutput("selected", inline = TRUE)), 
#                  div("Visible window:", textOutput("window", inline = TRUE)), 
#                  DT::DTOutput("table") ) 
# 
# server <- function(input, output) {
#   output$appts <- renderTimevis( timevis( rv$df, groups = rv$df2, 
#                                           options = list( editable = TRUE, 
#                                                           multiselect = TRUE, 
#                                                           align = "center", 
#                                                           minorLabels = FALSE, 
#                                                           majorLabels = FALSE, 
#                                                           
#                                                           onAdd = htmlwidgets::JS( 'function(item, callback) { 
# var end = new Date(item.start); 
# item.content = "Rename me!<br/>" + item.content; 
# item.end = end.setMonth( end.getMonth() + 1); callback(item); 
# }' ), 
#                                                           
#                                                           onRemove = htmlwidgets::JS( 'function (item, callback) { 
# var r = confirm("Press OK to remove or cancel"); 
# if (r == true) { 
# txt = "You pressed OK!"; callback(item); 
# } else { 
# txt = "You pressed Cancel!"; callback(null); } }' ), 
#                                                           onUpdate = htmlwidgets::JS( 'function(item, callback) {
# item.content = prompt("Edit items text:", item.content); 
# if (item.content != null) { 
# callback(item); // send back adjusted item 
# } else { 
# callback(null); // cancel updating the item } }' ) 
#                                           ) ) ) 
#   output$selected <- renderText(paste(input$appts_selected, collapse = " ")) 
#   output$window <- renderText(paste( input$appts_window[1], "to", input$appts_window[2] )) output[["table"]] <- DT::renderDT({ DT::datatable(input$appts_data, editable = TRUE) }) 
# } 
# shinyApp(ui, server) 









  app = eventsApp()
  
  js = '
 $(function() {
    $.contextMenu({
        selector: ".mydiv",
        callback: function(key, opt) {
          var target = opt.$trigger;
          var node = $.ui.fancytree.getNode(target);
          //alert("Clicked on " + key + " on element " + target.attr("id"));
        },
        items: {
            "edit": {name: "Edit", icon: "fa-edit"},
            "cut": {name: "Cut", icon: "cut"},
            "copy": {name: "Copy", icon: "copy"},
            "paste": {name: "Paste", icon: "paste"},
            "delete": {name: "Delete", icon: "delete"}
        }
    });
  });
  '
  
  items = list(
    edit = list(name="Edit", icon= "fa-edit"),
    cut = list(name= "Cut", icon= "cut")
  )
  #js = contextMenuJS(items=items, class="mydiv")
  app$ui = tagList(
    contextMenuHeader(),
    div(id="div1", class="mydiv", p("Context Menu 1")),
    div(id="div2", class="mydiv", p("Context Menu 2")),
    contextMenu(id="context", items=items, target.class="mydiv")
  )
  contextMenuHandler("context", function(..., app=getApp(), session=NULL) {
    args = list(...)
    restore.point("context")
    args
    cat("context menu clicked")
  })
  
  viewApp(app)
}



contextMenuHandler = function(id, fun,..., eventId="contextMenuClick") {
  eventHandler(eventId = eventId,id=id,fun = fun,...)
}

contextMenu = function(id,items,target.id=NULL,target.class=NULL, css.sel=make.css.sel(id=target.id,class=target.class), extra.return="", eventId="contextMenuClick") {
  restore.point("contextMenuJS")
  items.json = toJSON(items,auto_unbox = TRUE)
  
  js =  paste0('
$(function() {
  $.contextMenu({
    selector: "',css.sel,'",
    callback: function(key, opt) {
      var target = opt.$trigger;
      var node = $.ui.fancytree.getNode(target);
      //alert("Clicked on " + key + " on element " + target.attr("id"));
      Shiny.onInputChange("',eventId,'", {eventId: "',eventId,'", id: "',id,'", key: key, target_data: target.data(), target_id: target.attr("id"), target_class: target.attr("class"), ', extra.return, ' nonce: Math.random()});
    },
    items: \n',items.json,'
  });
});
')
  tags$script(js)
}




#' Header for jqueryContextMenu
#' @export
contextMenuHeader = function(...) {
  restore.point("contextmenuHeader")
  
  tagList(
    singleton(tags$head(tags$link(href=paste0("shinyEventsUI/jquery.contextMenu.min.css"), type="text/css", rel="stylesheet"))),
    singleton(tags$head(tags$script(type="text/javascript",src="shinyEventsUI/jquery.ui.position.min.js"))),
    singleton(tags$head(tags$script(type="text/javascript",src="shinyEventsUI/jquery.contextMenu.min.js")))
  )
}


#' Header for jqueryContextMenu
#' @export
uiContextMenuHeader = function(...) {
  restore.point("uiContextMenuHeader")
  tagList(
    singleton(tags$head(tags$script(src="shared/jqueryui/jquery-ui.min.js"))),
    singleton(tags$head(tags$link(href="shared/jqueryui/jquery-ui.min.css", rel="stylesheet"))),
    singleton(tags$head(tags$script(type="text/javascript",src="shinyEventsUI/jquery.ui-contextmenu.min.js")))
  )
}




make.css.sel = function(id=NULL, class=NULL, css.sel = NULL) {
  if (!is.null(css.sel)) return(css.sel)
  if (!is.null(id)) return(paste0("#",id))
  if (!is.null(class)) return(paste0(".",class))
  NULL
}
examples.uicontextmenu = function() {
  app = eventsApp()
  
  js = '
  $("#div1").contextmenu({
    menu: [
        {title: "Copy", cmd: "copy", uiIcon: "ui-icon-copy"},
        {title: "----"},
        {title: "More", children: [
            {title: "Sub 1", cmd: "sub1"},
            {title: "Sub 2", cmd: "sub1"}
            ]}
        ],
    select: function(event, ui) {
        alert("select " + ui.cmd + " on " + ui.target.text());
    }
  });
  $("#div2").contextmenu({
    menu: [
        {title: "Copy", cmd: "copy", uiIcon: "ui-icon-copy"},
        ],
    select: function(event, ui) {
        alert("select " + ui.cmd + " on " + ui.target.text());
    }
  });

  '
  app$ui = tagList(
    uiContextMenuHeader(),
    div(id="div1", p("Context Menu 1")),
    div(id="div2", p("Context Menu 2")),
    tags$script(HTML(js))
  )
  viewApp(app)
}