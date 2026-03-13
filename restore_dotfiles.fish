#!/usr/bin/env fish

# Local backup configuration (backup before restore in case something goes wrong)
set RESTORE_BACKUP_DIR "$HOME/.config/dotfiles-backup/pre-restore-$(date +%Y%m%d-%H%M%S)"

# Create backup of current state before restoring
echo "Creating safety backup before restore..."
echo "=================================="
mkdir -p "$RESTORE_BACKUP_DIR"
cp -r ~/.config/hypr "$RESTORE_BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/waybar "$RESTORE_BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/foot "$RESTORE_BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/fish "$RESTORE_BACKUP_DIR/" 2>/dev/null
echo "✓ Safety backup created at: $RESTORE_BACKUP_DIR"
echo ""

# Prompt for machine type
echo "Which machine are you restoring to?"
echo "  1) Desktop"
echo "  2) Laptop"
echo ""
read -P "Enter choice [1/2]: " choice

switch $choice
    case 1 d D desktop Desktop
        set machine_type "desktop"
    case 2 l L laptop Laptop
        set machine_type "laptop"
    case '*'
        echo "Invalid choice. Defaulting to desktop."
        set machine_type "desktop"
end

echo ""
echo "Restoring dotfiles for: $machine_type"
echo "=================================="

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

# Restore each shared file
for file in $dotfiles
    restore_file $file
end

echo ""
echo "Applying machine-specific configs for: $machine_type"
echo "---------------------------------------------------"

# Machine-specific config handling
# 1. Hyprland machine.conf
if test -f "./hypr/machines/$machine_type.conf"
    cp "./hypr/machines/$machine_type.conf" "$HOME/.config/hypr/machine.conf"
    echo "  [hypr]   -> Copied $machine_type.conf to machine.conf"
else
    # Create empty machine.conf if no specific config exists
    touch "$HOME/.config/hypr/machine.conf"
    echo "  [hypr]   -> Created empty machine.conf (no machine-specific config found)"
end

# 2. Foot terminal config
if test -f "./foot/machines/$machine_type.ini"
    cp "./foot/machines/$machine_type.ini" "$HOME/.config/foot/foot.ini"
    echo "  [foot]   -> Copied $machine_type.ini to foot.ini"
end

# 3. Waybar config
if test -f "./waybar/machines/$machine_type.json"
    cp "./waybar/machines/$machine_type.json" "$HOME/.config/waybar/config"
    echo "  [waybar] -> Copied $machine_type.json to config"
end

echo ""
echo "=================================="
echo "Dotfiles restored for $machine_type!"
echo ""
echo "Safety backup available at: $RESTORE_BACKUP_DIR"
echo "(If something broke, you can restore from here manually)"
echo ""
echo "You may need to:"
echo "  - Restart your terminal"
echo "  - Run: source ~/.config/fish/config.fish"
echo "  - Run: ~/.config/theme-apply.fish <theme-name>"
echo "  - Run: hyprctl reload"
echo "  - Restart waybar: killall waybar && waybar &"
