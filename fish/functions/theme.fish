# Theme management function
# Add this to your fish functions directory

function theme --description "Apply or manage dotfile themes"
    set -l dotfiles_dir "$HOME/dotfiles"
    set -l script "$dotfiles_dir/theme-apply.fish"

    if not test -f $script
        echo "Error: theme-apply.fish not found at $script"
        return 1
    end

    if test (count $argv) -eq 0
        # No args - show current theme and list
        echo "Current theme: "($script --current)
        echo ""
        $script --list
    else
        $script $argv
    end
end

# Completions for theme command
complete -c theme -f
complete -c theme -n "not __fish_seen_subcommand_from --list --current --help" -a "(ls $HOME/dotfiles/themes/*.conf 2>/dev/null | xargs -I{} basename {} .conf)"
complete -c theme -l list -d "List available themes"
complete -c theme -l current -d "Show current theme"
complete -c theme -l help -d "Show help"
