import numpy as np
import matplotlib.pyplot as plt

# ---------------------------------------------------------
# Setup: Constructing the stochastic matrix L (from prompt)
# ---------------------------------------------------------
np.random.seed(42) # For reproducible results
n = 100 # Pick a size n >= 100 for the "toy internet"

I = np.eye(n)
perm = np.random.permutation(n)
A = 0.5 * I[perm, :] + (np.maximum(2, np.random.randn(n, n)) - 2)
A = A - np.diag(np.diag(A))
colsums = A.sum(axis=0)
colsumssafe = np.maximum(1e-10, colsums)
L = A @ np.diag(1.0 / colsumssafe)

# ---------------------------------------------------------
# Part (a): Plot the sparsity structure of L
# ---------------------------------------------------------
plt.figure(figsize=(6, 6))
plt.spy(L, markersize=2, color='blue')
plt.title("Part (a): Sparsity Structure of Matrix L")
plt.xlabel("Column Index (Websites)")
plt.ylabel("Row Index (Websites)")
plt.show()