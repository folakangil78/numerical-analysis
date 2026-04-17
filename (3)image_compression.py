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