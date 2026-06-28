{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      append = true;
    };

    shellAliases = {
      n = "v";
      nff = "nvim -c 'FzfLua global'";
      nfg = "nvim -c 'FzfLua live_grep'";
      novim = "nvim -u NONE";
      packy = "sudo pacman -Syu";
      avante = "nvim -c 'lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)'";
      root = "cd $ROOT";
    };

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        };
      }
    ];

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        stty -ixon

        # zsh-vi-mode hook for starship (must be defined before plugin loads)
        function zvm_after_init() {
          eval "$(starship init zsh)"
          export PROMPT2='Unclosed %_: '
        }
      '')
      ''
      export PS1='%n %3~ %# '
      export EDITOR="nvim"
      export MANPAGER="nvim +Man!"
      export XDG_CONFIG_HOME="$HOME/.config"
      export OPENCODE_ENABLE_EXA=true
      export ROOT=""

      case ":''${PATH}:" in
          *:"$HOME/.local/bin":*)
              ;;
          *)
              mkdir -p "$HOME/.local/bin"
              export PATH="$HOME/.local/bin:$PATH"
              ;;
      esac

      export PATH="$HOME/.cargo/bin:$PATH"

      function open {
          xdg-open "$1" > /dev/null 2>&1 &; disown
      }

      # case-insensitive matching
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' menu select

      export FZF_CTRL_T_OPTS="
        --height 100%
        --reverse
        --preview 'bat --color=always {}'"

      # cd-up widget
      cd-up() {
          cd ..
          zle reset-prompt
      }
      zle -N cd-up
      bindkey '^O' cd-up

      # sesh sessions
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

      # v - change directory if exiting nvim in oil
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

      # y - change directory in yazi if directory changed
      function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
      }

      # Secrets
      if [ -d "$HOME/.secrets" ]; then
          source "$HOME/.secrets/api-keys"
          source "$HOME/.secrets/secrets"
      fi

      # Fastfetch on fresh login
      if [ -z "$TMUX" ]; then
          fastfetch
          alias s='sesh-sessions'
      else
          alias s=$'echo "\nDon\'t tmux your tmux.\n"'
      fi
    ''
    ];

    loginExtra = ''
      tailscale up --operator="$USER"
    '';
  };
}
