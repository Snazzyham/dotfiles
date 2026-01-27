# Claude Instructions: Theme Generation from Color Palettes

When the user sends a color palette image or requests a new theme, follow these instructions.

## Workflow

1. **Analyze the image** - Identify the dominant colors and their roles
2. **Extract 5 core colors** - Map them to: bg, fg, dark, medium, light
3. **Generate terminal colors** - Create a full 16-color palette
4. **Create the theme file** - Write to `~/.config/themes/<name>.conf`
5. **Test and adjust** - Apply and verify contrast/readability

## Color Extraction Guidelines

### The 5 Core Colors

| Color | Role | Typical Source |
|-------|------|----------------|
| `bg` | Background | Darkest color, usually near-black for dark themes |
| `fg` | Foreground/text | Lightest color, high contrast against bg |
| `dark` | Dark accent | Second darkest, used for borders, surfaces |
| `medium` | Medium accent | Mid-tone, used for secondary text, comments |
| `light` | Light accent/highlight | Vibrant accent color, used for focus states |

### From a Palette Image

When given a color palette image:

1. **Identify the darkest color** → `bg` (or use pure black #000000 for OLED)
2. **Identify the lightest color** → `fg` (should be near-white or very light)
3. **Find the primary accent** → `light` (the most vibrant/saturated color)
4. **Find a muted version** → `medium` (less saturated, mid-brightness)
5. **Find a dark accent** → `dark` (dark but distinguishable from bg)

### Contrast Requirements (CRITICAL)

**WCAG AA minimum contrast ratios:**
- Normal text: 4.5:1 against background
- Large text: 3:1 against background
- UI components: 3:1 against adjacent colors

**Always verify:**
```
fg against bg:     Must be ≥ 7:1 (ideal) or ≥ 4.5:1 (minimum)
light against bg:  Must be ≥ 4.5:1
medium against bg: Must be ≥ 3:1 (it's for secondary text)
dark against bg:   Must be ≥ 1.5:1 (subtle but visible)
```

**Tools to check contrast:**
- https://webaim.org/resources/contrastchecker/
- https://coolors.co/contrast-checker

### Common Mistakes to Avoid

1. **Low contrast medium color** - If `medium` is too dark, comments become unreadable
2. **fg too similar to light** - Makes accents invisible on highlighted text
3. **dark indistinguishable from bg** - Borders and surfaces disappear
4. **Oversaturated colors** - Cause eye strain; desaturate slightly for comfort
5. **Using palette colors directly** - Always adjust for contrast requirements

## Generating Terminal Colors

The 16 ANSI colors should complement the theme:

```
black       = bg or slightly lighter
red         = warm error color (keep standard-ish for visibility)
green       = success color (keep recognizable as green)
yellow      = warning color (keep recognizable as yellow)
blue        = can match theme accent or keep standard blue
magenta     = purple/pink accent
cyan        = complement to the theme's light color
white       = fg or slightly dimmer

bright_*    = lighter/more saturated versions of the above
```

**Important:** Keep red, green, yellow somewhat standard so they remain recognizable for their semantic meaning (errors, success, warnings).

## Theme File Format

```conf
# Theme Name
# Brief description

# Core palette (REQUIRED)
bg=000000
fg=F4F4F9
dark=2F4550
medium=577787
light=B8DBD9

# Semantic aliases (optional - defaults to core)
accent=$light
border_active=$light
border_inactive=$dark
text=$fg
text_dim=$medium
surface=$dark
error=E06C75
warning=E5C07B
success=98C379

# Terminal colors (REQUIRED for foot/nvim terminal)
black=$bg
red=CC6666
green=98C379
yellow=E5C07B
blue=$medium
magenta=B294BB
cyan=$light
white=$fg
bright_black=$dark
bright_red=FF6666
bright_green=B9CA4A
bright_yellow=FFD75F
bright_blue=7AA6DA
bright_magenta=C397D8
bright_cyan=70C0B1
bright_white=FFFFFF
```

## Step-by-Step Process

### When user sends a palette image:

1. **List the colors you see** (with hex values if visible)
2. **Propose the mapping:**
   ```
   bg:     #XXXXXX (darkest)
   fg:     #XXXXXX (lightest, contrast ratio: X.X:1)
   dark:   #XXXXXX (dark accent)
   medium: #XXXXXX (mid-tone, contrast ratio: X.X:1)
   light:  #XXXXXX (vibrant accent, contrast ratio: X.X:1)
   ```
3. **Ask for confirmation** before creating the file
4. **Generate terminal colors** that complement the palette
5. **Create the theme file** in `~/.config/themes/`
6. **Instruct user to apply:** `~/.config/theme-apply.fish <name>`

### When user says "contrast looks off":

1. Check which element is problematic
2. Adjust the relevant color:
   - Text hard to read → increase fg brightness or decrease bg brightness
   - Comments invisible → lighten medium color
   - Borders invisible → lighten dark color
   - Accent doesn't pop → increase light saturation
3. Re-apply theme and verify

## Example: Converting a Palette

**User provides:** A blue-grey palette with colors #000000, #2F4550, #577787, #B8DBD9, #F4F4F9

**Analysis:**
- #000000 - Pure black → `bg`
- #F4F4F9 - Off-white → `fg` (contrast vs bg: 21:1 ✓)
- #2F4550 - Dark blue-grey → `dark` (contrast vs bg: 2.5:1 ✓)
- #577787 - Medium blue-grey → `medium` (contrast vs bg: 4.8:1 ✓)
- #B8DBD9 - Light cyan → `light` (contrast vs bg: 12:1 ✓)

**Result:** All contrasts pass. Create theme file.

## Quick Contrast Reference

For dark themes (bg near #000000):
- `fg` should be #D0D0D0 or lighter
- `medium` should be #707070 or lighter for readable comments
- `light` accent should be #909090 or lighter (but usually more saturated)

For light themes (bg near #FFFFFF):
- `fg` should be #303030 or darker
- Adjust all colors accordingly (invert the logic)

## Files Modified by theme-apply.fish

When a theme is applied, these files are updated:
- `~/.config/hypr/themes/current.conf`
- `~/.config/foot/foot.ini`
- `~/.config/mako/config`
- `~/.config/waybar/style.css` (CSS variables)
- `~/.config/starship.toml` (palette added/updated)
- `~/.config/fish/conf.d/theme.fish`
- `~/.config/nvim/lua/colors/theme.lua`
- `~/.config/fuzzel/fuzzel.ini`
- `~/.config/rofi/themes/colors.rasi` + individual themes
- `~/.config/wlogout/style.css` (CSS variables)

## Neovim Integration Note

The theme generates `~/.config/nvim/lua/colors/theme.lua` which exports:
```lua
return {
    colors = { bg = "#...", fg = "#...", ... },
    name = "themename"
}
```

User's colorscheme should import this:
```lua
local ok, theme = pcall(require, 'colors.theme')
if ok then
    -- Use theme.colors.bg, theme.colors.fg, etc.
end
```

Or they can modify their existing hamblue colorscheme to read from this file.
