build_tuning_curve <- function(behaviour_df,spikes_df,cell_n=1,n_bins=10) {
  #n_bins <- as.integer(1./bin_size)
  filt_bh <-subset(behaviour_df,behaviour_df$x>0 & behaviour_df$x<1) # change with given range
  
  #occupancy histogram
  occupancy_h <- hist(filt_bh$x,breaks=n_bins,plot=FALSE);

  
  # spike histogram
  spike_pos<- approx(filt_bh$t,filt_bh$x,spikes_df[cell_n,])$y
  spike_h <- hist(spike_pos,breaks=n_bins,plot=FALSE);

  occupancy <- list('x'=occupancy_h$mids,'y'=occupancy_h$counts)
  tuning_curve <- list('x'=spike_h$mids,'y'= spike_h$counts/occupancy_h$counts)
  
  return(tuning_curve) #(list('occupancy'=occupancy,'tuning_curve'=tuning_curve))
  
  # add smoothing
  
}

#spikes <- read.csv(file = 'data/spikes.csv', header = FALSE)
#behaviour <- read.csv(file = 'data/behaviour.csv', header = FALSE)
#colnames(behaviour) <- c('t','x')

#h <- build_tuning_curve(behaviour,spikes,10,bin_size = 0.05)
#plot(h$x,h$y)

#plot(h$tuning_curve$x,h$tuning_curve$y)
