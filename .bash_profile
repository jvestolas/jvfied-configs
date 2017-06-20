
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/Cellar/bcrypt/1.1/bin:$PATH"

# --------
# Git Aliases
# --------
alias ll="ls -al"
alias gs="git status"
alias gaa="git add ."
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias gpu="git push -u origin HEAD"
alias gpf="git push --force-with-lease"
alias gl="git log"
alias gitjk="history 10 | tail -r | gitjk_cmd"
alias gps="git branch"
alias booty="git stash list"
alias hoard-booty="git stash"
alias pop-booty="git stash pop"
alias toss-booty="git stash drop"
alias be="bundle exec"
alias snap-prod="bundle exec rake db:snapshot:import"
alias nr="npm run"

# ----------
# Functions
# ----------
function st {
    ps -ax | grep $1
}

function my_docs {
    cd ~/Documents/$1
}

function _b {
    vim ~/.bash_profile
}

function _v {
    vi ~/.vimrc
}

function whereis_gnm {
    npm list -g | grep $1
}

function whereis_nm {
    npm list $1
}

function phresh {
    git checkout -b $1
}

function go {
    git checkout $1
}

function s-dep {
    echo "executing the following command: branch=$1 bundle exec cap $2 deploy" 
    branch=$1 bundle exec cap $2 deploy
}

function toss-booty {
    git stash drop stash@{$1}
}

function get-booty {
    git stash apply stash@{$1}
}

function pop-booty {
    git stash pop stash@{$1}
}

function smoosh {
    git rebase -i HEAD~$1
}

function snap-import {
    bundle exec rake db:snapshot:import[\'$1\']
}
