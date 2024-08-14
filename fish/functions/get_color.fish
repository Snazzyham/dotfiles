# # Get the current color scheme setting
# set color_scheme (gsettings get org.gnome.desktop.interface color-scheme)
#
#
# if test "$color_scheme" = "'prefer-dark'"
#   source ~/.config/fish/themes/kanagawabones.fish
#   sed -i 's/background=light/background=dark/' ~/.config/nvim/init.vim
#   sed -i 's/github_light/zenbones/' ~/.config/nvim/init.vim
#   sed -i '1 s/onelight/kanagawabones/' ~/.config/starship.toml
# else
#   source ~/.config/fish/themes/onelight.fish
#   sed -i 's/background=dark/background=light/' ~/.config/nvim/init.vim
#   sed -i 's/zenbones/github_light/' ~/.config/nvim/init.vim
#   sed -i '1 s/kanagawabones/onelight/' ~/.config/starship.toml
# end
