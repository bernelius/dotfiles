alias analbook='open "/Users/bobhegdal/Documents/SYS1000/SAaD, 8th.pdf"'
alias osbook='open "/Users/bobhegdal/Documents/OS/Andrew Tanenbaum, Herbert Bos - Modern Operating Systems, 5th Global Edition-Pearson (2024).pdf"'
alias docs='cd ~/Documents/'
alias books='cd ~/Documents/books/'
nvims() {
    nvim "$(fzf --preview="bat --color=always {}")"
}

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
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
alias rpr="cd /mnt/g/Black\ Banana\ Studios/REAPER\ (x64)/Scripts/Bob"
