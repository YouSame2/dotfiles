#!/bin/bash

# insert additional commands to run at the end of bootstrapping below.

# Global extras:

# TODO: add check if the thing is installed

ya pack -a yazi-rs/plugins:git
# uv tool install --with google-generativeai --force --python python3.12 'aider-chat@latest' # installs aider
# uv tool install ra-aid # like aider

# Check OS
OS=$(uname -o)

# windows part
if [[ "$OS" =~ Cygwin|Msys|MinGW ]]; then

  # $EDITOR=nvim
  [[ -z "${EDITOR}" ]] &&
    powershell.exe -Command "[System.Environment]::SetEnvironmentVariable('EDITOR', 'nvim', 'User')" &&
    echo 'set EDITOR as nvim...' ||
    echo '$EDITOR already set...'

  # winget part: winget is werid on windows so just put it here
  echo 'installing/upgrading eza' && winget install eza-community.eza
  echo 'installing/upgrading yazi' && winget install sxyazi.yazi

# mac part
elif [[ "$OS" = Darwin ]]; then
  # TODO: add windows part of this
  sudo curl -sSL https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/git-jump/git-jump -o /usr/local/bin/git-jump && sudo chmod +x /usr/local/bin/git-jump
fi
