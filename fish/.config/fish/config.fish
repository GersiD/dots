fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/gem/ruby/3.2.0/bin
source ~/.config/fish/themes/tokyo_moon.fish &
# cat ~/.cache/wal/sequences & # If you want to use wal colors
zoxide init fish --cmd j | source
alias v=nvim
alias resetFish="source ~/.config/fish/config.fish"
alias update="sudo pacman -Syu && yay -Syu"
alias cat="bat --style=full"
alias icat="kitten icat"
alias lg="git fetch &> /dev/null & lazygit"
alias ls="exa --icons"
alias l="exa --icons"
alias nv="neovide --fork; exit"
alias e="nautilus . &"
alias tt="tt -theme gruvbox -showwpm"
alias ttt="tt -theme \$(tt -list themes | fzf) -showwpm"
alias zz="zoxide edit"
alias todo="cd ~ && nvim ~/vaults/gersi_notes/todo.md && cd -"
alias reboot="killall chrome ; sleep 2; sudo reboot"
alias logout="killall chrome ; sleep 2 ; loginctl kill-session $XDG_SESSION_ID"
alias shutdown="killall chrome ; sudo shutdown now"
alias headphones="bash ~/bin/audio.sh 'WH-1000XM5'"
alias speaker="bash ~/bin/audio.sh 'GP102 HDMI Audio Controller Digital'"
alias y="yazi"
alias notes="tmux new-session -A -s notes -c ~/vaults/gersi_notes/"
alias kick="tmux new-session -A -s kick -c ~/dots/kick/.config/kick/"
alias work="tmux new-session -A -s work"
alias serve="source ~/deploy_website.sh"
alias fix="systemctl --user restart wireplumber pipewire pipewire-pulse; alsactl init"
alias boston="mullvad disconnect -w; mullvad relay set location us bos; mullvad connect -w; mullvad status"
alias ukraine="mullvad disconnect -w; mullvad relay set location ua; mullvad connect -w; mullvad status"
alias setup-julia="bash ~/bin/setup-julia.sh"
if test "$TERM" = xterm-kitty
    alias ssh="kitten ssh"
else
    alias ssh="ssh"
end
alias mpra="waypipe -n --threads 4 ssh gersi@mp-sys76.cs.unh.edu"
export EDITOR=nvim
export NVIM_APPNAME="kick"
# export NVIM_APPNAME="nvim" # lazyvim
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"

# https://starship.rs/
starship init fish | source
starship completions fish | source

# fifc config
# fisher install gazorby/fifc # fifc fzf completions for fish https://github.com/gazorby/fifc
set -Ux fifc_editor nvim

function fish_greeting
    fastfetch --logo mac
end
set fish_greeting

function fzf_find_file
    fd -H -t f | fzf --preview="bat --color=always --style=numbers --line-range :500 {}" --bind="space:toggle-preview" |
    wl-copy
end

function cd_fzf
    set -l dir (fd -t d | fzf)
    if test -n "$dir"
        cd $dir
    end
end

function enter_venv --on-event fish_prompt
    if test -d venv
        if status --is-interactive
            source venv/bin/activate.fish
        end
    else
        if test -n "$VIRTUAL_ENV"
            deactivate
        end
    end
end

bind \cf fzf_find_file
bind \ck cd_fzf
set -U fish_user_paths $HOME/bin $fish_user_paths
