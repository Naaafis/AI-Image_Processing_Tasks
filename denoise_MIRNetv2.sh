#!/bin/bash

# Define the root directory for the input images and the output directory
input_root="noised_images"
output_root="denoised_images"

# Define the task type, adjust according to the actual task you are performing
task_type="real_denoising"

# Function to process a directory
process_directory() {
    local input_dir=$1
    local output_dir=$2

    echo "Processing $input_dir..."
    echo "Output will be saved in $output_dir"
    mkdir -p "$output_dir"

    # Run the Python script for each directory
    python demo.py --task $task_type --input_dir "$input_dir" --result_dir "$output_dir"
}

# Export the function so it can be used in subshells
export -f process_directory
export task_type

# Find all leaf directories containing .png or .tif image files
find $input_root -type f \( -iname "*.png" -o -iname "*.tif" \) | sed -r 's|/[^/]+$||' | sort | uniq | while read dir; do
    # Construct the corresponding output directory path
    output_dir="${dir/$input_root/$output_root}"
    process_directory "$dir" "$output_dir"
done

