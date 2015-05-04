ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"

plugins=(git rails ruby terminalapp common-aliases git-extras)

source $ZSH/oh-my-zsh.sh

# export PATH source
# source ~/.zshrc_export_path

#Alias
alias tmux="tmux -2"
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

#Clean anoying warning when using git push
unset GNOME_KEYRING_CONTROL
alias cca="cd ~/code/appaloosa/"
alias ctags="`brew --prefix`/bin/ctags"
