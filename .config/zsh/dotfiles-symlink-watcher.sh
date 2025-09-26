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
    skip_file=0
    for skip in "${skip_files[@]}"; do
      if [[ "$file" == "$skip" ]]; then
        skip_file=1
        break
      fi
    done
    if [[ $skip_file -eq 1 ]]; then
      continue
    fi

    if [[ "$file" == "$DOTFILES_DIR/.git"* ]]; then
      continue
    fi

    filename=$(basename "$rel")
    if [[ $filename =~ ^[0-9]+$ ]]; then
      continue
    fi

    if [[ -d "$file" ]]; then
      mkdir -p "$target"
      continue
    fi
    if [[ ! -e "$target" ]]; then
      mkdir -p "$(dirname "$target")"
      ln -s "$file" "$target"
      echo "$(date '+%F %T') Linked $file -> $target"
    fi

    sleep 0.2
  done
}

watch_dotfiles
