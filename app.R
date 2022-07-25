library(shiny)
library(ggplot2)

ui <- fluidPage(
  selectInput('selected_cell','cell number',choices = c(1:10)),
  plotOutput('tuning_curve',width = '400px'),
  verbatimTextOutput('text')
)

server <- function(input,output,session){
  selcted_cell <- reactiveVal(1)


  x <- seq(0,100,0.5)
  s <- 10
  n_cells <- 10
  m <- seq(0,100,n_cells)

  tuning_matrix <- matrix(, nrow = n_cells, ncol = length(x))

  for(i in seq(1,n_cells)){
    tuning_matrix[i,] <- dnorm(x,m[i],s)
  }
  output$text <- renderPrint('prova') #selcted_cell(input$selected_cell)
  output$tuning_curve <- renderPlot(plot(x,tuning_matrix[1,]),res=96)
}

# df <- data.frame(x=rnorm(100),y=rnorm(100))
# ui <- fluidPage(
#   plotOutput('plot',click='plot_click')
# )
# 
# server <- funtion(input,output,session){
#   dist <- reactiveVal(rep(1,nrow(df)))
#   observeEvent(input$plot_click,
#                {dist(nearPoints(df,input$plot_click, allRows = T,addDist = T)$dist_)}
#   )
#   output$plot <- renderPlot({
#     df$dist <- dist()
#     
#     ggplot(df, aes(x, y, size = dist)) + geom_point() + scale_size_area(limits=c(0,1000),max_size=10,guide=NULL)
#   }, res = 96)
# }


shinyApp(ui,server)
