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
	echo "Checking homebrew bundles..."
	brew bundle check
	rc=$?; if [[ $rc != 0 ]]; then
		echo "Installing homebrew bundles..."
		brew bundle install
	fi
	echo "All homebrew bundles were installed."
	echo "----------"
	echo

	echo "Installing pure prompt..."
	npm install --global pure-prompt
	echo "----------"
	echo
}

ensureNeovimConfig() {
	echo "Updating neovim config..."
	mkdir -p ~/.config/nvim
	cat ./nvim/init.vim > ~/.config/nvim/init.vim
	echo "----------"
	echo
}

ensureFish() {
	echo "Installing fisher..."
	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
	cat fish/config.fish > ~/.config/fish/config.fish
	cat fish/fishfile > ~/.config/fish/fishfile
	echo "Don't forget to run 'fisher' to install fish plugins"
	echo "----------"
	echo
}

ensureHomebrew
ensureHomebrewBundles
ensureNeovimConfig
ensureFish

echo "All done!"
