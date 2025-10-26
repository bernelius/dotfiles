#!/usr/bin/env bash

#
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Enable dotglob for processing hidden files in loops
shopt -s dotglob

echo "Linking dotfiles from $DOTFILES_DIR"

# Recursive function to link dotfiles
# Arguments:
#   $1: source_path (path in dotfiles repo)
#   $2: target_path (path in HOME directory)
link_dotfile() {
    local filename
    local source_path="$1"
    local target_path="$2"
    filename=$(basename "$source_path")


    if [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" || "$filename" == "install.sh" || "$filename" == "cleanup.sh" || "$filename" == "make-brewfile.sh" ]]; then
        return
    fi


    if [[ -d "$source_path" ]]; then # If it's a directory
        echo "--> Handling directory: $source_path. Linking contents to $target_path"
        mkdir -p "$target_path" || { echo "Error: Could not create target directory $target_path"; exit 1; }

        # Recurse into the directory's contents
        for item in "$source_path"/* "$source_path"/.*; do
            local item_basename
            # Get the base name of the item within the directory
            item_basename=$(basename "$item")

            # Avoid recursive calls for . and .. when iterating contents
            if [[ "$item_basename" == "." || "$item_basename" == ".." ]]; then
                continue
	    fi

            # Recursively call for each item inside the directory
            link_dotfile "$item" "$target_path/$item_basename"
        done
    elif [[ -f "$source_path" ]]; then # If it's a regular file
        # Check if target exists and is not already a symlink
        if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
            mv "$target_path" "$target_path.backup"
            echo "Backed up existing file $target_path to $target_path.backup"
        fi
        ln -sfn "$source_path" "$target_path"
    else
        echo "Skipping non-regular file/directory (e.g., symlink, device file): $source_path"
    fi
}

# --- Main script execution starts here ---

# Iterate over top-level items in DOTFILES_DIR
for top_level_item in "$DOTFILES_DIR"/*; do
    # For each top-level item, determine its target path in HOME
    # and call the recursive linking function.
    link_dotfile "$top_level_item" "$HOME/$(basename "$top_level_item")"
done

# Turn off dotglob to restore default bash behavior
shopt -u dotglob
echo "Dotfile linking complete."
