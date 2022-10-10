# Table of contents

1. [Backup](#backup)
	1. [Data](#data)
	2. [Configurations](#configurations)
2. [Restore](#restore)
	1. [Applications](#applications)
	2. [CLI](#cli)
	3. [Misc](#misc) 
3. [Scripts](#scripts)
    
    
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

### npm Global packages

```bash 
# list npm global packages | regex match only packages name | save into npm.txt
npm -g list --depth 0 | xp -o '([a-zA-Z@_/-]+)(?=@)' > ~/Dropbox/Apps/npm/npm-packages-list.txt
```

### Yarn Global packages

```bash 
cp $(yarn global dir)/package.json ~/Dropbox/Apps/npm/ && mv ~/Dropbox/Apps/npm/package.json ~/Dropbox/Apps/npm/yarn-package.json
```

### brew packages
```bash 
brew bundle dump
cp ~/Brewfile ~/Dropbox/Apps/Homebrew/
```

### Thunderbird 
> 1. Connect a device for data transfer, either a local one such as a USB flash drive, or a remote storage drive.
> 2. Open the Help menu and select Troubleshooting Information.
> 3. Locate the "Profile Folder" entry, then click Show in Finder.
> Your Thunderbird profile folder will open in Finder.
> 5. Quit Thunderbird.
> 6. From your Thunderbird profile folder in Finder, open the Go menu and select Enclosing Folder two times.
> 7. Hold down the control key while you click on the Thunderbird folder and select Copy "Thunderbird".
> 8. Hold down the control key while you click the device you are using to transfer your data, then select Paste Item.
> 9. If you are using a local transfer device, remove it safely from the source computer.

Source: https://support.mozilla.org/en-US/kb/moving-thunderbird-data-to-a-new-computer

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

### Tunnelblick 
>Export all configurations and settings on a computer by clicking the "Export Tunnelblick Setup" on the "Utilities" panel of Tunnelblick's "VPN Details" window.
>
>Important: Saved usernames and passwords are not exported.
>
>Tunnelblick will create a compressed ".tar.gz" file on your Desktop named "Tunnelblick Setup" followed by the date and time. The file can be expanded into a Tunnelblick Setup file (with ".tar.gz" changed to ".tblkSetup") by double-clicking it. (A compressed file is created because it is much smaller than the uncompressed version.)
>
>Source: https://tunnelblick.net/cExportingAndImportingTunnelblickSetups.html

Plus, export username and password from Keychain

### Carbon Copy Cleaner
> If you wish to migrate your tasks from CCC on one system to CCC on another system, follow these steps:
>
> Choose Export All Tasks from CCC's Task menu.
> Specify a name for the exported settings file and a location where to save it.
> Transfer the exported settings file to another Mac.
> Install CCC onto the other Mac
> Double-click the exported settings file.
> As prompted, review the task settings and reset the source/destination selections as necessary.

Source: https://bombich.com/kb/ccc6/migrating-ccc-tasks-from-one-system-another


# Restore 

## Reinstall macOs

### Create bootable usb 

```bash 
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/UNTITLED && echo Mojave Drive Created
```

### Format disk and create coreStorage container (Fusion Drive)

> Format Disk
```bash 
diskutil list
```
if coreStorage exists : 
```bash 
diskutil coreStorage delete lvgUUID
```
```bash 
diskutil list
```
```bash 
diskutil coreStorage create "Fusion Drive" /dev/disk0 /dev/disk1
```
```bash 
diskutil coreStorage createVolume lvgUUID jhfs+ "Macintosh" 100%
```



```bash 
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/UNTITLED && echo Mojave Drive Created
```


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

### Cyberduck
```
ln -s /Users/hatem/Library/CloudStorage/Dropbox/Apps/cyberduck/Transfers /Users/hatem/Library/Group\ Containers/G69SCX94XU.duck/Library/Application\ Support/duck/Transfers
ln -s /Users/hatem/Library/CloudStorage/Dropbox/Apps/cyberduck/Sessions /Users/hatem/Library/Group\ Containers/G69SCX94XU.duck/Library/Application\ Support/duck/Sessions
ln -s /Users/hatem/Library/CloudStorage/Dropbox/Apps/cyberduck/History /Users/hatem/Library/Group\ Containers/G69SCX94XU.duck/Library/Application\ Support/duck/History
ln -s /Users/hatem/Library/CloudStorage/Dropbox/Apps/cyberduck/Bookmarks /Users/hatem/Library/Group\ Containers/G69SCX94XU.duck/Library/Application\ Support/duck/Bookmarks
```
Source: https://docs.cyberduck.io/cyberduck/faq/#preferences-and-application-support-files-location

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

### Command line tools 
```bash 
xcode-select --install
```

### Finder 
```bash 
# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# remove hidding dock animation delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4; killall Dock
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
install npm global packages
```bash 
echo "Giving access to npm..."
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config
echo "Install npm global packages ..."
cat ~/Dropbox/Apps/npm/npm-packages-list.txt | xargs npm install -g
```

### yarn 
```bash 
npx yarn-global-restore ~/Dropbox/Apps/npm/yarn-package.json --keep-versions
```


## Misc 

### [Unifed hosts file](https://github.com/drduh/macOS-Security-and-Privacy-Guide#hosts-file)
```bash 
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts
```

### [Destroy and rebuild Fusion drive](https://lokan.jp/2015/10/23/comment-creer-casser-fusion-drive/)

### [Change DNS](https://lokan.jp/2017/01/06/important-changer-dns/)

# Scripts 
## [Backup Script](https://github.com/ihatem/clean-install/blob/master/backup.sh)
## [Restore Script](https://github.com/ihatem/clean-install/blob/master/restore.sh)
