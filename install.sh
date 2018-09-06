#!/bin/bash

ensureHomebrew() {
	echo "Ensure homebrew..."
	if ! command -v brew > /dev/null; then
		echo "Installing homebrew..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	echo "Homebrew was installed."
	echo "----------"
	echo
}

ensureHomebrewBundles() {
	brew bundle check
	rc=$?; if [[ $rc != 0 ]]; then
		echo "Installing homebrew bundles..."
		brew bundle install
	fi
	echo "All homebrew bundles were installed."
	echo "----------"
	echo
}

ensureNeovimConfig() {
	if [ -d ~/.config/nvim ]; then
		echo "Mkdir ~/.config/nvim"
		mkdir -p ~/.config/nvim
	fi
	echo "Updating neovim config..."
	cat ./nvim/init.vim > ~/.config/init.vim
	echo "----------"
	echo
}

ensureHomebrew
ensureHomebrewBundles
ensureNeovimConfig

echo "All done!"
