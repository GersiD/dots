# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gersi/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gersi/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gersi/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/gersi/.fzf/shell/key-bindings.zsh"
