#!/bin/bash

# Directory containing the blurred images
input_dir="./Blurred"
# Directory where the deblurred images will be saved
output_dir="./Deblurred"

# Loop over each subdirectory in the Blurred directory
for subdir in "$input_dir"/*; do
    if [ -d "$subdir" ]; then
        # Create a corresponding subdirectory in the Deblurred directory
        output_subdir="$output_dir"/$(basename "$subdir")
        mkdir -p "$output_subdir"
        
        # Process each image in the subdirectory
        for img in "$subdir"/*; do
            echo "Processing $img..."
            python test.py "$img" "$output_subdir"
        done
    fi
done

echo "All images processed."
