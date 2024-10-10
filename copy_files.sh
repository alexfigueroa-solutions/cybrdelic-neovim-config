#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Retrieve all .lua files tracked by Git (not ignored)
lua_files=$(git ls-files '*.lua')

# Check if git command was successful
if [ $? -ne 0 ]; then
    echo "Error: This directory is not a Git repository or Git is not installed."
    exit 1
fi

# Check if any .lua files are found
if [ -z "$lua_files" ]; then
    echo "No .lua files found in the repository."
    exit 0
fi

# Step 2: Generate structured output with directory paths and file contents
output=""

# Loop through each Lua file
while IFS= read -r file; do
    output+="===== $file =====\n"
    # Read the file content and append
    # Handle binary files gracefully
    if file "$file" | grep -q "binary"; then
        output+="(Binary file content not displayed)\n\n"
    else
        # Escape backslashes and double quotes for proper formatting
        content=$(<"$file" sed 's/\\/\\\\/g; s/"/\\"/g')
        output+="$content\n\n"
    fi
done <<< "$lua_files"

# Step 3: Copy the structured output to the clipboard based on the operating system

# macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "$output" | pbcopy
    echo "Structured list of .lua files and their contents copied to clipboard using pbcopy."

# Linux (requires xclip or xsel)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command_exists xclip; then
        echo -e "$output" | xclip -selection clipboard
        echo "Structured list of .lua files and their contents copied to clipboard using xclip."
    elif command_exists xsel; then
        echo -e "$output" | xsel --clipboard --input
        echo "Structured list of .lua files and their contents copied to clipboard using xsel."
    else
        echo "Error: Install xclip or xsel to enable clipboard functionality on Linux."
        exit 1
    fi

# Windows (Git Bash)
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Use Windows clip command
    # echo -e is not supported in Windows, so use printf
    printf "%b" "$output" | clip
    echo "Structured list of .lua files and their contents copied to clipboard using clip."

# Unsupported OS
else
    echo "Error: Unsupported operating system."
    exit 1
fi
