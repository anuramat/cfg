#!/usr/bin/env bash

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# enable powerlevel10k
echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ~/.zshrc
