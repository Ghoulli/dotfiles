# Starship prompt
starship init fish | source

# Useful aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias dotfiles='cd ~/dotfiles'

# Clean greeting
set fish_greeting ""

# Qt dark mode
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx QT_STYLE_OVERRIDE kvantum
