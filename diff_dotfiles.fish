#!/usr/bin/fish
# Compare live dotfiles vs copies in the current folder (~/dotfiles).
# Prints diffs only when different/missing, plus a final summary of filenames that differ.

set repo_dir (pwd)

# List of dotfiles/dirs to compare
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
    "$HOME/.config/wlogout"

# Build diff options as a LIST (important in fish)
set diff_opts -u
if command diff --version ^/dev/null | string match -q "*GNU diffutils*"
    set diff_opts $diff_opts --color=always
end

function _header
    echo
    echo "===== $argv[1] ====="
end

# --- summary collection ---
set -g changed_files  # list of basenames that differ

function _add_changed --argument-names name
    if not contains -- "$name" $changed_files
        set -g changed_files $changed_files "$name"
    end
end

# Parse which specific files differ inside a directory and add their basenames.
function _collect_changed_from_dir --argument-names repo_path sys_path
    # quiet, recursive: just which entries differ / are only in one side
    set -l out (command diff -qr -- "$repo_path/" "$sys_path/" ^/dev/null)
    for line in (string split -n '\n' -- $out)
        if string match -q "Files * and * differ" -- $line
            # Example: "Files /repo/a/b.conf and /sys/a/b.conf differ"
            set -l rhs (string split -m 1 " and " -- (string replace -r '^Files ' '' -- $line))[2]
            set -l rhs (string replace " differ" "" -- $rhs)
            _add_changed (basename -- $rhs)
        else if string match -q "Only in *: *" -- $line
            # Example: "Only in /repo/a: c.conf"
            set -l file (string split -m 1 ": " -- $line)[2]
            _add_changed (basename -- $file)
        end
    end
end

for file in $dotfiles
    set name (basename -- $file)
    set repo_path "$repo_dir/$name"

    if not test -e "$file"
        _header "$name"
        echo "⚠️  Source missing: $file"
        continue
    end

    if test -d "$file"
        if test -d "$repo_path"
            command diff -rN $diff_opts -- "$repo_path/" "$file/" >/dev/null
            switch $status
                case 0
                    # identical
                case 1
                    _header "$name (repo → system)"
                    command diff -rN $diff_opts -- "$repo_path/" "$file/"
                    _collect_changed_from_dir "$repo_path" "$file"
                case '*'
                    _header "$name"
                    echo "❌ Error running diff for directory"
            end
        else
            _header "$name"
            echo "⚠️  Repo missing directory: $repo_path"
        end
    else if test -f "$file"
        if test -e "$repo_path"
            command diff $diff_opts -- "$repo_path" "$file" >/dev/null
            switch $status
                case 0
                    # identical
                case 1
                    _header "$name (repo → system)"
                    command diff $diff_opts -- "$repo_path" "$file"
                    _add_changed "$name"
                case '*'
                    _header "$name"
                    echo "❌ Error running diff for file"
            end
        else
            _header "$name"
            echo "⚠️  Repo missing file: $repo_path"
        end
    else
        _header "$name"
        echo "ℹ️  Skipping non-regular path: $file"
    end
end

echo
if test (count $changed_files) -gt 0
    echo -n "Files With Differences: "
    printf "%s" (string join ", " -- $changed_files)
    echo
else
    echo "Files With Differences: (none)"
end

echo "Done. Only differing/missing items were shown."
