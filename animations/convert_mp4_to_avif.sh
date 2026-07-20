#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")"

# Ensure output directory exists
mkdir -p ./Output

# Loop through all mp4 files in the Render directory
for input_file in ./Render/*.mp4; do
    # Check if any mp4 files exist to prevent literal string matching
    [ -e "$input_file" ] || continue

    # Extract the base name without the path and extension
    filename=$(basename "$input_file" .mp4)
    
    # Define the target output path
    output_file="./Output/${filename}.avif"

    # Check if the output file already exists
    if [ -f "$output_file" ]; then
        echo "Skipping: $output_file already exists."
    else
        echo "Processing: $input_file -> $output_file"
        ffmpeg -i "$input_file" -c:v libaom-av1 -crf 25 -b:v 0 -pix_fmt yuv420p "$output_file"
    fi
done