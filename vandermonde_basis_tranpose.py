import numpy as np

# Define the degrees to test
n_values = [5, 10, 20, 30]

print("Vandermonde Matrix Condition Numbers:")
print("-" * 40)

for n in n_values:
    # 1. Generate uniformly spaced nodes: x_i = -1 + (2i)/n for i = 0, ..., n
    i = np.arange(n + 1)
    x = -1 + (2 * i) / n
    
    # 2. Assemble the Vandermonde matrix V
    # increasing=True sets the columns to x^0, x^1, ..., x^n matching the problem
    V = np.vander(x, increasing=True)
    
    # 3. Compute the 2-based condition number
    cond_2 = np.linalg.cond(V, 2)
    
    print(f"n = {n:<2} | k_2(V) = {cond_2:.4e}")