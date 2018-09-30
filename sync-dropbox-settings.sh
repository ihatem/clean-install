#!/bin/bash

## iTerm2 sync from Dropbox
echo "Syncing iTerm2 settings from Dropbox..."
sudo rm $HOME/Library/Preferences/com.googlecode.iterm2.plist
sudo ln -s $HOME/Dropbox/Apps/iTerm2/com.googlecode.iterm2.plist $HOME/Library/Preferences

## MAMP PRO sync from Dropbox
echo "Syncing MAMP Pro settings from Dropbox..."
sudo rm $HOME/Library/Preferences/de.appsolute.mamppro.plist
sudo ln -s $HOME/Dropbox/Apps/MAMP/de.appsolute.mamppro.plist $HOME/Library/Preferences
# sync db folder
sudo rm -r /Library/Application\ Support/appsolute/MAMP\ PRO/db
sudo ln -s $HOME/Dropbox/Apps/MAMP/db/ /Library/Application\ Support/appsolute/MAMP\ PRO

## MAMP PRO sync from Dropbox
echo "Syncing Sketch settings from Dropbox..."
sudo rm $HOME/Library/Preferences/com.bohemiancoding.sketch3.plist
sudo ln -s $HOME/Dropbox/Apps/Sketch/com.bohemiancoding.sketch3.plist $HOME/Library/Preferences
# sync plugins folder
sudo rm -r $HOME/Library/Application\ Support/com.bohemiancoding.sketch3/Plugins
sudo ln -s $HOME/Dropbox/Apps/sketch/Plugins $HOME/Library/Application\ Support/com.bohemiancoding.sketch3

## Transmission sync from Dropbox
echo "Syncing Transmission settings from Dropbox..."
sudo rm $HOME/Library/Preferences/org.m0k.transmission.plist
sudo ln -s $HOME/Dropbox/Apps/Transmission/org.m0k.transmission.plist $HOME/Library/Preferences

## Amphetamine sync from Dropbox
echo "Syncing Transmission settings from Dropbox..."
sudo rm $HOME/Library/Preferences/com.if.Amphetamine.plist
sudo ln -s $HOME/Dropbox/Apps/Transmission/com.if.Amphetamine.plist $HOME/Library/Preferences
