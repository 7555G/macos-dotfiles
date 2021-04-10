#
# ~/.bash_profile
#

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# instantly append to history every command
export PROMPT_COMMAND="history -a"

# check if this is a ssh session
if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
  SESSION_TYPE="remote_ssh"
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE="remote_ssh";;
  esac
fi

# custom prompt
if [ -f ~/.bash_prompt ]; then
   source ~/.bash_prompt
fi

# use homebrew bash
export SHELL="/opt/homebrew/bin/bash"

# set the locale to English
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# use gcc instead of gcc
export CC=gcc
export CXX=g++

# local ip shortcuts
export imac="192.168.1.2"
export npower_pi="npower@192.168.1.20"

# gtest environment
export CPLUS_INCLUDE_PATH="/usr/local/include"
export LIBRARY_PATH="/usr/local/lib"

# homebrew path
eval "$(/opt/homebrew/bin/brew shellenv)"

# append extra paths from file
eval $(~/.dotfiles/bin/append_paths ~/.dotfiles/extra_paths.txt)

# aliases
export TRASH="${HOME}/.Trash"
if [ -f ~/.bash_aliases ]; then
   source ~/.bash_aliases
fi
