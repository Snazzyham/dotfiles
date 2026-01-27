# TomorrowNight-HamBlue tmux Theme

# Status bar colors
set-option -g status-style bg="#282a2e",fg="#b4b7b4"

# Window status colors
set-window-option -g window-status-style fg="#b4b7b4",bg="#282a2e"
set-window-option -g window-status-current-style fg="#f0c674",bg="#282a2e",bold

# Pane border colors
set-option -g pane-border-style fg="#282a2e"
set-option -g pane-active-border-style fg="#b4b7b4"

# Message colors
set-option -g message-style bg="#373b41",fg="#e0e0e0"

# Clock color
set-window-option -g clock-mode-colour "#81a2be"

# Status bar content
set -g status-left "#[fg=#282a2e,bg=#b4b7b4,bold] #S #[fg=#b4b7b4,bg=#282a2e,nobold,noitalics,nounderscore]"
set -g status-right "#[fg=#b4b7b4,bg=#282a2e,nobold,noitalics,nounderscore]#[fg=#282a2e,bg=#b4b7b4] %Y-%m-%d #[fg=#282a2e,bg=#b4b7b4,nobold,noitalics,nounderscore]#[fg=#282a2e,bg=#b4b7b4] %H:%M "

# Window format
set -g window-status-format "#[fg=#282a2e,bg=#373b41,nobold,noitalics,nounderscore] #[fg=#282a2e,bg=#373b41]#I #[fg=#282a2e,bg=#373b41,nobold,noitalics,nounderscore] #[fg=#282a2e,bg=#373b41]#W #F #[fg=#373b41,bg=#282a2e,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=#282a2e,bg=#f0c674,nobold,noitalics,nounderscore] #[fg=#282a2e,bg=#f0c674]#I #[fg=#282a2e,bg=#f0c674,nobold,noitalics,nounderscore] #[fg=#282a2e,bg=#f0c674]#W #F #[fg=#f0c674,bg=#282a2e,nobold,noitalics,nounderscore]"

# Window separator
set -g window-status-separator ""
