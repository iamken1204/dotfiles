# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/kettan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git golang docker kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function t() {
	tree -I '.git|node_modules|vendor|.DS_Store' --dirsfirst --filelimit 100 -L ${1:-3} -aC $2
}

##### Go #####
export GOPATH=/Users/kettan/go
export PATH=$PATH:$GOPATH/bin

##### VIM #####
alias v='nvim .'
# Ctrl+s is captured by iTerm2 by default, 'ssty -ixon' disable it, so vim can receive Ctrl+s
# https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
stty -ixon 

##### pure shell prompt #####
# @see https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure

# Highlight command if it was an existed command.
# This line should be sourced at the end of .zshrc.
# @see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export TERM='xterm-256color'
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
				# export TERM='xterm-256color'
# else
				# export TERM='xterm-color'
# fi

# source for running rustup
# source $HOME/.cargo/env

vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     nvim $file
  fi
}

# z - the directory jumper
# https://github.com/rupa/z
# brew install z
. /usr/local/etc/profile.d/z.sh
