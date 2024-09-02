#Author : Kaleb Redman (https://github.com/kalebr3)
#Upstream Author : Heapbytes <Gourav> (https://github.com/heapbytes)

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

get_pwd() {
  echo "%F{blue}${vcs_info_msg_0_%%/.}%f"
}

get_ip_address() {
  if [[ -n "$(networksetup -getinfo Wi-Fi | grep 'Subnet mask: ')" ]]; then
    echo "%{$fg[green]%}$(ifconfig en0 | awk '/inet / {print $2}')%{$reset_color%}"
  else
    echo "%{$fg[red]%}No IP%{$reset_color%}"
  fi
}

precmd() {
  setopt localoptions nopromptsubst
  vcs_info
}

PROMPT='
┌─[%F{blue}$(get_pwd)%f] [%F{green}$(get_ip_address)%f] $(git_prompt_info)
└─➜ '

RPROMPT='[%F{red}%?%f]'
