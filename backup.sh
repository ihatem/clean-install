#!/bin/bash
echo "Copying files to Time Machine volume..."
cp -v -R ~/Desktop ~/Documents ~/Downloads ~/Movies ~/Music ~/Pictures ~/Work /Volumes/Time\ Machine
echo 
echo "Saving applications names to apps-list.txt..."
ls -1 /Applications | sed -e 's/\..*$//' > ~/Dropbox/Apps/apps-list.txt
echo 
echo "Saving NPM packages names to packages-list.txt..."
# list npm global packages | regex match only packages name | save into npm.txt
npm -g list --depth 0 | xp -o '([a-zA-Z@_/-]+)(?=@)' > ~/Dropbox/Apps/npm/packages-list.txt
echo 
echo "Bundle Brewfile..."
brew bundle dump
echo 
echo "Backup Brewfile to dropbox..."
cp -v ~/Brewfile ~/Dropbox/Apps/Homebrew/
echo 
echo "Backup .zshrc to dropbox..."
cp -v ~/.zshrc ~/Dropbox/Apps/zsh
echo 
echo "Backup .gitconfig to dropbox..."
cp -v ~/.gitconfig ~/Dropbox/Apps/git