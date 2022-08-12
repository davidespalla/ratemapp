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
      conditionalPanel("output.fileUploaded",
      selectInput('cell_selector','Select cell',choices = c(1:10)),
      numericInput('bin_selector','Number of bins',10,
                    min = 1,
                    max = 1000,
                    step = 1
                  
      )
      ) #end conditional panel
    ), # end side panel
    
    #populate main panel
    mainPanel(
      verbatimTextOutput('text'),
      plotOutput('tuning_curve',width = '600px')
      
    ) # end main panel
    
  ) # end sidebar layout
  
) # end ui