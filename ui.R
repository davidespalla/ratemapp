source("ui_modules.R")

ui <- fluidPage(
  
  #title panel of the page
  titlePanel("RatemApp"),
  
  # builds a sidebar layout
  sidebarLayout(
    #populate sidebar panel
    sidebarPanel(
      titlePanel("Load data"),
      
      fileInput("file_spikes", "Choose spikes file",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      fileInput("file_bh", "Choose behaviour file",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      
    ), # end side panel
    
    #populate main panel
    mainPanel(

      conditionalPanel("output.fileUploaded",
                       behaviourUI('behaviour_ui'),
                       tuning_curveUI('tuning_curve')
      )
      
    ) # end main panel
    
  ) # end sidebar layout
  
) # end ui