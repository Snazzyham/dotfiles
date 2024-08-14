set -x GOPATH $HOME/go

set -x EDITOR nvim
set -x VISUAL nvim

set -x DEV_ENV dev

set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin:$PATH $GOPATH/bin /usr/local/bin/solana-release/bin /home/soham/.local/lib/python3.10/site-packages /home/soham/.local/bin


set -x LS_COLORS "di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"


# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

# Locales
set -g -x LC_ALL "en_US.UTF-8"
set -g -x LANG "en_US.UTF-8"

set fish_greeting ""

#! Themes

# source ~/.config/fish/themes/kanagawabones.fish

#fish_config theme choose "Rosé Pine Dawn"
#fish_config theme choose "Catppuccin Latte" 
#fish_config theme choose "Catppuccin Macchiato" 


# Aliases 

alias cat='bat --style header --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

alias vplug='nvim +PlugInstall +qall'
alias ff='nvim +"Telescope find_files"'
alias fo='nvim +"Telescope live_grep"'
alias n='vifm'
alias vold='/usr/bin/vim'
alias vim='nvim'
alias q="qlmanage -p"
alias gd="cd Google\ Drive\ File\ Stream/My\ Drive"
alias gt='cd ~/Documents/github'
alias chrome='open -a "Google Chrome"'
alias mvim='open -a "MacVim"'
alias vr='open -a "VimR"'
alias saf='open -a "Safari"'
alias fnd='open -a "Finder"'
alias prev='open -a "Preview"'
alias md="open -a 'MacDown'"
alias edot="vim ~/dotfiles/"
alias ls='ls -a --color'
alias l="ls -l"
alias i='wezterm imgcat'
alias strd="sudo systemctl start docker.service"
alias stpd="sudo systemctl stop docker.service"
alias wind="cd /mnt/c/Users/soham"

alias lightwm="$HOME/theme_scripts/sway/light.sh"
alias darkwm="$HOME/theme_scripts/sway/dark.sh"

# git remote shortcuts
alias grg="git remote get-url origin"
alias grs="git remote set-url origin "
alias gcx="git commit -a -m"
alias gp="git push origin"

# tmux shortcuts
alias tks="tmux kill-session -t"
alias tas="tmux attach-session -t"

# get tachyons
alias gettach="wget https://raw.githubusercontent.com/tachyons-css/tachyons/master/css/tachyons.min.css"

# westworld shit 
alias ww1="ssh soham@34.64.103.232"
alias ww3="ssh soham@34.64.80.122"

# eurokars
alias mgstaging="ssh root@157.230.43.217"
alias mgadmin="ssh root@159.65.9.137"

# GS Servers
alias gsroot="ssh root@128.199.245.38"
alias gsadmin="mosh admin@128.199.245.38"
alias gs2="ssh soham@165.22.245.249"

# Bigpool
alias bp="ssh soham@34.92.69.85"



# GoLang
set GOROOT '/home/soham/.go'
set GOPATH /home/soham/go
set PATH $GOPATH/bin $GOROOT/bin $PATH





# pnpm
set -gx PNPM_HOME "/home/soham/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
#

starship init fish | source
source ~/.config/fish/functions/get_color.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# sst
fish_add_path /home/soham/.sst/bin
