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
mkdir -p ~/Dropbox/Apps/Homebrew
cat /tmp/brew-sync.taps | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.taps
cat /tmp/brew-sync.installed | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.installed
cat /tmp/brew-sync.casks | sort | uniq > ~/Dropbox/Apps/Homebrew/brew-sync.casks

# Set taps
echo "Enabling taps ..."
for TAP in `cat ~/Dropbox/Apps/Homebrew/brew-sync.taps`; do
	$BREW tap ${TAP} >/dev/null
done

# Install missing Homebrew packages
echo "Install missing packages ..."
for PACKAGE in `cat ~/Dropbox/Apps/Homebrew/brew-sync.installed`; do
	$BREW list ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $BREW install ${PACKAGE}
done

echo "Install missing casks ..."
for CASK in `cat ~/Dropbox/Apps/Homebrew/brew-sync.casks`; do
	$BREW cask list -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && $BREW cask install ${CASK}
done


## iTerm2 sync from Dropbox
echo "Syncing iTerm2 settings from Dropbox..."
rm $HOME/Library/Preferences/com.googlecode.iterm2.plist
ln -s $HOME/Dropbox/Apps/iTerm2/com.googlecode.iterm2.plist /Users/Hatem/Library/Preferences

## MAMP PRO sync from Dropbox
echo "Syncing MAMP Pro settings from Dropbox..."
rm $HOME/Library/Preferences/de.appsolute.mamppro.plist
ln -s $HOME/Dropbox/Apps/MAMP/de.appsolute.mamppro.plist /Users/Hatem/Library/Preferences
# sync db folder
rm /Library/Application\ Support/appsolute/MAMP\ PRO/db
ln -s $HOME/Dropbox/Apps/MAMP/db/ /Library/Application\ Support/appsolute/MAMP\ PRO

## MAMP PRO sync from Dropbox
echo "Syncing Sketch settings from Dropbox..."
rm $HOME/Library/Preferences/com.bohemiancoding.sketch3.plist
ln -s $HOME/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist /Users/Hatem/Library/Preferences
# sync plugins folder
rm $HOME/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins
ln -s $HOME/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist /Users/Hatem/Library/Preferences

## Transmission sync from Dropbox
echo "Syncing Transmission settings from Dropbox..."
rm $HOME/Library/Preferences/org.m0k.transmission.plist
ln -s $HOME/Dropbox/Apps/Transmission/org.m0k.transmission.plist /Users/Hatem/Library/Preferences
