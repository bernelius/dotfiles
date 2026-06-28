{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gitmux
  ];

  programs.tmux = {
    enable = true;
    prefix = "C-s";
    mouse = true;
    escapeTime = 10;
    historyLimit = 10000;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g allow-passthrough on
      set -as terminal-features ",xterm-ghostty:RGB"
      set -as terminal-features ",xterm-ghostty:focus"

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key - split-window -v
      bind-key | split-window -h

      bind-key x kill-pane
      set -g detach-on-destroy off

      set -g status-interval 2

      unbind t
      bind-key t run-shell "~/.config/tmux/sesh_launcher.sh"
      bind-key C-t run-shell "~/.config/tmux/sesh_launcher.sh"

      # Configure Catppuccin overrides
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_pane_status_enabled "off"
      set -g @catppuccin_pane_border_status "off"

      # modify bg to be darker
      set -gq @thm_bg "#121212"
      set -gq @thm_mantle "#121212"
      set -gq @thm_crust "yellow"

      # status left look and feel
      set -g status-left-length 100
      set -g status-left ""
      set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

      # status right look and feel
      set -g status-right-length 100
      set -g status-right ""
      set -ga status-right '#(gitmux -cfg $HOME/.config/tmux/gitmux.conf "#{pane_current_path}")'

      # Configure Tmux
      set -g status-position top
      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"

      # pane border look and feel
      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

      # window look and feel
      set -wg automatic-rename on
      set -g automatic-rename-format '#{pane_current_command}'

      set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
      set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
      set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
      set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
      set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

      set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"
        '';
      }
      vim-tmux-navigator
    ];
  };

  xdg.configFile."tmux/sesh_launcher.sh" = {
    source = ../../config/tmux/sesh_launcher.sh;
    executable = true;
  };

  xdg.configFile."tmux/gitmux.conf".source = ../../config/tmux/gitmux.conf;
}
