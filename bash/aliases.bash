# Environment-tweaking
alias rsc='source ~/.bash_profile; source ~/dotfiles/bashrc'

# Shortcut for editing/reloading /etc/hosts
alias edit_hosts="mate /private/etc/hosts"
alias reload_hosts="dscacheutil -flushcache"

# Command-line fu
alias   e='mate'
alias  e.='mate .'
alias  ll='ls -lhG'
alias  l1='ls -1hG'
alias lal='ls -alhG'
alias  ls='ls -hG'
alias  df='df -h'
alias  du='du -h'
alias  cp='cp -i' # paranoia
alias  mv='mv -i' # paranoia
alias  rm='rm -i' # paranoia

# Lazy ancestor directory ziggurat of doom
alias        ..='cd ..'
alias       ...='cd ../..'
alias      ....='cd ../../..'
alias     .....='cd ../../../..'
alias    ......='cd ../../../../..'
alias   .......='cd ../../../../../..'
alias  ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'

# git graph
alias  gg+='git log --oneline --abbrev-commit --graph --decorate --color'
alias gga+='git log --oneline --abbrev-commit --graph --decorate --color --all'
alias   gg='gg+  | head -n `expr $LINES / 2`'
alias  gga='gga+ | head -n `expr $LINES / 2`'

# git
alias     g='git'              ; __git_complete g   git
alias    gb='git branch'       ; __git_complete gb  git_branch
alias   gco='git checkout'     ; __git_complete gco git_checkout
alias   gcp='git cherry-pick'  ; __git_complete gcp git_cherry_pick
alias    gd='git diff --color' ; __git_complete gd  git_diff
alias gpfwl='git push --force-with-lease'
alias    gs='git status -bs'
alias   gst='git status'
alias  gwip='git reset --soft HEAD^ && git reset HEAD .'

# Ruby/Rails
alias r='bundle exec rails'
alias acab='echo ; echo ------------------------------ ; echo --- ALL CATS ARE BEAUTIFUL --- ; echo ------------------------------ ; echo ; time bundle exec rubocop'
alias spec='time bundle exec rspec --no-profile --order defined'
alias spec_random='time bundle exec rspec --no-profile --order random'

# Bundler
alias     b='bundle'
alias    be='bundle exec'
alias    bx='bundle exec'
alias    bi='bundle install --jobs=4'
alias brake='bundle exec rake'

# Docker
alias dc='docker compose'
alias dcr='docker compose run'
alias dcrsp='docker compose run --service-ports'

# Kubernetes (abbreviated "k8s", pronounced "cybernoodles")
alias     k="kubectl"
alias    kc="kubectx"
alias    kn="kubens"
alias klogs="kubectl logs"
alias kpods="kubectl get pods"

# SSH agent
alias   agent='eval $(ssh-agent) && ssh-add'
alias deagent='pgrep ssh-agent | xargs kill'
alias reagent='deagent && agent'

# NPM (ugh)
alias nomdance="rm -rf node_modules && npm install"
alias yarndance="rm -rf node_modules && yarn install"

# dig
alias d="dig +noall +answer"

# aws cli (sigh)
alias awtf='aws configure list-profiles'
