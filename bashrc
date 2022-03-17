parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)

parse_exit_code() {
  local EXIT="$?"
  if [ $EXIT == 0 ]; then printf "${GREEN}%s" "$(date "+%H:%M:%S")"; else printf "${RED}%s" "$(date "+%H:%M:%S")"; fi
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

PROMPT_COMMAND='history -a'

PS1=''
#PS1+='$(parse_exit_code)\[\033[00m\] ($(basename $KUBECONFIG)):\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\]:\n$ '
PS1+='$(parse_exit_code)\[\033[00m\] ($(basename $KUBECONFIG)):\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] $ '

alias ls='ls -G --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/sphinx-doc/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/bin:/usr/local/go/bin:$PATH:$HOME/.rvm/bin:$HOME/go/bin"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:/usr/local/opt/findutils/libexec/gnuman:/usr/local/opt/grep/libexec/gnuman:$MANPATH"
export KUBECONFIG=~/.kube/okd5
export DATASTORE_TYPE=kubernetes
export GOPATH=~/go

#alias virsh='virsh -c "qemu+ssh://tester@172.16.43.10/system?socket=/run/libvirt/libvirt-sock"'

alias occ_qa='export KUBECONFIG=~/.kube/qa'
alias occ_okd='export KUBECONFIG=~/.kube/okd'
alias occ_vegman3='export KUBECONFIG=~/.kube/vegman3'
alias occ_lab='export KUBECONFIG=~/.kube/lab'
alias occ_eias='export KUBECONFIG=~/.kube/eias'
alias occ_beryl='export KUBECONFIG=~/.kube/beryl'
alias occ_okd5='export KUBECONFIG=~/.kube/okd5'
alias occ_okd6='export KUBECONFIG=~/.kube/okd6'
alias occ_okd7='export KUBECONFIG=~/.kube/okd7'

[[ -r "/usr/local/bin/pve_okd5" ]] && . "/usr/local/bin/pve_okd5"
