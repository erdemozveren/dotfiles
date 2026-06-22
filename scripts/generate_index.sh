#!/usr/bin/env bash

# Automatically detect the directory where this script is located
NOTES_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
INDEX_FILE="$NOTES_DIR/index.md"

# Use unique temporary files for sorting safely
TMP_PROJECTS=$(mktemp)
TMP_NOTES=$(mktemp)

# Scan directory contents
for item in "$NOTES_DIR"/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    
    # Skip index.md, hidden files, and the script itself
    if [ "$name" = "index.md" ] || [[ "$name" == .* ]] || [[ "$name" == *.sh ]]; then
        continue
    fi
    
    if [ -d "$item" ]; then
        # Subfolders are treated as Projects - Links to the inner index.md file
        echo "- [$name]($name/index.md)" >> "$TMP_PROJECTS"
    elif [[ "$name" == *.md ]]; then
        # Root markdown files are treated as General Notes
        note_name="${name%.md}"
        echo "- [$note_name]($name)" >> "$TMP_NOTES"
    fi
done

# Build the structured markdown file with standard Markdown syntax
{
    echo "# 📒 My Wiki ($NOTES_DIR)"
    echo ""
    echo "## 🚀 Projects"
    
    if [ -s "$TMP_PROJECTS" ]; then
        sort "$TMP_PROJECTS"
    fi
    
    echo ""
    echo "## 📂 General Notes"
    
    if [ -s "$TMP_NOTES" ]; then
        sort "$TMP_NOTES"
    fi
} > "$INDEX_FILE"

# Clean up temporary files
rm "$TMP_PROJECTS" "$TMP_NOTES"

