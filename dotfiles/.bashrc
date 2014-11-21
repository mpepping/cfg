PATH=$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/.rvm/bin
export PATH

alias l='ls -la'
alias ll='ls -lart'
alias inetdns='dig myip.opendns.com @Resolver1.opendns.com +short'
alias inetip='curl -4 -s "http://icanhazip.com"'
alias sslc='openssl s_client -connect'
alias rubyhttp="ruby -run -e httpd -- -p 8000 ."

export EDITOR="vim"

# avoid ruby UTF8/ASCII errors
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE=en_US.UTF-8

#PS1="┌─[\[\e[0;36m\]\w\[\e[0m\]] \n└─▪ "
