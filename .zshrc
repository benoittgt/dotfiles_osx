ZSH=$HOME/.oh-my-zsh
ZSH_THEME='clean'

plugins=(git rails ruby terminalapp common-aliases git-extras)

source $ZSH/oh-my-zsh.sh

# export PATH source
# source ~/.zshrc_export_path
cd ~/code/appaloosa/

#Alias
alias tmux='tmux -2'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias rbr='rerun bin/rspec -b -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" '
alias m='mvim .'
alias gpoc='git push origin $(current_branch):master'

#Clean anoying warning when using git push
unset GNOME_KEYRING_CONTROL
alias cca='cd ~/code/appaloosa/'
alias ctags='`brew --prefix`/bin/ctags'
