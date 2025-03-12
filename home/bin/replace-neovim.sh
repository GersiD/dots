#!/bin/bash
# Neovim nightly is installed via yay -S neovim-git
# Neovide also depends on neovim
# Every now and then I like to rebuild neovim on my system to ensure plugins have a clean env
# Goal: Remove noeovim and neovide and reinstall them
# Usage: replace-neovim.sh
echo "Removing neovim and neovide"
yay -R neovide
yay -R neovim
yay -R neovim-git neovim-git-debug
echo "Reinstalling neovim and neovide"
yay -S neovim-git
yay -S neovide
echo "Done"
