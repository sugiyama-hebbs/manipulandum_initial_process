# filter parameter (mostly SG filtering)
# While not well cited, this gives some reference value for the parameters
# Crenna 2015, Filtering signals for movement analysis in biomechanics
# https://www.imeko.org/publications/wc-2015/IMEKO-WC-2015-TC18-350.pdf
order <- 4 # degree of polynomial
framelen <- 201 # window size
reduce_hz <- T # reduce sample frequency of kinematic data. Filtering is done BEFORE reduction, so keep this True unless you want "raw" data.
reduce_hz_rate <- 5 # factor for reduction of frequency.  
sample_rate <-  1000 # sampling rate in Hz. NOTE: Current script has close to but not exactly 1000 Hz sampling (it fluctuates). Change this number after fixing the samling rate problem somehow
