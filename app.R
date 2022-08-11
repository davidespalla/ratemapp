rm(list = ls())

library(shiny)
source('ui.R')
source('serve.R')
source("tools/functions.R")
options(shiny.maxRequestSize = 100*1024^2)


shinyApp(ui,server)


