fastfetch
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # git
    zsh-autosuggestions
    fzf-tab
)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# eval "$(jump shell)"
eval "$(~/.cargo/bin/zoxide init zsh --cmd j)"
autoload -U compinit && compinit -u
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

fzf_find_files ()
{
    # fd | fzf
    fd -H -t f | fzf --preview="batcat --color=always --style=numbers --line-range :500 {}" --bind="space:toggle-preview" --preview-window=:hidden
}

cd_with_fzf() {
    cd "$(fd -H -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

tmux_fzf() {
    if [ -z "$TMUX" ]; then
        # Check if main session is running
        if [ -z "$(tmux ls | grep main)" ]; then
            tmux new-session -s main
        else
            tmux attach-session -t main
        fi
    else
        tmux ls | fzf | cut -d: -f1 | xargs -I {} tmux switch-client -t {}
    fi
}

tmux_del_fzf() {
    tmux ls | fzf | cut -d: -f1 | xargs -I {} tmux kill-session -t {}
}

zle -N fzf_find_files
zle -N cd_with_fzf
zle -N tmux_fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '\C-f' fzf_find_files
bindkey '\C-k' cd_with_fzf
alias ftmux="tmux_fzf"
alias ktmux="tmux_del_fzf"
alias v="nvim"
alias resetZsh="source ~/.zshrc"
alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo snap refresh"
alias lemonade="/home/gd1064/go/bin/lemonade"
alias jrc="cd ~/grad_school/irl-non-homogeneous-trajectories/src/"
alias python="python3"
alias serve="python3 -m http.server 8080 &"
alias sKill="sudo killall python3"
alias t="tmux"
alias a="tmux attach-session -t"
alias ta="tmux attach-session -t TA"
alias ra="tmux attach-session -t RA"
alias icat="kitten icat"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export GUROBI_HOME=$HOME/gurobi1001/linux64
export PATH=$PATH:$HOME/gurobi1001/linux64/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/gurobi1001/linux64/lib
# export NVIM_APPNAME="nvim" # for lazy
export NVIM_APPNAME="kick" # for kickstart
# export HOME="/home/gd"
export XDG_CONFIG_HOME=$HOME/.config
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=info:#cba6f7,prompt:#cba6f7,hl+:#f38ba8,pointer:#f5e0dc \
--cycle"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
