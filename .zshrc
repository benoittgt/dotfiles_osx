ZSH=$HOME/.oh-my-zsh
ZSH_THEME='sunrise'

# Avoid duplicate in history
setopt hist_find_no_dups
setopt hist_ignore_all_dups

# When you don't prefer fuzzy matching and do not wish to "quote" every word
export FZF_DEFAULT_OPTS="--exact --height 80% --reverse"
export disable_rubocop=true

plugins=(git rails ruby terminalapp common-aliases git-extras)

source $ZSH/oh-my-zsh.sh

# export PATH source
# source ~/.zshrc_export_path
cd ~/code/appaloosa/

#Alias
alias tmux='tmux -2'
alias rbr='rerun --dir app,spec,config bin/rspec -b -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" '
alias rbrd='rerun --dir app,spec,config  -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" 'bin/rspec --format documentation''
alias m='mvim .'
alias gpom='git push origin $(current_branch):master'
alias gcd='gco develop'
alias gbb='git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gst='git status -uall'
alias gw='bundle exec guard --watchdir spec/ app/ lib/'
alias gu='bundle exec guard'
alias r='spring stop && rake'
alias api='cd ~/code/appaloosa-api/'
alias b='spring stop && bundle exec guard'
alias lambda='cd ~/code/appaloosa_lambdas'
alias mla='cd ~/code/appaloosa_lambdas && m'
alias mca='cd ~/code/appaloosa && m'
alias cca='cd ~/code/appaloosa/'
alias ctags='`brew --prefix`/bin/ctags'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fbr - checkout git branch, sorted by most recent commit, limit 30 occurences
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# v - open files in mvim
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
  while read line; do
    [ -f "${line/\~/$HOME}" ] && echo "$line"
  done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
