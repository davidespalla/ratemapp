library('ggplot2')

build_tuning_curve <- function(behaviour,spikes,cell_n=1,n_bins=10) {
  correlate_name <- colnames(behaviour)[2]
  breaks <- seq(min(behaviour[,2]),max(behaviour[,2]),length.out =n_bins+1)


  #occupancy histogram
  occupancy_h <- hist(behaviour[,2],breaks=breaks,plot=FALSE);

  
  # spike histogram
  spike_pos<- approx(behaviour[,1],behaviour[,2],spikes[,cell_n])$y
  spike_h <- hist(spike_pos,breaks=breaks,plot=FALSE, include.lowest = T);

  occupancy <- list('x'=occupancy_h$mids,'y'=occupancy_h$counts)
  tuning_curve <- data.frame(spike_h$mids,spike_h$counts/occupancy_h$counts)
  colnames(tuning_curve) <- c(correlate_name,'firing_rate')

  
  return(tuning_curve) 
  
  
}

plot_tuning_curve <- function(tuning_curve,span=0.1){
  
  p <- ggplot(tuning_curve,aes(x=position,y=firing_rate)) + geom_smooth(span=span)
  
  return(p)

}
