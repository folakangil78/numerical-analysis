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

# ---------------------------------------------------------
# Part (b): Plot the complex eigenvalues of L
# ---------------------------------------------------------
eigvals_L = np.linalg.eigvals(L)

plt.figure(figsize=(6, 6))
# Plot eigenvalues without connecting lines
plt.plot(eigvals_L.real, eigvals_L.imag, 'bo', markersize=4, label='Eigenvalues of L')

# Plot the unit circle
theta = np.linspace(0, 2*np.pi, 200)
plt.plot(np.cos(theta), np.sin(theta), 'r--', label='Unit Circle')

plt.title("Part (b): Eigenvalues of Stochastic Matrix L")
plt.xlabel("Real Part")
plt.ylabel("Imaginary Part")
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)
plt.xlim(-1.2, 1.2)
plt.ylim(-1.2, 1.2)
plt.legend()
plt.grid(True)
plt.show()

# Verify max eigenvalue is 1 (allowing for floating point inaccuracy)
max_eig_val = np.max(np.abs(eigvals_L))
print(f"Maximum eigenvalue magnitude for L: {max_eig_val:.6f}")

# ---------------------------------------------------------
# Part (c): Study the influence of kappa on matrix S
# ---------------------------------------------------------
E = np.ones((n, n)) / n
kappa_values = [0.95, 0.85, 0.50]

plt.figure(figsize=(15, 5))

for i, kappa in enumerate(kappa_values):
    S = kappa * L + (1 - kappa) * E
    eigvals_S = np.linalg.eigvals(S)
    
    plt.subplot(1, 3, i+1)
    plt.plot(eigvals_S.real, eigvals_S.imag, 'go', markersize=4)
    plt.plot(np.cos(theta), np.sin(theta), 'r--')
    
    # Plot a circle representing the new spectral radius bound (kappa)
    plt.plot(kappa * np.cos(theta), kappa * np.sin(theta), 'k:', label=f'Radius = {kappa}')
    
    plt.title(f"Eigenvalues of S (kappa = {kappa})")
    plt.xlabel("Real Part")
    if i == 0:
        plt.ylabel("Imaginary Part")
    plt.xlim(-1.2, 1.2)
    plt.ylim(-1.2, 1.2)
    plt.axhline(0, color='black', linewidth=0.5)
    plt.axvline(0, color='black', linewidth=0.5)
    plt.legend()
    plt.grid(True)

plt.tight_layout()
plt.show()