set -x GOPATH $HOME/go

set -x EDITOR "vim"

set -x DEV_ENV "dev"

set -x PATH  /usr/local/bin /usr/bin /bin /usr/sbin /sbin:$PATH  $GOPATH/bin /usr/local/bin/solana-release/bin /home/soham/.local/lib/python3.10/site-packages /home/soham/.local/share/fnm home/soham/.fnm

# Locales
set -g -x  LC_ALL "en_US.UTF-8"  
set -g -x LANG "en_US.UTF-8"

# Aliases 


alias vplug='nvim +PlugInstall +qall'
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
alias dl='cd ~/Downloads/'
alias ls='ls -a --color=auto'
alias l="ls -l --color=auto"
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
set GOPATH '/home/soham/go'
set PATH $GOPATH/bin $GOROOT/bin $PATH


source ~/.cache/wal/colors.fish


starship init fish | source


fnm env --use-on-cd | source
