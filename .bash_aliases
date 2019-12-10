# .bash_profile needs
# source ~/.bash_aliases

alias gs="git status"
alias gb="git branch "
alias gd="git diff "
alias gc="git checkout "
alias gl="git log --pretty=format:"%h%x09%an%x09%ad%x20%s" --date=short | sed 's:	Brendan	201:	Brendan Cunnie	201:g' | head"
alias gl40="git log --pretty=format:"%h%x09%an%x09%ad%x20%s" --date=short | sed 's:	Brendan	201:	Brendan Cunnie	201:g' | head -n40"
alias gl70="git log --pretty=format:"%h%x09%an%x09%ad%x20%s" --date=short | sed 's:	Brendan	201:	Brendan Cunnie	201:g' | head -n70"
alias grevert="echo 'if you want to undo the latest commit, but keep the changes, invoke   git revert HEAD     But THINK about what you are doing.  There is probably an easier way.'"
alias greset="echo 'if you want to undo the latest changes, back to previous commit, invoke   git reset --hard HEAD     But THINK about what you are doing.  There is probably an easier way.'"

alias ll="ls -alF "
alias hg="history | grep "

function _fancy_prompt {
  local RED="\[\033[01;31m\]"
  local BOLD_GREEN="\[\033[01;32m\]"
  local YELLOW="\[\033[01;33m\]"
  local BLUE="\[\033[01;34m\]"
  local WHITE="\[\033[00m\]"
  local GREEN="\[\033[0;32m\]"


  # original:  "\e[0m\e[34m\e[7m\D{%a} \t \! \w\e[0m\n$"
  local PROMPT="\e[0m\e[34m\e[7m\D{%a} \t \! \w "

  # Working directory
  PROMPT=$PROMPT"$GREEN\e[7m"

  # Git-specific
  local GIT_STATUS=$(git status 2> /dev/null)
  if [ -n "$GIT_STATUS" ] # Are we in a git directory?
  then
    # Dirty flag
    echo $GIT_STATUS | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -ne 0 ]
    then
      PROMPT=$PROMPT"$RED"
    fi

    # Branch
    PROMPT=$PROMPT$(git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/" | cut -c 1-80)

    # Warnings
    PROMPT=$PROMPT$RED

    # Merging
    echo $GIT_STATUS | grep "Unmerged paths" > /dev/null 2>&1
    if [ "$?" -eq "0" ]
    then
      PROMPT=$PROMPT"|MERGING"
    fi

    # Dirty flag
    echo $GIT_STATUS | grep "nothing to commit" > /dev/null 2>&1

    # Warning for no email setting
    git config user.email | grep @ > /dev/null 2>&1
    if [ "$?" -ne 0 ]
    then
      PROMPT=$PROMPT" !!! NO EMAIL SET !!!"
    fi

  fi

  PROMPT=$PROMPT"\e[0m\n"

  export PS1=$PROMPT
}

export PROMPT_COMMAND="_fancy_prompt"
