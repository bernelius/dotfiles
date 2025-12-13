alias javabook='open "/Users/bobhegdal/Documents/Books/Introduction to Java Programming and Data Structures - Daniel Y. Liang.pdf"'
alias osbook='open "/Users/bobhegdal/Documents/OS/Andrew Tanenbaum, Herbert Bos - Modern Operating Systems, 5th Global Edition-Pearson (2024).pdf"'
alias docs='cd ~/Documents/'
alias vim="v"
alias n="v ."
alias novim="nvim -u NONE"
alias ..="cd .."
export PS1='%n %3~ %# '
alias packy='sudo pacman -Syu'

alias avante='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'
case ":${PATH}:" in
  *:"$HOME/.local/bin":*)
    ;;
  *)
  # Prepending path in case a system-installed binary needs to be overridden
  mkdir -p "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$PATH"
  ;;
esac

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

source <(fzf --zsh)
#change directory if exiting nvim in oil
function v() {
  local tmp=$(mktemp)
  nvim -c "Oil" -c "autocmd VimLeave * lua vim.fn.writefile({require('oil').get_current_dir()}, '$tmp')"
  local cwd="$(cat "$tmp")"
  echo "$cwd"
  if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

#change directory in yazi if directory changed
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

stty -ixon # disable ctrl-s outside of tmux

export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.cargo/bin:$PATH"

#WSL-specific
if [ -d "/mnt/c" ]; then
  alias rpr="cd /mnt/g/Black\ Banana\ Studios/REAPER\ (x64)/Scripts/Bob"
  alias open="explorer.exe"
fi

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_BUNDLE_FILE="~/dotfiles/.Brewfile"

#case-insensitive matching
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh --cmd cd)"

# this integrates with .config/sesh/sesh.toml
export ROOT=""
alias root='cd $ROOT'


alias ls='eza --icons=always --group-directories-first --git --color=auto'
alias l='ls'
alias la='eza --icons=always --group-directories-first --git --color=auto --all'
alias lt='eza --icons=always --group-directories-first --git --color=auto --tree'
alias ll='eza --icons=always --group-directories-first --git --color=auto -l'

alias ff='fzf --preview "bat --color=always {}"'

source "$HOME/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

SYMLINK_LOGGER="$HOME/dotfiles/.config/zsh/dotfiles-watch.log"

pgrep -f dotfiles-symlink-watcher.sh >/dev/null || "$HOME/dotfiles/.config/zsh/dotfiles-symlink-watcher.sh" >>"$SYMLINK_LOGGER" 2>&1 &
if [ -d "$HOME/.secrets" ]; then
  source "$HOME/.secrets/api-keys.sh"
fi


if [ -z "$TMUX" ]; then
  fastfetch
  alias s='sesh-sessions'
else
  alias s=$'echo "\nDon\'t tmux your tmux.\n"'
fi
