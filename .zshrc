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

# fshow - git commit browser
fshow() {
  local execute
  execute="grep -o \"[a-f0-9]\{7\}\" \
    | head -1 \
    | xargs -I % sh -c 'git show --color=always % | less -R'"
  git log \
    --graph \
    --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf \
        --ansi \
        --no-sort \
        --reverse \
        --tiebreak=index \
        --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute: ($execute) <<'FZF-EOF'
  {}
FZF-EOF"
}
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out
  local q
  local k
  local sha
  while out="$(
    git stash list --pretty='%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs' \
      | fzf \
          --ansi \
          --no-sort \
          --query="$q" \
          --print-query \
          --expect=ctrl-d,ctrl-b
  )"; do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff "$sha"
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" "$sha"
      break
    else
      git stash show -p "$sha"
    fi
  done
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
