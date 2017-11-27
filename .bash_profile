
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/Cellar/bcrypt/1.1/bin:$PATH"

# --------
# Git Aliases
# --------
alias _b="vim ~/.bash_profile"
alias _v="vi ~/.vimrc"
alias ll="ls -al"
alias phresh="git checkout -b $1"
alias st="ps -ax | grep $1"
alias gs="git status"
alias go="git checkout $1"
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
alias hoard-all-booty="git stash save --keep-index --include-untracked"
alias get-booty="git stash apply stash@{$1}"
alias pop-booty="git stash pop stash@{$1}"
alias toss-booty="git stash drop stash@{$1}"
alias smoosh="git rebase -i HEAD~$1"
alias be="bundle exec"
alias snap-prod="bundle exec rake db:snapshot:import"
alias rTest="find test/ -name '*_test.rb' | xargs -n1 -I{} bundle exec ruby -Itest {}"
alias yup="yarn upgrade $1"
alias ffm="git merge $1 --ff-only"
alias nl="npm list $1"
alias gl="git log"
alias retrace="git reflog"
#alias symlink="ln -s $(pwd)/$1 $2"
alias ar_rollback="be rake db:rollback STEP=$1"
alias varia="git diff $1"
alias nr="npm run $1"
alias cl_known_hosts="sed -i'' -e '/s-/d' ~/.ssh/known_hosts"
#alias overkill="kill -9 $(ps aux | grep $1 | grep -v grep | awk '{print $2}')"
alias kill-spring="ps aux | awk '/spring/ {print $2}' | xargs kill"
alias pgstart="postgres -D /usr/local/var/postgres"
alias join_the_dark_side="git merge master --ff-only"
alias all_aboard="git push origin production"
alias release_the_kraken="bundle exec cap production deploy"
alias vb_rails="rails s -b 0.0.0.0"
alias m-sync="git rebase master"
alias find_nm="npm list -g | grep $1"

# ----------
# Functions
# ----------
function niw {
  mkdir $1
  cd $1
}

function my_docs {
  eval dir1="$1"
  eval dir2="$2"
  echo "Moving to Documents/${dir1}/${dir2}"
  cd ~/Documents/${dir1}/${dir2}
}

function snap-import {
    printf "\n fetching active record snapshot $1"
    bundle exec rake db:snapshot:import[\'$1\']
}

function burn {
    echo "Force-deleting branch: $1"
    git branch -D $1
}

function precompile {
    printf "Precompiling Rails assets...\nHEY! CLEAR ASSETS AFTERWARDS IF
    NECESSARY!"
    bundle exec rake assets:precompile
}

function clobberin_time {
    printf "\nIt's clobberin' time!\n\nDestroying Rails assets...\n"
    bundle exec rake assets:clobber
    printf "\nDestroying Rails temporary cache...\n"
    bundle exec rake tmp:cache:clear
}

function rc_postcommit {
    git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop
}

function rc_precommit {
    git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs rubocop
}
