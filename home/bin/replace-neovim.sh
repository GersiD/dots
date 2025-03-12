#!/bin/bash
# Neovim nightly is installed via yay -S neovim-git
# Neovide also depends on neovim
# Every now and then I like to rebuild neovim on my system to ensure plugins have a clean env
# Goal: Remove noeovim and neovide and reinstall them
# Usage: replace-neovim.sh
echo "Removing neovim and neovide"
yay -R neovide --noconfirm
yay -R neovim --noconfirm
yay -R neovim-git neovim-git-debug --noconfirm
echo "Reinstalling neovim and neovide"
yay -S neovim-git --noconfirm
yay -S neovide --noconfirm
echo "Done"
