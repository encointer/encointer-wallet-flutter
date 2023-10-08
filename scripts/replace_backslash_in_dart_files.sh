#!/bin/bash

# Check if a directory is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

directory="$1"

# Check if the provided directory exists
if [ ! -d "$directory" ]; then
  echo "Error: The specified directory does not exist."
  exit 1
fi

# Use find to locate and process all *.dart files in the specified directory
find "$directory" -type f -name "*.dart" -exec sed -i 's|\\|/|g' {} \;

echo "Replacement complete. All \\ characters in *.dart files converted to /."
