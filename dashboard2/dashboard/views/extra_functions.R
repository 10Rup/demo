library(openxlsx)
# demo function
demo_func<- function(name){
  return(print(name))
}

# Updating .xlsx file
cvp.append_func <- function(filepath,dataframe){
  
  wb <- loadWorkbook(file = filepath)
  view_df<-readWorkbook(filepath)
  id <- max(view_df$id)+1
  df<- cbind(id,dataframe)
  writeData(wb,"Sheet1",df,colNames = FALSE,startRow = 1+nrow(view_df)+1)
  saveWorkbook(wb, file = VIEW_PATH, overwrite = TRUE)
  return(paste("Updated"))
}