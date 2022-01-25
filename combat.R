library(matrixStats)
library(neuroCombat)
# Simulate data
set.seed(8888)

p=10000 # Number of features
q=3 # Number of covariates
n=100
batch = rep(1:4, n/4) #Batch variable for the scanner id
batch <- as.factor(batch)

mod = matrix(runif(q*n), n, q) #Random design matrix
dat = matrix(runif(p*n), p, n) #Random data matrix

com_out <- neuroCombat(dat, batch, mod)
saveRDS(com_out$dat.combat, file = "R.RData")