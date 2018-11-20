parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export HISTCONTROL=erasedups
export EDITOR=vim
export HISTSIZE=999999
export HISTFILESIZE=999999

shopt -s extglob
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s globstar
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s checkwinsize

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] \$ '

alias ls='ls -G'
#alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /usr/local/etc/bash_completion ]; then 
    . /usr/local/etc/bash_completion
  fi
fi

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/bin:$PATH:$HOME/.rvm/bin"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:/usr/local/opt/findutils/libexec/gnuman:/usr/local/opt/grep/libexec/gnuman:$MANPATH"
