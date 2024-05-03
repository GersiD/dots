fish_add_path ~/.cargo/bin
zoxide init fish | source
alias j=__zoxide_z
alias ji=__zoxide_zi
alias v=nvim
alias resetFish="source ~/.config/fish/config.fish"
alias update="sudo pacman -Syu && yay -Syu"
alias icat="kitten icat"
alias lg="lazygit"
alias ls="exa --icons"
alias l="exa --icons"
if test "$TERM" = "xterm-kitty"
  alias ssh="kitten ssh"
  alias mpra="kitten ssh gersi@mp-sys76.cs.unh.edu"
else
  alias ssh="ssh"
  alias mpra="ssh gersi@mp-sys76.cs.unh.edu"
end
export EDITOR=nvim
export NVIM_APPNAME="kick"
# export NVIM_APPNAME="nvim" # lazyvim


# https://starship.rs/
starship init fish | source

function fish_greeting
  fastfetch
end
set fish_greeting
