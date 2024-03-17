# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gd/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gd/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gd/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/gd/.fzf/shell/key-bindings.zsh"
