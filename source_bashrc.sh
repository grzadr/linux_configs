alias aptup="sudo apt update && sudo apt list --upgradable"
alias aptfull="sudo apt full-upgrade -y"
alias aptvacuum="sudo apt autoremove -y && sudo apt clean -y && sudo rm -rf /var/lib/apt/lists/"
alias apttotal="aptvacuum && aptup && aptfull"
alias aptfixkeys="sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys "$key"; keys+=("$key"); fi; done"

function mcd {
  mkdir $@  && cd $_
}

alias gitpull="git pull --recurse-submodules --rebase --all"

alias home="cd && clear"

alias calibre_update="sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin"

alias ll="ls -lhaF"

alias docker-prune-all="docker system prune -a -f"

export EDITOR=vim

if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

export HISTCONTROL=ignoreboth:erasedups
