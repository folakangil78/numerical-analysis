import numpy as np
from PIL import Image
import os

# 1. Load the image and convert it to a NumPy matrix
image_filename = "ball.jpg" 

try:
    # Convert('L') ensures the image is treated as grayscale (2D matrix)
    img = Image.open(image_filename).convert('L')
    A = np.array(img)
    print(f"Original image shape: {A.shape}")
except FileNotFoundError:
    print(f"Error: Please ensure '{image_filename}' is in the current directory.")
    exit()

# 2. Compute the Singular Value Decomposition (SVD)
# full_matrices=False computes the reduced SVD, which is more efficient
U, S, Vt = np.linalg.svd(A, full_matrices=False)

m, n = A.shape
original_data_size = m * n

# Define the number of singular values (k) to retain for different compression levels
# You can adjust these based on your image dimensions
k_values = [5, 20, 50, 100, 200]

print("\n--- Compression Results ---")

# 3. Compress, reconstruct, and save for each k
for k in k_values:
    # Ensure k doesn't exceed the maximum possible rank
    k = min(k, len(S))
    
    # Reconstruct the matrix using the top k singular values
    # A_k = U_k * S_k * Vt_k
    A_k = np.dot(U[:, :k], np.dot(np.diag(S[:k]), Vt[:k, :]))
    
    # Clip values to stay within valid grayscale pixel range [0, 255]
    A_k = np.clip(A_k, 0, 255).astype(np.uint8)
    
    # Calculate the amount of data needed to store the compressed version
    # We need to store k columns of U, k singular values, and k rows of Vt
    compressed_data_size = k * m + k + k * n
    compression_ratio = (compressed_data_size / original_data_size) * 100
    
    # Save the reconstructed image
    output_filename = f"compressed_k{k}.png"
    Image.fromarray(A_k).save(output_filename)
    
    print(f"Saved {output_filename} | Singular Values kept: {k} | Data used: {compression_ratio:.2f}% of original")

print("\n--- Answers to Problem Statement Questions ---")

# Q1: What percentage of data of the original image data is necessary to obtain a reasonable image reconstruction?
print("""
1. Percentage of data necessary for a reasonable reconstruction:
   - Typically, retaining just 10% to 20% of the original data (which usually corresponds 
     to the top 20 to 50 singular values, depending on the image resolution) is enough to 
     obtain a "reasonable" reconstruction where the main subject is easily recognizable.
   - For example, if you look at the k=50 image output from this script, you will likely 
     see a highly recognizable image using only a fraction of the original data.
""")

# Q2: How do you think does this depend on the image?
print("""
2. How this depends on the image:
   - The required number of singular values depends heavily on the image's "frequency" or detail.
   - Low-detail images: Images with large areas of smooth, uniform textures or solid backgrounds 
     (like a silhouette, a simple geometric shape, or a clear sky) compress incredibly well. 
     Almost all of their visual energy is captured in the first few singular values.
   - High-detail images: Images with lots of noise, sharp edges, complex patterns, or fine details 
     (like a dense forest canopy or a crowd of people) require a much higher number of singular 
     values to look "reasonable." If you use a low 'k' on these, the reconstruction will look 
     very blurry and lose its defining textures.
""")