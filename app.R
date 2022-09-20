rm(list = ls())

library(shiny)
source('ui.R')
source('server.R')
options(shiny.maxRequestSize = 100*1024^2)


shinyApp(ui,server)


