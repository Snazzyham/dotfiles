#!/usr/bin/env fish

# Local backup configuration
set BACKUP_BASE "$HOME/.config/dotfiles-backup"
set BACKUP_DIR "$BACKUP_BASE/latest"

# Remove old backup if exists, then create new
if test -d "$BACKUP_BASE"
    echo "Removing previous backup..."
    rm -rf "$BACKUP_BASE"
end

mkdir -p "$BACKUP_DIR"
echo "Creating local backup at: $BACKUP_DIR"
echo "=================================="

# Backup current ~/.config state before any changes
cp -r ~/.config/hypr "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/waybar "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/foot "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/fish "$BACKUP_DIR/" 2>/dev/null
echo "✓ Local backup complete"
echo ""

# Prompt for machine type
echo "Which machine are you backing up from?"
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
echo "Backing up dotfiles from: $machine_type"
echo "=================================="

# Array of shared dotfiles to backup
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

# Function to backup a single file/directory
function backup_file
    set source $argv[1]
    set dest "./$(basename $source)"

    if test -e $source
        if test -d $source
            # It's a directory, so use rsync to copy
            rsync -av --exclude='machine.conf' $source/ $dest/
            echo "Backed up directory $source to $dest"
        else
            # It's a file, so use cp
            cp $source $dest
            echo "Backed up file $source to $dest"
        end
    else
        echo "Warning: $source does not exist, skipping"
    end
end

# Backup each shared file
for file in $dotfiles
    backup_file $file
end

echo ""
echo "Backing up machine-specific configs for: $machine_type"
echo "------------------------------------------------------"

# Create machine directories if they don't exist
mkdir -p ./hypr/machines ./foot/machines ./waybar/machines

# Machine-specific config handling
# 1. Hyprland machine.conf -> machines/{type}.conf
if test -f "$HOME/.config/hypr/machine.conf"
    cp "$HOME/.config/hypr/machine.conf" "./hypr/machines/$machine_type.conf"
    echo "  [hypr]   -> Backed up machine.conf to machines/$machine_type.conf"
end

# 2. Foot terminal config
if test -f "$HOME/.config/foot/foot.ini"
    cp "$HOME/.config/foot/foot.ini" "./foot/machines/$machine_type.ini"
    echo "  [foot]   -> Backed up foot.ini to machines/$machine_type.ini"
end

# 3. Waybar config
if test -f "$HOME/.config/waybar/config"
    cp "$HOME/.config/waybar/config" "./waybar/machines/$machine_type.json"
    echo "  [waybar] -> Backed up config to machines/$machine_type.json"
end

echo ""
echo "=================================="
echo "Backup complete for $machine_type!"
echo ""
echo "Local backup available at: $BACKUP_DIR"
echo "(This will be overwritten on next backup)"
echo ""

# Check if there are any changes
if git status --porcelain | grep -q "^"
    echo "Changes detected. Review with: git status"
    echo "Stage changes with: git add -p ."
    echo "Then commit and push."
else
    echo "No changes to commit"
end
