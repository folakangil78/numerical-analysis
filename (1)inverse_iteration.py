import numpy as np

# Set print options for cleaner output
np.set_printoptions(precision=4, suppress=True)

# =====================================================================
# Part (a): Implement the Power Method
# =====================================================================
def power_method(A, x0, num_iter=5):
    """
    Implements the power method to find the dominant eigenvector.
    """
    x = np.array(x0, dtype=float)
    x = x / np.linalg.norm(x) # Normalize initial vector
    
    iterates = []
    for _ in range(num_iter):
        y = A @ x
        x = y / np.linalg.norm(y)
        iterates.append(x)
        
    return iterates

# =====================================================================
# Part (b): Apply Power Method to specific matrix and explain
# =====================================================================
print("--- PART (b) ---")
A = np.array([
    [-2,  1,  4],
    [ 1,  1,  1],
    [ 4,  1, -2]
])

x0_1 = np.array([1, 2, -1])
x0_2 = np.array([1, 2, 1])

print(f"Iterates for initial vector x0 = {x0_1}:")
iterates_1 = power_method(A, x0_1, num_iter=5)
for i, x in enumerate(iterates_1, 1):
    print(f"  Iteration {i}: {x}")

print(f"\nIterates for initial vector x0 = {x0_2}:")
iterates_2 = power_method(A, x0_2, num_iter=5)
for i, x in enumerate(iterates_2, 1):
    print(f"  Iteration {i}: {x}")

# Built-in eigenvalue solver
eigenvalues, eigenvectors = np.linalg.eig(A)
print("\nBuilt-in solver results:")
for i in range(len(eigenvalues)):
    print(f"  Eigenvalue: {eigenvalues[i]:.4f}, Eigenvector: {eigenvectors[:, i]}")

print("\nEXPLANATION FOR PART (b):")
print("""Where do the sequences converge to?
  - The first sequence (starting with [1, 2, -1]^T) converges to the eigenvector 
    associated with the dominant eigenvalue lambda = -6. (The normalized eigenvector 
    is approximately [-0.7071, 0, 0.7071]^T).
  - The second sequence (starting with [1, 2, 1]^T) converges to the eigenvector 
    associated with lambda = 3. (The normalized eigenvector is [0.5774, 0.5774, 0.5774]^T).

Why do the limits not seem to be the same?
  - The power method relies on the initial vector having a non-zero component in the 
    direction of the dominant eigenvector. 
  - The dominant eigenvector for A is v_1 = [1, 0, -1]^T (for lambda = -6). 
  - The dot product of the second initial vector x0 = [1, 2, 1]^T with v_1 is 
    (1)(1) + (2)(0) + (1)(-1) = 0. Because it is strictly orthogonal to the dominant 
    eigenspace, the power method suppresses the dominant component (which is zero) 
    and instead converges to the eigenvector of the *next* largest eigenvalue, which 
    is lambda = 3.""")

# =====================================================================
# Part (c): Implement the Inverse Power Method
# =====================================================================
def inverse_power_method(A, x0, s, num_iter=5):
    """
    Implements the inverse power method with shift 's' to find 
    the eigenvector corresponding to the eigenvalue closest to 's'.
    """
    x = np.array(x0, dtype=float)
    x = x / np.linalg.norm(x)
    I = np.eye(A.shape[0])
    
    iterates = []
    for _ in range(num_iter):
        # Solve (A - sI)y = x
        y = np.linalg.solve(A - s * I, x)
        x = y / np.linalg.norm(y)
        iterates.append(x)
        
    return iterates

# =====================================================================
# Part (d): Use Inverse Power Method to find ALL eigenvectors
# =====================================================================
print("\n\n--- PART (d) ---")
# From our built-in solver, we know the eigenvalues are approx -6, 3, and 0.
# We pick shifts 's' close to these expected eigenvalues to find all eigenvectors.
shifts = [-5.5, 2.5, 0.5]
x0_d = np.array([1, 1, -1]) # A generic initial vector not orthogonal to any eigenvector

for s in shifts:
    print(f"\nInverse Power Method with shift s = {s}:")
    iterates_inv = inverse_power_method(A, x0_d, s, num_iter=5)
    for i, x in enumerate(iterates_inv, 1):
        print(f"  Iteration {i}: {x}")

print("\nEXPLANATION FOR PART (d):")
print("""Where does the sequence converge to and why?
  - For shift s = -5.5, it converges to [-0.7071, 0, 0.7071]^T (eigenvector for lambda = -6).
  - For shift s = 2.5, it converges to [0.5774, 0.5774, 0.5774]^T (eigenvector for lambda = 3).
  - For shift s = 0.5, it converges to [-0.4082, 0.8165, -0.4082]^T (eigenvector for lambda = 0).

Why does this happen?
  - The inverse power method with a shift 's' is mathematically equivalent to applying the 
    standard power method to the matrix (A - sI)^-1.
  - The eigenvalues of (A - sI)^-1 are exactly 1 / (lambda_i - s). 
  - Therefore, the dominant eigenvalue of this inverted matrix corresponds to the original 
    eigenvalue lambda_i that makes the denominator (lambda_i - s) as small as possible. 
  - By choosing a shift 's' close to a specific target eigenvalue, we make 1 / (lambda_i - s) 
    the largest magnitude eigenvalue, forcing the sequence to converge rapidly to its 
    corresponding eigenvector.""")