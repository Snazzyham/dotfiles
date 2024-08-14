#!/usr/bin/fish

# Array of dotfiles to backup
set dotfiles \
    "$HOME/.config/fish" \
    "$HOME/.config/nvim" \
    "$HOME/.wezterm.lua" \
    "$HOME/.tmux.conf" \
    "$HOME/.config/starship.toml" \
    "$HOME/.config/fuzzel" \
    "$HOME/.config/hypr" \
    "$HOME/.config/waybar" \
    "$HOME/.config/wlogout" \
    "$HOME/.config/mako" 

    # Add more files as needed

# Function to backup a single file
function backup_file
    set source $argv[1]
    set dest "./$(basename $source)"
    
    if test -e $source
        if test -d $source
            # It's a directory, so use rsync to copy
            rsync -av $source/ $dest/
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

# Backup each file
for file in $dotfiles
    backup_file $file
end

# Check if there are any changes
if git status --porcelain | grep -q "^"
    # Prompt for commit message
    read -P "Enter commit message: " commit_message

    # Commit changes
    git add .
    git commit -m "$commit_message"

    # Push changes
    git push origin main
    echo "Changes pushed to repository"
else
    echo "No changes to commit"
end
