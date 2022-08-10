EDITOR=lvim
eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"



if [ -s "$HOME/.foreman/bin" ]; then PATH="$HOME/.foreman/bin:$PATH"; fi

if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
  # Load nvm if it exists in $NVM_DIR
  source "$HOME/.nvm/nvm.sh --no-use"}
fi


# Added by Toolbox App
export PATH="$PATH:/Users/chris/Library/Application Support/JetBrains/Toolbox/scripts"