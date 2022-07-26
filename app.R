library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  #title panel of the page
  titlePanel("Wellcome to ratemapp"),

  # builds a sidebar layout
  sidebarLayout(
    #populate sidebar panel
    sidebarPanel(
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
  # read input 
  selected_cell <- reactive(input$selected_cell)

  # generate data
  x <- seq(0,100,0.5)
  s <- 10
  n_cells <- 10
  m <- seq(0,100,n_cells)

  tuning_matrix <- matrix(, nrow = n_cells, ncol = length(x))

  for(i in seq(1,n_cells)){
    tuning_matrix[i,] <- dnorm(x,m[i],s)
  }
  
  # build outputs
  output$text <- renderPrint(selected_cell()) #selcted_cell(input$selected_cell)
  output$tuning_curve <- renderPlot(plot(x,tuning_matrix[as.integer(selected_cell()),]),res=96)
}



shinyApp(ui,server)
