fish_add_path ~/.cargo/bin
source ~/.config/fish/themes/tokyo_moon.fish
zoxide init fish | source
alias j=__zoxide_z
alias ji=__zoxide_zi
alias v=nvim
alias resetFish="source ~/.config/fish/config.fish"
alias update="sudo pacman -Syu && yay -Syu"
alias icat="kitten icat"
alias lg="git fetch &> /dev/null & lazygit"
alias ls="exa --icons"
alias l="exa --icons"
alias nv="neovide --fork; exit"
alias e="nohup nautilus &"
alias tt="tt -theme gruvbox -showwpm"
alias ttt="tt -theme \$(tt -list themes | fzf) -showwpm"
alias zz="zoxide edit"
alias todo="cd ~ && nvim ~/vaults/gersi_notes/todo.md && cd -"
alias reboot="killall chrome ; sudo reboot"
alias shutdown="killall chrome ; sudo shutdown now"
if test "$TERM" = xterm-kitty
    alias ssh="kitten ssh"
else
    alias ssh="ssh"
end
alias mpra="ssh gersi@mp-sys76.cs.unh.edu"
export EDITOR=nvim
export NVIM_APPNAME="kick"
# export NVIM_APPNAME="nvim" # lazyvim


# https://starship.rs/
starship init fish | source
starship completions fish | source

function fish_greeting
    fastfetch
end
set fish_greeting

function fzf_find_file
  fd -H -t f | fzf --preview="batcat --color=always --style=numbers --line-range :500 {}" --bind="space:toggle-preview" --preview-window=:hidden
end

function cd_fzf
  set -l dir (fd -t d | fzf)
  if test -n "$dir"
    cd $dir
  end
end

bind \cf 'fzf_find_file'
bind \ck 'cd_fzf'
