#!/usr/bin/fish

# Array of dotfiles to restore (destination paths)
set dotfiles \
    "$HOME/.config/fish" \
    "$HOME/.config/nvim" \
    "$HOME/.wezterm.lua" \
    "$HOME/.tmux" \
    "$HOME/.tmux.conf" \
    "$HOME/.config/starship.toml" \
    "$HOME/.config/hypr" \
    "$HOME/.config/swayidle" \
    "$HOME/.config/hamblue-theme" \
    "$HOME/.config/waybar" \
    "$HOME/.config/swappy" \
    "$HOME/.config/rofi" \
    "$HOME/.config/fuzzel" \
    "$HOME/.config/wlogout" \
    "$HOME/.config/foot" \
    "$HOME/.config/mako" \
    "$HOME/.config/themes" \
    "$HOME/.config/theme-apply.fish" \
    "$HOME/.config/gtk-3.0" \
    "$HOME/.config/gtk-4.0"

    # Add more files as needed

# Function to restore a single file/directory
function restore_file
    set dest $argv[1]
    set source "./$(basename $dest)"

    if test -e $source
        # Create parent directory if needed
        mkdir -p (dirname $dest)

        if test -d $source
            # It's a directory, so use rsync to copy
            rsync -av $source/ $dest/
            echo "Restored directory $source to $dest"
        else
            # It's a file, so use cp
            cp $source $dest
            echo "Restored file $source to $dest"
        end
    else
        echo "Warning: $source does not exist in dotfiles, skipping"
    end
end

# Restore each file
for file in $dotfiles
    restore_file $file
end

echo ""
echo "Dotfiles restored! You may need to:"
echo "  - Restart your terminal"
echo "  - Run: source ~/.config/fish/config.fish"
echo "  - Run: ~/.config/theme-apply.fish <theme-name>"
echo "  - Restart apps like waybar, mako, etc."
