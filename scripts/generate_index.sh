#!/usr/bin/env bash
set -euo pipefail

NOTES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_FILE="$NOTES_DIR/index.md"

projects=()
notes=()

# ----------------------------
# Helper: get first H1 title
# ----------------------------
get_title() {
    local file="$1"
    local mode="${2:-file}"   # file | project

    local title
    title=$(grep -m 1 '^# ' "$file" 2>/dev/null | sed 's/^# //')

    if [ -z "$title" ]; then
        local fallback
        if [ "$mode" = "project" ]; then
            fallback="$(basename "$(dirname "$file")")"
        else
            fallback="$(basename "$file" .md)"
        fi

        title="$(printf '%s' "$fallback" \
            | sed 's/[-_]/ /g' \
            | sed 's/\b\(.\)/\u\1/g')"
    fi

    echo "$title"
}
# ----------------------------
# Scan root directory
# ----------------------------
for item in "$NOTES_DIR"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"

    [[ "$name" == "index.md" || "$name" == .* || "$name" == *.sh ]] && continue

    if [ -d "$item" ]; then
        projects+=("$name")
    elif [[ "$name" == *.md ]]; then
        notes+=("$name")
    fi
done

# ----------------------------
# Tree printer (2 levels only)
# ----------------------------
print_project_tree() {
    local project_dir="$1"

    children=()

    for child in "$project_dir"/*.md; do
        [ -e "$child" ] || continue
        child_name="$(basename "$child")"

        [[ "$child_name" == "index.md" ]] && continue

        children+=("$child_name")
    done

    # sort children
    IFS=$'\n' sorted=($(printf '%s\n' "${children[@]}" | sort))
    unset IFS

    total=${#sorted[@]}
    i=0

    for child_file in "${sorted[@]}"; do
        i=$((i + 1))

        file_path="$project_dir/$child_file"
        title="$(get_title "$file_path")"
        rel_path="$(basename "$project_dir")/$child_file"

        if [ $i -eq $total ]; then
            echo "  └── [$title]($rel_path)"
        else
            echo "  ├── [$title]($rel_path)"
        fi
    done
}

# ----------------------------
# Generate index
# ----------------------------
{
    echo "# 📒 My Wiki"
    echo

    echo "## 🚀 Projects"
    echo

    if [ ${#projects[@]} -gt 0 ]; then
        printf '%s\n' "${projects[@]}" | sort | while read -r project; do
            project_dir="$NOTES_DIR/$project"
            index_file="$project_dir/index.md"

            if [ -f "$index_file" ]; then
                project_title="$(get_title "$index_file" project)"
            else
                project_title="$project"
            fi

            echo "- 📁 [$project_title]($project/index.md)"

            print_project_tree "$project_dir"

            echo
        done
    fi

    echo "## 📂 General Notes"
    echo

    if [ ${#notes[@]} -gt 0 ]; then
        printf '%s\n' "${notes[@]}" | sort | while read -r note; do
            note_path="$NOTES_DIR/$note"
            note_title="$(get_title "$note_path")"
            echo "- [$note_title]($note)"
        done
    fi
} > "$INDEX_FILE"
