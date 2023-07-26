source("tools/functions.R")
library(ggplot2)

spikes <- read.csv(file = 'data/HPC_spikes.csv', header = TRUE)
behaviour <- read.csv(file = 'data/correlate.csv', header = TRUE)
#colnames(behaviour) <- c('t','x')

spike_pos<- approx(behaviour[,1],as.double(behaviour[,2]),spikes[,1])$y
hist(spike_pos,breaks=11,plot=FALSE);

dh <- build_derivative_hist(behaviour)

derivative <- diff(behaviour[,2])/diff(behaviour[,1])
derivative <- filter(derivative,rep(1/5,5))

x <- behaviour[,1]
xs <- filter(x,rep(1/5,5))

tc <-build_tuning_curve(behaviour,spikes,cell_n = 1,n_bins=50)
nrow(tc)


plot_derivative_hist()
plot_tuning_curve(tc,span=0.15)


tinstall.packages('ggpubr')
ggpubr::ggline(tc, 'position', 'firing_rate')


ggplot(cars, aes(speed, dist)) +
  geom_point()