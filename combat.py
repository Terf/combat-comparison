import pandas as pd
import numpy as np
from rpy2.robjects import r, numpy2ri, pandas2ri
import neuroCombat as nc


numpy2ri.activate()
pandas2ri.activate()
r(
    """
library(matrixStats)
# Simulate data
set.seed(8888)

p=10000 # Number of features
q=3 # Number of covariates
n=100
batch = rep(1:4, n/4) #Batch variable for the scanner id
batch <- as.factor(batch)

mod = matrix(runif(q*n), n, q) #Random design matrix
dat = matrix(runif(p*n), p, n) #Random data matrix
"""
)

dat = pd.DataFrame(r["dat"])
mod = pd.DataFrame(r["mod"])
batch_col = "batch"
covars = pd.DataFrame({batch_col: r["batch"]})

com_out = nc.neuroCombat(dat, covars, batch_col)
r.saveRDS(com_out["data"], file="python.RData")
