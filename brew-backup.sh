#!/bin/bash

## Sync Homebrew installations between Macs via Dropbox

BREW="/usr/local/bin/brew"

# first get local settings
echo "Reading local settings ..."
rm -f /tmp/brew-sync.*
$BREW tap > /tmp/brew-sync.taps
$BREW list > /tmp/brew-sync.installed
$BREW cask list -1 > /tmp/brew-sync.casks

# then combine it with list in Dropbox
echo "Reading settings from Dropbox ..."
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.taps ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.taps >> /tmp/brew-sync.taps
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.installed ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.installed >> /tmp/brew-sync.installed
[ -e ~/Dropbox/Apps/Homebrew/brew-sync.casks ] && cat ~/Dropbox/Apps/Homebrew/brew-sync.casks >> /tmp/brew-sync.casks

# make the lists unique and sync into Dropbox
echo "Syncing to Dropbox ..."
sudo mkdir -p ~/Dropbox/Apps/Homebrew
sudo cat /tmp/brew-sync.taps | sort | sudo uniq > ~/Dropbox/Apps/Homebrew/brew-sync.taps
sudo cat /tmp/brew-sync.installed | sort | sudo uniq > ~/Dropbox/Apps/Homebrew/brew-sync.installed
sudo cat /tmp/brew-sync.casks | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.casks
