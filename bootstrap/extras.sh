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
  command -v eza >/dev/null || {
    echo 'installing eza...'
    winget install eza-community.eza
  }
  command -v yazi >/dev/null || {
    echo 'installing yazi...'
    winget install sxyazi.yazi
  }
  command -v uv >/dev/null || {
    echo 'installing uv...'
    winget install --id=astral-sh.uv -e
  }
  command -v aider >/dev/null || {
    echo 'installing aider...'
    uv tool install --force --python python3.12 --with google-generativeai aider-chat@latest
  }

# mac part
# elif [[ "$OS" = Darwin ]]; then
fi
