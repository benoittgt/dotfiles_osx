ZSH=$HOME/.oh-my-zsh
ZSH_THEME='clean'

# When you don't prefer fuzzy matching and do not wish to "quote" every word
FZF_DEFAULT_OPTS="-e"

plugins=(git rails ruby terminalapp common-aliases git-extras)

source $ZSH/oh-my-zsh.sh

# export PATH source
# source ~/.zshrc_export_path
cd ~/code/appaloosa/

#Alias
alias tmux='tmux -2'
alias rbr='rerun --dir app,spec,config bin/rspec -b -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" '
alias rbrd='rerun --dir app,spec,config bin/rspec -b --format d -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" '
alias m='mvim .'
alias gpoc='git push origin $(current_branch):master'
alias gbb='git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)"'

#Clean anoying warning when using git push
unset GNOME_KEYRING_CONTROL
alias cca='cd ~/code/appaloosa/'
alias ctags='`brew --prefix`/bin/ctags'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
