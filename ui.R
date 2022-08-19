ui <- fluidPage(
  
  #title panel of the page
  titlePanel("Wellcome to ratemapp"),
  
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
      
      conditionalPanel("output.fileUploaded",
                       
        titlePanel("Control panel"),
        
        selectInput('cell_selector','Select cell',choices = c(1:10)),
        
        numericInput('bin_selector','Number of bins',10,
                      min = 1,
                      max = 1000,
                      step = 1
                    
        ),
        
        sliderInput('smooth_selector','Smoothing',
                    min=0.1,
                    max=1,
                    value = 0.3,
                    step=0.01)
      ) #end conditional panel
    ), # end side panel
    
    #populate main panel
    mainPanel(
      titlePanel('Tuning Curve'),
      plotOutput('tuning_curve',width = '800px')
      
    ) # end main panel
    
  ) # end sidebar layout
  
) # end ui