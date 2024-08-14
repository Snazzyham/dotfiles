# one light inspired shell soham
# A template was taken and modified from Tokyonight:
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish

# Define colors
set -l background "#FAFAFA"
set -l foreground "#383A42"
set -l selection "#986801"
set -l comment "#696C77"
set -l accent "#0184BC"
set -l error "#E45649"

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
