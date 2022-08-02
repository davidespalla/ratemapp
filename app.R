library(shiny)
library(ggplot2)
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
      tableOutput('df_table'),
      plotOutput('position_plot',width = '600px'),
      plotOutput('tuning_curve',width = '600px')

    ) # end main panel
    
  ) # end sidebar layout
  
) # end ui

server <- function(input,output,session){

  # read input 
  df = reactive({
    req(input$file_bh)
    
    df <- read.csv(input$file_bh$datapath)
    
    return(head(df,1000))
  })
  selected_cell = reactive(input$selected_cell)
  # generate data
  x <- seq(0,100,0.5)
  s <- 10
  n_cells <- 10
  m <- seq(0,100,n_cells)

  tuning_matrix <- matrix(, nrow = n_cells, ncol = length(x))

  for(i in seq(1,n_cells)){
    tuning_matrix[i,] <- dnorm(x,m[i],s)
  }
  
  
  t <- reactive(df()[,1])
  pos <- reactive(df()[,2])
  
  
  # build outputs
  output$text <- renderPrint(selected_cell()) #selcted_cell(input$selected_cell)
  output$df_table <-renderTable(head(df()))
  output$position_plot <- renderPlot(plot(t(),pos()),res=96)
  output$tuning_curve <- renderPlot(plot(x,tuning_matrix[as.integer(selected_cell()),]),res=96)
}



shinyApp(ui,server)
