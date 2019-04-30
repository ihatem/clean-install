#!/bin/bash

# install command line tools
echo 
echo "Install command line tools..." 
xcode-select --install

# vs code restore
echo 
echo "Install Homebrew..."
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 
echo "Restore Homebrew Brewfile..."
# restore brew packages
cp -v ~/Dropbox/Apps/Homebrew/Brewfile ~
brew bundle

# delete default settings and sync from dropbox
echo 
echo "delete default settings and sync from dropbox..."
echo 
echo "Sync settings for iTerm2..."
## iTerm2
sudo rm ~/Library/Preferences/com.googlecode.iterm2.plist
sudo ln -s ~/Dropbox/Apps/iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences

echo 
echo "Sync settings for Spectacle..."
## Spectacle
sudo rm ~/Library/Application\ Support/Spectacle/Shortcuts.json
sudo ln -s ~/Dropbox/Apps/Spectacle/Shortcuts.json ~/Library/Application\ Support/Spectacle/

echo 
echo "Sync settings for Sketch..."
## Sketch
sudo rm ~/Library/Preferences/com.bohemiancoding.sketch3.plist
sudo ln -s ~/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist ~/Library/Preferences

echo 
echo "Sync plugins folder for Sketch..."
## Sketch Plugins
sudo rm -r ~/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins
sudo ln -s ~/Dropbox/Apps/sketch/Plugins ~/Library/Application\ Support/com.bohemiancoding.sketch3

echo 
echo "Sync settings for Transmission..."
## Transmission
sudo rm ~/Library/Preferences/org.m0k.transmission.plist
sudo ln -s ~/Dropbox/Apps/Transmission/org.m0k.transmission.plist ~/Library/Preferences

echo 
echo "Show hidden files..."
# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

echo 
echo "Install oh-my-zsh..."
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 
echo "Restore .zshrc file..."
# restore zsh settings
cp -v ~/Dropbox/Apps/zsh/.zshrc ~

echo 
echo "Install bullet train theme for oh-my-zsh..."
# install bullet train theme
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -P $ZSH_CUSTOM/themes/

echo 
echo "Install zsh plugins..."
# install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo 
echo "Restore .gitconfig file..."
# restore git settings
cp -v ~/Dropbox/Apps/git/.gitconfig ~

# install npm global packages
echo
echo "Giving access to npm..."
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config
echo
echo "Install npm global packages ..."
cat ~/Dropbox/Apps/npm/packages-list.txt | xargs npm install -g

echo 
echo "Download and tee hosts file..."
# Unifed hosts file
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts
exit;

