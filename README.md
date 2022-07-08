# minimal setup
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

4. install dotfiles
```
cat configs/custom.zsh >> $HOME/.zshrc
cp configs/p10k.zsh $HOME/.p10k.zsh
```

5. turn off auto activation for conda
```
conda config --set auto_activate_base false
```

# zsh ricing
+ install p10k
```
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
```
+ install meslo nerd front
+ `p10k configure`
