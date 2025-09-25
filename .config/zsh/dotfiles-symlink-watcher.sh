#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

#never again (hopefully)
if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
    echo "DOTFILES_DIR looks wrong: $DOTFILES_DIR"
    exit 1
fi

skip_files=(
  "$DOTFILES_DIR/README.md" 
  "$DOTFILES_DIR/.gitignore"
  "$DOTFILES_DIR/install.sh"
  "$DOTFILES_DIR/cleanup.sh"
  "$DOTFILES_DIR/.git"
)

watch_dotfiles() {
  fswatch -0 -r --event Created "$DOTFILES_DIR" | while IFS= read -r -d "" file; do
    rel="${file#"$DOTFILES_DIR"/}"
    target="$HOME/$rel"

    mkdir -p "$(dirname "$target")"

    for skip in "${skip_files[@]}"; do
        if [[ "$file" == "$skip" ]]; then
            continue 2 
        fi
    done

    filename=$(basename "$rel")
    if [[ $filename =~ ^[0-9]+$ || $file == $DOTFILES_DIR/.git/* ]]; then
      continue
    fi


    if [[ ! -e "$target" ]]; then
      ln -sfn "$file" "$target"
      echo "$(date '+%F %T') Linked $file -> $target"
    else
      echo "$(date '+%F %T') Skipped $file -> $target. Reason: file already exists"
    fi

    sleep 0.2
  done
}

watch_dotfiles
