# minimal setup
### TODO move dump from brew, add `init.vim` and `.p10k.zsh` to dumpables
### (maybe `custom` too)
### TODO put in a script, test through docker or smth

0. run `mac_misc.sh`

1. install xcode cli tools
```
xcode-select —-install
```

2. install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. install brew packages (don't forget to conda init)

4. install vim-plug

5. install dotfiles
```
cat configs/custom.zsh >> $HOME/.zshrc
cp configs/p10k.zsh $HOME/.p10k.zsh
cp configs/init.vim $HOME/.config/nvim/init.vim
```

6. turn off auto activation for conda
```
conda config --set auto_activate_base false
```

# shell ricing
+ install p10k
```
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
```
+ install font from nerdfonts.com
