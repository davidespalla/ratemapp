behaviourUI <- function(id){
  tagList(
    titlePanel('Correlate statistics'),
    column(6,
           titlePanel('Occupancy distribution'),
           plotOutput(NS(id,'occupancy_hist')),
           numericInput(NS(id,'occupancy_bin_selector'),'Number of bins',10,
                        min = 1,
                        max = 1000,
                        step = 1
                        
           )
    ),
    column(6,
           titlePanel('Derivative distriution'),
           plotOutput(NS(id,'derivative_hist')),
           numericInput(NS(id,'derivative_bin_selector'),'Number of bins',10,
                        min = 1,
                        max = 1000,
                        step = 1
                        
           )
    )
    
  )
}


tuning_curveUI <- function(id){
  tagList(
    titlePanel('Tuning Curve'),
    plotOutput(NS(id,'tuning_curve'),width = '800px'),
    column(3,
           selectInput(NS(id,'cell_selector'),'Select cell',choices = c(1:10))
    ),
    column(3,
           numericInput(NS(id,'bin_selector'),'Number of bins',10,
                        min = 1,
                        max = 1000,
                        step = 1
                        
           )
    ),
    column(3,
           sliderInput(NS(id,'smooth_selector'),'Smoothing',
                       min=0.1,
                       max=1,
                       value = 0.3,
                       step=0.01)
    ),
    column(3,
           downloadButton(NS(id,"downloadPlot"), "Download Plot")
    )
    
  )
}