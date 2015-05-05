PATH=$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$HOME/.rvm/bin:$PATH
export PATH=/usr/local/bin:$PATH

alias ls='ls -G --color=auto'
alias l='ls -la'
alias ll='ls -lart'
alias inetdns='dig myip.opendns.com @Resolver1.opendns.com +short'
alias inetip='curl -4 -s "http://icanhazip.com"'
alias sslc='openssl s_client -connect'
alias rubyhttp='ruby -run -e httpd -- -p 8000 .'

export EDITOR='vim'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# avoid ruby UTF8/ASCII errors
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'


PS1='┌─[\[\e[0;36m\]\w\[\e[0m\]] \n└─▪ '
# 
if [ -f ~/code/scripts/git-prompt.sh ]; then
  source ~/code/scripts/git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  PS1='┌─[\[\e[0;36m\]\w\[\e[0m\]]$(__git_ps1 " [\[\e[0;35m\]%s\[\e[0m\]]")\n└─▪ '
fi
export PS1

