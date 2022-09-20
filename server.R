
source("tools/functions.R")
source("server_modules.R")

server <- function(input,output,session){
  
  options(shiny.maxRequestSize=100*1024^2) 
  
  # read behaviour file
  bh_df = reactive({
    req(input$file_bh)
    df <- read.csv(input$file_bh$datapath,header=TRUE)
    
    return(df)
  })
  
  # read spike files
  spike_df = reactive({
    req(input$file_spikes)
    
    df <- read.csv(input$file_spikes$datapath,header=TRUE)
    
    return(df)
  })
  
  output$fileUploaded <- reactive({
    both_uploaded <- !is.null(spike_df()) & !is.null(bh_df())
    return(both_uploaded)
  })
  outputOptions(output, 'fileUploaded', suspendWhenHidden=FALSE)
  
  #behaviour panel
  behaviourServer('behaviour_ui',bh_df)
  
  #tuning curve panel
  tuning_curveServer('tuning_curve',bh_df,spike_df)
  
}