typeset -U path
path=(
      $HOME/.nix-profile/bin
      $path
    )


# Colorize terminal
eval $( dircolors -b $HOME/.config/dircolors )

conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda "$@"
}

# Prompt aliases
alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"
alias l="ls --color=auto"

snvim() {
      /usr/local/bin/nvim -u ~/.config/nvim/init_test.lua $@
}

home-upgrade () {
  nix flake update /home/mjlbach/Repositories/nix/nix-dotfiles/home-manager
  home-manager switch --flake "/home/mjlbach/Repositories/nix/nix-dotfiles/home-manager#wsl"
  # (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  home-manager switch --flake "/home/mjlbach/Repositories/nix/nix-dotfiles/home-manager#wsl"
}

