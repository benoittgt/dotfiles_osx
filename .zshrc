ZSH=$HOME/.oh-my-zsh
# ZSH_THEME='clean'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Avoid duplicate in history
setopt hist_find_no_dups
setopt hist_ignore_all_dups

# avoid error with rake arguments
unsetopt nomatch

# When you don't prefer fuzzy matching and do not wish to "quote" every word
export FZF_DEFAULT_OPTS="--exact --height 80% --reverse"
export disable_rubocop=true

plugins=(git rails common-aliases git-extras)

# source ~/zsh_custom/per-directory-history.plugin.zsh
source $ZSH/oh-my-zsh.sh

# Enable history in IEX through Erlang(OTP)
export ERL_AFLAGS="-kernel shell_history enabled"

# export PATH source
# source ~/.zshrc_export_path
cd ~/code/

#Alias
alias tmux='tmux -2'
alias rbr='rerun --dir app,spec,config bin/rspec -b -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" '
alias rbrd='rerun --dir app,spec,config  -p "**/*.{rb,js,jbuilder,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md}" 'bin/rspec --format documentation''
alias m='mvim .'
alias n='nvim .'
alias gcd='gco develop'
alias gct='gco trunk'
alias gst='git status -uall'
alias gcm="git checkout \`git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'\`"
alias api='cd ~/code/appaloosa-api/'
alias lambda='cd ~/code/appaloosa_lambdas'
alias cca='cd ~/code/appaloosa/'
alias c='cd ~/code'
alias glog='git log --graph --oneline --stat --pickaxe-all'
alias gbr='git branch -r | grep -v HEAD | while read b; do git log --color --format="%ci _%<(15,trunc)%C(magenta)%cr %C(bold cyan)$b%Creset %s %C(bold blue)<%an>%Creset" $b | head -n 1; done | sort -r | cut -d_ -f2- | head -20'
alias composer="php /usr/local/bin/composer.phar"
# alias hub=gh
alias be='bundle exec'
alias ber='bundle exec rspec --format doc'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f ~/dotfiles/.zsh ] && source ~/.fzf.zsh
#
# fbrf - checkout git branch --force, sorted by most recent commit, limit 30 occurences
fbrf() {
  local branches
  local num_branches
  local branch
  local target

  branches="$(
  git for-each-ref \
    --count=30 \
    --sort=-committerdate \
    refs/heads/ \
    --format='%(refname:short)'
      )" || return

  branch="$(
  echo "$branches" \
  | fzf-tmux +m
  )" || return

  target="$(
    echo "$branch" \
     | sed "s/.* //" \
     | sed "s#remotes/[^/]*/##"
   )" || return

  git checkout -f "$target"
}

# fbr - checkout git branch, sorted by most recent commit, limit 30 occurences
fbr() {
  local branches
  local num_branches
  local branch
  local target

  branches="$(
    git for-each-ref \
      --count=30 \
      --sort=-committerdate \
      refs/heads/ \
      --format='%(refname:short)'
  )" || return

  branch="$(
    echo "$branches" \
      | fzf-tmux +m
  )" || return

  target="$(
    echo "$branch" \
      | sed "s/.* //" \
      | sed "s#remotes/[^/]*/##"
  )" || return

  git checkout "$target"
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

review-open() {
  local default_branch=$(git rev-parse --abbrev-ref HEAD)
  local branch="${1:-$default_branch}"
  local base="${2:-develop}"

  local diff_files=$(git diff --name-only origin/$base...$branch)
  echo "Changed files from origin/master..."
  echo $diff_files

  mvim -c "let g:gitgutter_diff_base = 'origin/$base'" -c "let g:gitgutter_enabled = 1" -c ":e!" $(git diff --name-only origin/$base...$branch)
}

review() {
  local default_branch=$(git rev-parse --abbrev-ref HEAD)
  local branch="${1:-$default_branch}"
  local base="${2:-develop}"

  git fetch origin $base $branch

  # This typically fails if you have stashed changes.
  if ! git checkout $branch; then
    return 1
  fi

  # Do this in the background?
  if [[ -a "dev.yml" ]]; then
    dev up
  fi

  review-open $branch $base
}

# v - open files in mvim
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
  while read line; do
    [ -f "${line/\~/$HOME}" ] && echo "$line"
  done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

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
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    sha=$(tail -1 <<< "$out" | cut -d' ' -f1)
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

export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/gpg-agent/bin:$PATH"
export PATH="/Users/bti/Library/Android/sdk/platform-tools:$PATH"
export PATH="/Users/bti/Library/Android/sdk/tools:$PATH"
export PATH="/Users/bti/Library/Android/sdk/build-tools/29.0.3:$PATH"
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

export GPG_TTY=$(tty)
[ -f ~/.gnupg/gpg-agent-info ] && source ~/.gnupg/gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    export GPG_AGENT_INFO
else
    eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf --write-env-file ~/.gnupg/gpg-agent-info )
fi
export PATH="/usr/local/opt/curl/bin:$PATH"
  . /usr/local/etc/profile.d/z.sh
export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
alias dbundle='~/code/bundler/bin/bundle'

# node version switch
eval "$(fnm env --multi)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
