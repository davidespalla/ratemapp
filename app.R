rm(list = ls())

library(shiny)
library(ggplot2)
source("tools/functions.R")
options(shiny.maxRequestSize = 100*1024^2)

ui <- fluidPage(
  
  #title panel of the page
  titlePanel("Wellcome to ratemapp"),

  # builds a sidebar layout
  sidebarLayout(
    #populate sidebar panel
    sidebarPanel(
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
      
      selectInput('selected_cell','Select a cell',choices = c(1:10))
    ), # end side panel
    
    #populate main panel
    mainPanel(
      verbatimTextOutput('text'),
      plotOutput('tuning_curve',width = '600px')

    ) # end main panel
    
  ) # end sidebar layout
  
) # end ui

server <- function(input,output,session){

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
  
  # read selected cell
  selected_cell = reactive(input$selected_cell)
  
  
  
  
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



shinyApp(ui,server)

#spikes <- read.csv(file = 'data/spikes.csv', header = FALSE)
#behaviour <- read.csv(file = 'data/behaviour.csv', header = FALSE)
#colnames(behaviour) <- c('t','x')
