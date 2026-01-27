# Dotfiles Theme System

A unified theming system that keeps colors consistent across all your tools.

## Quick Start

```fish
# Apply a theme
./theme-apply.fish hamblue

# Or use the fish function (after setup)
theme hamblue

# List available themes
theme --list

# Check current theme
theme --current
```

## Supported Applications

The theme system updates colors for:

| Application | Config Location | What's Updated |
|-------------|-----------------|----------------|
| Hyprland | `~/.config/hypr/themes/current.conf` | Border colors, variables |
| Foot | `~/.config/foot/foot.ini` | All 16 terminal colors |
| Mako | `~/.config/mako/config` | Background, text, border |
| Waybar | `~/.config/waybar/style.css` | CSS variables (`:root`) |
| Starship | `~/.config/starship.toml` | Palette + palette selection |
| Fish | `~/.config/fish/conf.d/theme.fish` | Shell colors, LS_COLORS |
| Neovim | `~/.config/nvim/lua/colors/theme.lua` | Lua color table |
| Fuzzel | `~/.config/fuzzel/fuzzel.ini` | Launcher colors |
| wlogout | `~/.config/wlogout/style.css` | CSS variables |
| hyprlock | `~/.config/hypr/hyprlock.conf` | Lock screen colors |

## Theme File Format

Themes are simple `key=value` files in `themes/*.conf`:

```conf
# Theme Name
# Description of the theme

# Core palette (required - these 5 define your theme)
bg=000000        # Background
fg=F4F4F9        # Foreground/text
dark=2F4550      # Dark accent
medium=577787    # Medium accent
light=B8DBD9     # Light accent/highlight

# Semantic aliases (optional - defaults to core palette)
accent=$light           # Main accent color
border_active=$light    # Active window border
border_inactive=$dark   # Inactive window border
text=$fg               # Primary text
text_dim=$medium       # Secondary/dimmed text
surface=$dark          # Surface/panel background
error=E06C75           # Error color
warning=E5C07B         # Warning color
success=98C379         # Success color

# Terminal colors (optional - for foot, nvim terminal, etc.)
black=$bg
red=CC6666
green=98C379
yellow=E5C07B
blue=$medium
magenta=B294BB
cyan=$light
white=$fg
bright_black=$dark
bright_red=D54E53
bright_green=B9CA4A
bright_yellow=E7C547
bright_blue=7AA6DA
bright_magenta=C397D8
bright_cyan=70C0B1
bright_white=FFFFFF
```

### Color Format

- All colors are **6-digit hex without the `#` prefix**
- Example: `bg=000000` not `bg=#000000`
- You can reference other colors with `$`: `accent=$light`

### Required vs Optional

**Required (core palette):**
- `bg`, `fg`, `dark`, `medium`, `light`

**Optional (have sensible defaults):**
- Semantic colors: `accent`, `border_active`, `border_inactive`, `text`, `text_dim`, `surface`, `error`, `warning`, `success`
- Terminal colors: `black`, `red`, `green`, etc.

## Creating a New Theme

1. Copy an existing theme:
   ```fish
   cp themes/hamblue.conf themes/mytheme.conf
   ```

2. Edit the core palette:
   ```fish
   nvim themes/mytheme.conf
   ```

3. Apply and test:
   ```fish
   ./theme-apply.fish mytheme
   ```

### Tips for Creating Themes

- Start with just the 5 core colors (`bg`, `fg`, `dark`, `medium`, `light`)
- Use a tool like [coolors.co](https://coolors.co) to generate palettes
- Test contrast ratios for accessibility
- The semantic aliases let you fine-tune without changing the core palette

## Installation

### 1. Set up Hyprland to source the theme

Add to your `~/.config/hypr/hyprland.conf`:

```conf
source = ~/.config/hypr/themes/current.conf
```

Make sure your hyprland config uses the variables:
```conf
general {
    col.active_border = $lightbluegrey
    col.inactive_border = $darkbluegrey
}
```

### 2. Add the fish function

Copy or symlink the function:

```fish
cp ~/dotfiles/fish/functions/theme.fish ~/.config/fish/functions/
```

Or add to your fish config:
```fish
source ~/dotfiles/fish/functions/theme.fish
```

### 3. Set up Neovim to use theme colors

In your nvim config (e.g., `init.lua`):

```lua
-- Load theme colors
local ok, theme = pcall(require, 'colors.theme')
if ok then
    -- Use theme.colors.bg, theme.colors.fg, etc.
    -- Or pass to your colorscheme
end
```

### 4. Update Waybar CSS to use variables

After running the theme script, your waybar CSS will have `:root` variables. Update your CSS to use them:

```css
/* Old way */
background-color: #282C34;

/* New way */
background-color: var(--bg);
```

## Adding Support for New Applications

To add theme support for a new application:

1. Edit `theme-apply.fish`
2. Add a new function `apply_yourapp`:

```fish
function apply_yourapp
    set -l config "$HOME/.config/yourapp/config"

    if not test -f $config
        log_warn "yourapp config not found, skipping"
        return
    end

    log_info "Applying to yourapp..."

    # Update colors using sed, or generate a new file
    sed -i "s/^background=.*/background=#"(get_color bg)"/" $config

    log_success "yourapp config updated"
end
```

3. Call it from the `main` function:
```fish
apply_yourapp
```

## Available Colors

When writing `apply_*` functions, these colors are available:

| Variable | Description |
|----------|-------------|
| `bg` | Background |
| `fg` | Foreground |
| `dark` | Dark accent |
| `medium` | Medium accent |
| `light` | Light accent |
| `accent` | Main accent (usually = light) |
| `surface` | Surface/panel bg |
| `error` | Error color |
| `warning` | Warning color |
| `success` | Success color |
| `black` through `white` | Terminal colors |
| `bright_black` through `bright_white` | Bright terminal colors |

Use `(get_color name)` to retrieve a color (returns hex without #).

## Backup Integration

The themes directory is part of your dotfiles repo. The generated files in `~/.config/*/` are backed up by `backup_dotfiles.fish`.

When you run `backup_dotfiles.fish`:
- Your theme definitions in `themes/*.conf` are already in the repo
- The applied configs (foot.ini, mako/config, etc.) are backed up
- You can restore your full setup including current theme

## Troubleshooting

**Colors not updating?**
- Restart the application (some don't support live reload)
- For fish: `source ~/.config/fish/conf.d/theme.fish`
- For Hyprland: `hyprctl reload`

**Waybar not using new colors?**
- The script injects CSS variables, but you need to update your CSS to use `var(--bg)` etc.

**Theme not found?**
- Check the theme file exists: `ls ~/dotfiles/themes/`
- File must be named `themename.conf`

**Some app not updating?**
- Check the config file path in the apply function
- App might not be in the supported list yet
