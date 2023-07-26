source("tools/functions.R")

behaviourServer <- function(id,bh_data=NULL){
  
  moduleServer(id,function(input,output,session){
  
  # compute and plot occupancy
  occupancy_hist <- reactive(build_occupancy_hist(bh_data(),n_bins=input$occupancy_bin_selector))
  output$occupancy_hist <- renderPlot({
    plot_occupancy(occupancy_hist())
    },res=96)
  
  #compute and plot derivative
  derivative_hist <- reactive(build_derivative_hist(bh_data(),n_bins=input$derivative_bin_selector))
  output$derivative_hist <- renderPlot({
    plot_derivative(derivative_hist())
  },res=96)
  })
}

tuning_curveServer <- function(id,bh_df=NULL,spike_df=NULL){
  
  moduleServer(id,function(input,output,session){
    
    observe({
      updateSelectInput(session, "cell_selector",
                        label = "Select cell",
                        choices = c(1:ncol(spike_df())),
                        selected = 1
      )
    })
    
    # read selected cell
    selected_cell <- reactive(input$cell_selector)
    n_bins <- reactive(input$bin_selector)
    
    
    tuning_curve <- reactive({
      
      bh_df_ <- bh_df()
      spikes_df_ <- spike_df()
      selected_cell_ <- as.integer(selected_cell())
      
      tuning_curve_ <- build_tuning_curve(bh_df_,spikes_df_,
                                          cell_n=selected_cell_,n_bins=n_bins())
      return(tuning_curve_)
    })
    
    tuning_curve_plot = reactive(plot_tuning_curve(tuning_curve(),input$smooth_selector))
    output$tuning_curve <- renderPlot(tuning_curve_plot(),res=96)
    
    output$downloadPlot <- downloadHandler(
      filename = "tuning_curve.png",
      content = function(file) {
        png(file)
        print(tuning_curve_plot())
        dev.off()
      }
    )

  })
}