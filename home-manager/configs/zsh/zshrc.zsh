# Use keychain to manage ssh keys
eval $(keychain -q --eval)

# Completion
autoload -U compinit 
compinit

# Completion options from zsh lovers
zstyle ':completion:*' menu select

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 

zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Host completion copied from grml
[[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(
	$(hostname)
	"$_ssh_config_hosts[@]"
	"$_ssh_hosts[@]"
	"$_etc_hosts[@]"
	localhost
       )

zstyle ':completion:*:hosts' hosts $hosts

# Glob settings
setopt extendedglob

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.history" 
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

# Set emacs mode
bindkey -e

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Control left/right for backward word/forward word
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Alt left/right for beginning-of-line/end-of-line
key[Alt-Left]="${terminfo[kLFT3]}"
key[Alt-Right]="${terminfo[kRIT3]}"

[[ -n "${key[Alt-Left]}"  ]] && bindkey -- "${key[Alt-Left]}"  beginning-of-line
[[ -n "${key[Alt-Right]}" ]] && bindkey -- "${key[Alt-Right]}" end-of-line

# Fish like history
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Rationalize dot (... -> ../..)
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}

# Automatically expand dots
zle -N rationalise-dot
bindkey . rationalise-dot

# Colored output in man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
# Edit current line with editor 
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

alias pag="ps aux | grep"
alias htop="btm -b"

# Useful docker commands
# Can also append --filter="ancestor=tdw:bp-1.4.5a" to ignore running container
das () {
  docker kill $(docker ps -q)
}

# Shell into docker container
dsh () {
  docker exec -i -t $1 /bin/bash
}

function _dsh(){
  containers=("${(@f)$(docker ps --format '{{.Names}}')}")
  compadd $containers
}

compdef _dsh dsh

em () {
  emacsclient $1 > /dev/null 2>&1 || emacs $1 &
}

gc-roots () {
	ls -l $(readlink /nix/var/nix/gcroots/auto/*)
} 

# FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Enable zoxide
eval "$(zoxide init zsh)"

# Set environmental variables
export EDITOR="nvim"

# Rust
export CARGO_HOME=$HOME/.local/cargo
export RUSTUP_HOME=$HOME/.local/rustup
export GOPATH=$HOME/.local/go

# List ec2 instance in default region
list-ec2 () {
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceType, State.Name, LaunchTime, PublicDnsName]' --output table
}

# vterm integration for emacs
vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}

setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

function _nix() {
  local ifs_bk="$IFS"
  local input=("${(Q)words[@]}")
  IFS=$'\n'
  local res=($(NIX_GET_COMPLETIONS=$((CURRENT - 1)) "$input[@]"))
  IFS="$ifs_bk"
  local tpe="${${res[1]}%%>	*}"
  local -a suggestions
  declare -a suggestions
  for suggestion in ${res:1}; do
    # FIXME: This doesn't work properly if the suggestion word contains a `:`
    # itself
    suggestions+="${suggestion/	/:}"
  done
  if [[ "$tpe" == filenames ]]; then
    compadd -f
  fi
  _describe 'nix' suggestions
}

compdef _nix nix
