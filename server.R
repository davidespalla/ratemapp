
source("tools/functions.R")

server <- function(input,output,session){
  
  options(shiny.maxRequestSize=100*1024^2) 
  
  # read behaviour file
  bh_df = reactive({
    req(input$file_bh)
    
    df <- read.csv(input$file_bh$datapath,header=FALSE)
    colnames(df) <- c('t','x')
    
    
    return(df)
  })
  
  # read spike files
  spike_df = reactive({
    req(input$file_spikes)
    
    df <- read.csv(input$file_spikes$datapath,header=FALSE)
    
    return(df)
  })
  
  output$fileUploaded <- reactive({
    both_uploaded <- !is.null(spike_df()) & !is.null(spike_df())
    return(both_uploaded)
  })
  outputOptions(output, 'fileUploaded', suspendWhenHidden=FALSE)
  
  observe({
    req(input$file_spikes)
    req(input$file_bh)
    updateSelectInput(session, "cell_selector",
                    label = "Select cell",
                    choices = c(1:nrow(spike_df())),
                    selected = 1
  )
  })
  
  # read selected cell
  selected_cell = reactive(input$cell_selector)
  
  
  
  
  tuning_curve <- reactive({
    req(input$file_bh)
    req(input$file_spikes)
    bh_df_ <- bh_df()
    spikes_df_ <- spike_df()
    selected_cell_ <- as.integer(selected_cell())
    
    tuning_curve_ <- build_tuning_curve(bh_df_,spikes_df_,
                                        cell_n=selected_cell_,bin_size=0.1)
    return(tuning_curve_)
  })
  
  # build outputs
  output$text <- renderPrint(tuning_curve()) #selcted_cell(input$selected_cell)
  #output$position_plot <- renderPlot(plot(t(),pos()),res=96)
  #output$tuning_curve <- renderPlot(plot(x,tuning_matrix[as.integer(selected_cell()),]),res=96)
  output$tuning_curve <- renderPlot(plot(tuning_curve()$x,tuning_curve()$y),res=96)
  
}