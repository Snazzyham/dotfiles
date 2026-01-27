# Theme management function
# Applies themes from ~/.config/themes/

function theme --description "Apply or manage dotfile themes"
    set -l config_dir "$HOME/.config"
    set -l script "$config_dir/theme-apply.fish"

    if not test -f $script
        echo "Error: theme-apply.fish not found at $script"
        return 1
    end

    if test (count $argv) -eq 0
        # No args - show current theme and list
        set -l current ($script --current 2>/dev/null)
        if test $status -eq 0
            echo "Current theme: $current"
        else
            echo "No theme currently set"
        end
        echo ""
        $script --list
    else
        $script $argv
    end
end

# Completions for theme command
complete -c theme -f
complete -c theme -n "not __fish_seen_subcommand_from --list --current --help" -a "(ls $HOME/.config/themes/*.conf 2>/dev/null | xargs -I{} basename {} .conf)"
complete -c theme -l list -d "List available themes"
complete -c theme -l current -d "Show current theme"
complete -c theme -l help -d "Show help"
