#!/bin/zsh

check_broken_symlinks() {
  for path in "$HOME"/* "$HOME/.config"/**/*; do
    [[ -L $path ]] || continue
    [[ -e $path ]] && continue

    echo "Broken symlink detected: $path"
    echo -n "Delete it? [y/N]: "
    read -r ans
    if [[ "$ans" == [yY] ]]; then
      ## rm kept failing, hence the full path
      /bin/rm "$path"
      echo "Deleted $path"
    fi
  done
}

check_broken_symlinks
