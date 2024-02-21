# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gd1064/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gd1064/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gd1064/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/gd1064/.fzf/shell/key-bindings.zsh"
