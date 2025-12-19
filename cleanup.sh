#!/usr/bin/env zsh

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

check_trash_files() {
  trash_names=(
    ".DS_Store"
  )

  current_dir=$(pwd)
  for path in "$current_dir"/*(D) "$current_dir"/**/*(D); do
    [[ -f $path ]] || continue
    for name in $trash_names; do
      if [[ ${path:t} == $name ]]; then
        /bin/rm "$path"
        echo "Deleted $path"
      fi
    done
  done
}

check_broken_symlinks
check_trash_files
