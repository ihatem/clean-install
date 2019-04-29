# Table of contents

1. [Backup](#backup)
	1. [Data](#data)
	2. [Configurations](#configurations)
	3. [Backup script](#backup-script)
2. [Restore](#restore)
	1. [Applications](#applications)
	2. [CLI](#cli)
	3. [Misc](#misc)
	4. [Restore script](#restore-script)
    
    
# Backup

## data

### Folders
> ~/Desktop 
> ~/Documents
> ~/Downloads 
> ~/Movies
> ~/Music
> ~/Pictures
> ~/Work

```bash
cp -v -R ~/Desktop ~/Documents ~/Downloads ~/Movies ~/Music ~/Pictures ~/Work /Volumes/Time\ Machine
```

### Installed applications list

```bash 
ls -1 /Applications | sed -e 's/\..*$//' > ~/Dropbox/Apps/apps-list.txt
```

### NPM Global packages

```bash 
# list npm global packages | regex match only packages name | save into npm.txt
npm -g list --depth 0 | xp -o '([a-zA-Z@_/-]+)(?=@)' > ~/Dropbox/Apps/npm/packages-list.txt
```

### brew packages
```bash 
brew bundle dump
cp ~/Brewfile ~/Dropbox/Apps/Homebrew/
```

## Configurations

### iTerm2
> Preferences > Profiles > Colors > Colors Presets > Export...
> ~/Dropbox/Apps/iTerm2/iterm2-dracula-pref.itermcolors

### zsh 
```bash 
cp ~/.zshrc ~/Dropbox/Apps/zsh
```

### git 
```bash 
cp ~/.gitconfig ~/Dropbox/Apps/git
```

### uBlock origin 
> Backup settings to ~/Dropbox/Apps/ublock/my-ublock-backup.txt

## Backup script 
backup.sh
```bash 
#!/bin/bash
echo  "Copying files to Time Machine volume..."
cp -v -R ~/Desktop ~/Documents ~/Downloads ~/Movies ~/Music ~/Pictures ~/Work /Volumes/Time\ Machine
echo
echo  "Saving applications names to apps-list.txt..."
ls -1 /Applications | sed -e 's/\..*$//'  >  ~/Dropbox/Apps/apps-list.txt
echo
echo  "Saving NPM packages names to packages-list.txt..."
# list npm global packages | regex match only packages name | save into npm.txt
npm -g list --depth 0 | xp -o '([a-zA-Z@_/-]+)(?=@)'  >  ~/Dropbox/Apps/npm/packages-list.txt
echo
echo  "Bundle Brewfile..."
brew bundle dump
echo
echo  "Backup Brewfile to dropbox..."
cp -v ~/Brewfile ~/Dropbox/Apps/Homebrew/
echo
echo  "Backup .zshrc to dropbox..."
cp -v ~/.zshrc ~/Dropbox/Apps/zsh
echo
echo  "Backup .gitconfig to dropbox..."
cp -v ~/.gitconfig ~/Dropbox/Apps/git
```
# Restore 

## Applications 

Manually install applications 
> ~/Dropbox/Apps/apps-list.txt

### Finder 
Show Path Bar
> view > show path bar

### iTerm2 
```bash 
# delete default settings and sync from dropbox
sudo rm ~/Library/Preferences/com.googlecode.iterm2.plist
sudo ln -s ~/Dropbox/Apps/iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences
```

### Spectacles 
```bash 
# delete default settings and sync from dropbox
sudo rm ~/Library/Application\ Support/Spectacle/Shortcuts.json
sudo ln -s ~/Dropbox/Apps/Spectacle/Shortcuts.json ~/Library/Application\ Support/Spectacle/
```

### Sketch 
```bash 
# delete default settings and sync from dropbox
sudo rm ~/Library/Preferences/com.bohemiancoding.sketch3.plist
sudo ln -s ~/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist ~/Library/Preferences
# delete default plugins folder and sync from dropbox
sudo rm -r ~/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins
sudo ln -s ~/Dropbox/Apps/sketch/Plugins ~/Library/Application\ Support/com.bohemiancoding.sketch3
```

### Transmission 
```bash 
# delete default settings and sync from dropbox
sudo rm ~/Library/Preferences/org.m0k.transmission.plist
sudo ln -s ~/Dropbox/Apps/Transmission/org.m0k.transmission.plist ~/Library/Preferences
```

### uBlock origin 
> Restore saved settings from ~/Dropbox/Apps/ublock/my-ublock-backup.txt


## CLI

### Finder 
```bash 
# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
```


### iTerm2 

```bash
# restore zsh settings
cp ~/Dropbox/Apps/zsh/.zshrc ~
```

```bash
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

```bash
# install bullet train theme
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -P $ZSH_CUSTOM/themes/
```

> Preferences > Profiles > Colors > Colors Presets > Import...
> ~/Dropbox/Apps/iTerm2/iterm2-dracula-pref.itermcolors


### brew

```bash
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# restore brew packages
cp ~/Dropbox/Apps/Homebrew/ ~
brew bundle
```

### git 

```bash
# restore git settings
cp ~/Dropbox/Apps/git/.gitconfig ~
```

### npm 
[Resolving EACCES permissions errors when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)
```bash 
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
```
```bash 
# Install missing npm global packages
echo  "Install missing packages ..."
for  PACKAGE  in  `cat ~/Dropbox/Apps/npm/packages-list.txt`;  do
	npm install -g ${PACKAGE}
done
```


## Misc 

### [Unifed hosts file](https://github.com/drduh/macOS-Security-and-Privacy-Guide#hosts-file)
```bash 
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts
```

### [Destroy and rebuild Fusion drive](https://lokan.jp/2015/10/23/comment-creer-casser-fusion-drive/)

### [Change DNS](https://lokan.jp/2017/01/06/important-changer-dns/)

## Restore script 
restore.sh
```bash 
#!/bin/bash
# delete default settings and sync from dropbox
echo  "delete default settings and sync from dropbox..."
echo
echo  "Sync settings for iTerm2..."
## iTerm2
sudo rm ~/Library/Preferences/com.googlecode.iterm2.plist
sudo ln -s ~/Dropbox/Apps/iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences
echo
echo  "Sync settings for Spectacle..."
## Spectacle
sudo rm ~/Library/Application\ Support/Spectacle/Shortcuts.json
sudo ln -s ~/Dropbox/Apps/Spectacle/Shortcuts.json ~/Library/Application\ Support/Spectacle/
echo
echo  "Sync settings for Sketch..."
## Sketch
sudo rm ~/Library/Preferences/com.bohemiancoding.sketch3.plist
sudo ln -s ~/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist ~/Library/Preferences
echo
echo  "Sync plugins folder for Sketch..."
## Sketch Plugins
sudo rm -r ~/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins
sudo ln -s ~/Dropbox/Apps/sketch/Plugins ~/Library/Application\ Support/com.bohemiancoding.sketch3
echo
echo  "Sync settings for Transmission..."
## Transmission
sudo rm ~/Library/Preferences/org.m0k.transmission.plist
sudo ln -s ~/Dropbox/Apps/Transmission/org.m0k.transmission.plist ~/Library/Preferences
echo
echo  "Show hidden files..."
# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
echo
echo  "Install oh-my-zsh..."
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo
echo  "Restore .zshrc file..."
# restore zsh settings
cp -v ~/Dropbox/Apps/zsh/.zshrc ~
echo
echo  "Install bullet train theme for oh-my-zsh..."
# install bullet train theme
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -P $ZSH_CUSTOM/themes/
echo
echo  "Restore .gitconfig file..."
# restore git settings
cp -v ~/Dropbox/Apps/git/.gitconfig ~
echo
echo  "Install Homebrew..."
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo
echo  "Restore Homebrew Brewfile..."
# restore brew packages
cp -v ~/Dropbox/Apps/Homebrew/Brewfile ~
brew bundle
echo
echo  "Resolving EACCES permissions errors for NPM..."
# Resolving EACCES permissions errors when installing packages globally
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo
echo  "Install missing NPM packages..."
# Install missing npm global packages
for  PACKAGE  in  `cat ~/Dropbox/Apps/npm/packages-list.txt`;  do
	npm install -g ${PACKAGE}
done;
echo
echo  "Download and tee hosts file..."
# Unifed hosts file
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts
exit;
```
