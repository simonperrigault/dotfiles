#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/blesh/ble.sh --noattach

HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize

# --- 3. Colored Man Pages ---
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -la'
alias vi=nvim
alias sshp='ssh perrigault'
alias lg='lazygit'
alias gst='git status'

PS1='[\u@\h \W]\$ '

bind "set completion-ignore-case on"

export VISUAL='nvim'
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

source /usr/share/bash-completion/bash_completion

eval "$(zoxide init bash)"
eval "$(starship init bash)"

if [[ ${BLE_VERSION-} ]]; then
  ble-import -d integration/fzf-completion
  ble-import -d integration/fzf-key-bindings
  ble-attach
fi 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
