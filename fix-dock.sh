#!/bin/sh

# lock dock size
defaults write com.apple.Dock size-immutable -bool yes

# fix launchpad icon grid
defaults write com.apple.dock springboard-columns -int 8
defaults write com.apple.dock springboard-rows -int 7
defaults write com.apple.dock ResetLaunchPad -bool TRUE

# restart dock
killall Dock