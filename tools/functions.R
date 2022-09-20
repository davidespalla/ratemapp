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

build_occupancy_hist <- function(behaviour,n_bins=10) {
  correlate_name <- colnames(behaviour)[2]
  breaks <- seq(min(behaviour[,2]),max(behaviour[,2]),length.out =n_bins+1)
  
  occupancy_h <- hist(behaviour[,2],breaks=breaks,plot=FALSE);
  
  occupancy <- data.frame(occupancy_h$mids,occupancy_h$counts)
  colnames(occupancy) <- c(correlate_name,'counts')
  
  
  return(occupancy) 
  
}

build_derivative_hist <- function(behaviour,n_bins=10){
  correlate_name <- colnames(behaviour)[2]
  derivative <- diff(behaviour[,2])/diff(behaviour[,1])
  derivative <- filter(derivative,rep(1/5,5))
  breaks <- seq(min(derivative,na.rm=TRUE),max(derivative,na.rm=TRUE),length.out =n_bins+1)
  
  derivative_hist <- hist(derivative,breaks=breaks,plot=FALSE);
  
  derivative_hist <- data.frame(derivative_hist$mids,derivative_hist$counts)
  colnames(derivative_hist) <- c(correlate_name,'counts')
  return(derivative_hist)
}

## Plot functions

plot_tuning_curve <- function(tuning_curve,span=0.1){

  p <- ggplot(tuning_curve,aes_string(x=colnames(tuning_curve)[1],y=colnames(tuning_curve)[2])) +
    geom_smooth(span=span) 
  
  return(p)

}

plot_occupancy <- function(occupancy){
  p<-ggplot(data=occupancy, aes_string(x=colnames(occupancy)[1],y=colnames(occupancy)[2])) +
  geom_bar(stat="identity")
  return(p)
  
}
  
plot_derivative <- function(derivative){
    p<-ggplot(data=derivative, aes_string(x=colnames(derivative)[1],y=colnames(derivative)[2])) +
      geom_bar(stat="identity")
    return(p)
    
}

  
  
