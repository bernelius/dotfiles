alias javabook='open "/Users/bobhegdal/Documents/Books/Introduction to Java Programming and Data Structures - Daniel Y. Liang.pdf"'
alias osbook='open "/Users/bobhegdal/Documents/OS/Andrew Tanenbaum, Herbert Bos - Modern Operating Systems, 5th Global Edition-Pearson (2024).pdf"'
alias docs='cd ~/Documents/'
alias vim="nvim"
nvims() {
    nvim "$(fzf --preview="bat --color=always {}")"
}
export PS1='%n %3~ %# '
case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed binary needs to be overridden
	mkdir -p "$HOME/.local/bin"
        export PATH="$HOME/.local/bin:$PATH"
        ;;
esac

source <(fzf --zsh)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.cargo/bin:$PATH"

#WSL-specific
if [ -d "/mnt/c" ]; then
  alias rpr="cd /mnt/g/Black\ Banana\ Studios/REAPER\ (x64)/Scripts/Bob"
  alias open="explorer.exe"
fi

export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"

#case-insensitive matching
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh --cmd cd)"

alias ls='eza --icons=always --group-directories-first --git'

source "$HOME/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

#SYMLINK_LOGGER="$HOME/dotfiles/.config/zsh/dotfiles-watch.log"

pgrep -f dotfiles-symlink-watcher.sh >/dev/null || "$HOME/dotfiles/.config/zsh/dotfiles-symlink-watcher.sh" &


fastfetch
