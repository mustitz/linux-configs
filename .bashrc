###
### Mustitz settings
###

# Some more ls aliases
# This is standard Ubuntu config configuration
# I like to see human readable file sizes like 11M not 10874560
alias ll='ls -ahlF'

# Some history tweaks, increasing scrolling size etc...
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=50000
export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
shopt -s cmdhist

# Usually I install some libs from sources, it is useful to have path to them
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# My favorite editor VIM of course!
export EDITOR=vim

# Function to set terminal title, I do like tabs
function set-title(){
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Some alisases
alias diff='colordiff -u'
alias gdb='gdb -q'
alias gitlog='git log --oneline -n13'

. $HOME/projects/linux-configs/mustitz.sh
