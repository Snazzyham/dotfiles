# Kanagawa Fish shell theme (Monochrome)
# A template was taken and modified from Tokyonight:
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish

# Define colors
set -l background "#1F1F28"
set -l foreground "#DDD8BB"
set -l selection "#7AA89F"
set -l comment "#727169"
set -l accent "#F5E274"
set -l error "#B0816B"

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $accent
set -g fish_color_keyword $selection
set -g fish_color_quote $selection
set -g fish_color_redirection $foreground
set -g fish_color_end $foreground
set -g fish_color_error $error
set -g fish_color_param $foreground
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $foreground
set -g fish_color_escape $foreground
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $foreground
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
