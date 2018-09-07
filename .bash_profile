
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# node
export PATH="/usr/local/bin:$PATH"

eval "$(rbenv init -)"

# --------
# Git Aliases
# --------
alias _b="vim ~/.bash_profile"
alias _v="vi ~/.vimrc"
alias ll="ls -al"
alias phresh="git checkout -b $1"
alias st="ps -ax | grep $1"
alias ports="lsof -iTCP -sTCP:LISTEN -P"
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
alias be="bundle exec"
alias ruby_tests="find test/ -name '*_test.rb' | xargs -n1 -I{} bundle exec ruby -Itest {}"
alias yup="yarn upgrade $1"
alias ffm="git merge $1 --ff-only"
alias nl="npm list $1"
alias gl="git log"
alias retrace="git reflog"
alias ar_rollback="be rake db:rollback STEP=$1"
alias varia="git diff $1"
alias nr="npm run $1"
alias nr-local="PATH=$(npm bin):$PATH $1"
alias cl_known_hosts="sed -i'' -e '/s-/d' ~/.ssh/known_hosts"
alias overkill="kill -9 $1"
alias kill-spring="ps aux | awk '/spring/ {print $1}' | xargs kill"
alias pgstart="postgres -D /usr/local/var/postgres"
alias vb_rails="be rails s -b 0.0.0.0"
alias brails="be rails s"
alias crails="be rails c"
alias sidekiq="be sidekiq"
alias fourdude="foreman start -f Procfile"
alias m-sync="git rebase master"
alias find_nm="npm list -g | grep $1"
alias dupe="git clone --depth 1 $1"
alias msstart="mysql.server start"
alias rstart="redis-server &"
alias preptest="bundle exec rake db:test:prepare"
alias git-away="rm -rf .git"
alias git-home="git checkout master"
alias tracks="be rake routes | grep $1"
alias symlink="ln -s $1 $2"

# ----------
# Functions
# ----------
function kill_port {
    kill -9 $(lsof -t -i:$1)
}

function release_the_kraken {
    printf "* * * HAMMERTIME! * * *\n"
    printf "* * * checking out to production * * *\n"
    git checkout production

    printf "* * * pulling production * * *"
    git pull origin production

    printf "* * * merging master into production * * *\n"
    git merge master --ff-only

    printf "* * * pushing to remote production * * *\n"
    git push origin production

    printf "* * * DONE! It's Leeroy Jenkins time! * * *\n\n"
}

function toss-booty {
    git stash drop stash@{$1}
}

function niw {
  mkdir $1
  cd $1
}

function pop-booty {
    if [ ! -z $1 ]
    then
        git stash pop stash@{$1}
    else
        git stash pop
    fi
}

function smoosh {
    printf "rebasing $1 branches..."
    git rebase -i HEAD~$1
}

function my_docs {
  echo "Moving to Documents/$1"
  cd ~/Documents/$1
}

function s-restart {
    printf "restarting the following staging server: $1 \n"
    bundle exec cap $1 deploy:restart
}

function s-dep {
    printf "executing the following command: branch=$1 bundle exec cap $2
    deploy\n"
    branch=$1 bundle exec cap $2 deploy
}

function snap-import {
    printf "\n fetching active record snapshot $1"
    bundle exec rake db:snapshot:import[\'$1\']
}

function revlog {
    if [ $# -eq 0 ]
        then
            echo "Missing arguments staging_name and project_name"
            return
    fi

    project_name=$2
    echo "fetching last ten lines of server revisions log..."

    if [ $# -eq 1 ]
        then
            project_name="coverhound"
    fi

    ssh $1 tail -10 "/mnt/${project_name}/revisions.log"
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
    printf "Dun dun dun DONE!!!\n"
}

function rc_postcommit {
    git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop
}

function rc_precommit {
    git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs rubocop
}

function infinity_war {
    echo "\n ~~~~~~~ GET INFINITY GEMS ~~~~~~~\n"
    bundle exec rake db:migrate
    echo "\n ~~~~~~ SNAP FINGERS ~~~~~~\n"
    bundle exec rake db:reset
    echo "\n ~~~~~~ START OVER ~~~~~~~\n"
    bundle exec rake db:seed
}
