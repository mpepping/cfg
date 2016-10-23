PATH=$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$HOME/.rvm/bin:$PATH
export PATH=/usr/local/bin:$PATH

alias ls='ls -G'
alias l='ls -l'
alias ll='ls -la'
alias lll='ls -lart'
alias inetdns='dig myip.opendns.com @Resolver1.opendns.com +short'
alias inetip='curl -4 -s "http://icanhazip.com"'
alias unquar='xattr -d com.apple.quarantine'
alias sshuttle='/Users/martijn/Repos/github/sshuttle/sshuttle -r shell 0/0'
alias vboxa='VBoxManage list vms | sed 's/{.*}//''
alias vboxr='VBoxManage list runningvms | sed 's/{.*}//''
alias sslc='openssl s_client -connect'
alias rubyhttp="ruby -run -e httpd -- -p 8000 ."
alias vgp="vagrant ssh -c 'sudo puppet agent -t -d'"
alias vgpn="vagrant ssh -c 'sudo puppet agent -t -d --noop'"
alias drenv='eval "$(docker-machine env $1)" && docker-machine env $1'
alias drenv2='docker-machine env &&  eval "$(docker-machine env)" && echo "All set!"'
alias drcleanexited='docker ps -a | grep Exit | cut -d " " -f 1 | xargs docker rm'
alias mvim='mvim --remote-tab-silent'
alias diff='colordiff'
alias ps2='export PS1="┌─[\[\e[0;36m\]\w\[\e[0m\]] \n└─▪ "'
alias ij="open -a /Applications/IntelliJ\ IDEA\ 15\ CE.app"

export EDITOR="vim"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# avoid ruby UTF8/ASCII errors
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE=en_US.UTF-8


#PS1="\[\e[0;32m\][ \w ]\n$\[\e[m\] "
PS1="┌─[\[\e[0;36m\]\w\[\e[0m\]] \n└─▪ "
# 
if [ -f ~/code/scripts/git-prompt.sh ]; then
  source ~/code/scripts/git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  #PS1='┌─[\[\e[0;36m\]\w\[\e[0m\]]$(__git_ps1 " [%s]")\n└─▪ '
  PS1='┌─[\[\e[0;36m\]\w\[\e[0m\]]$(__git_ps1 " [\[\e[0;35m\]%s\[\e[0m\]]")\n└─▪ '
fi
export PS1

