#!/bin/bash

## Sync Homebrew installations between Macs via Dropbox

BREW="/usr/local/bin/brew"

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
