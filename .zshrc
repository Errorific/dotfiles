# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DISABLE_AUTO_TITLE=true

# install zplugin
if [[ ! -d ~/.zplugin/bin ]];then
    mkdir ~/.zplugin
    git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

source ~/.zplugin/bin/zplugin.zsh

setopt auto_cd

zplugin ice depth=1; zplugin light romkatv/powerlevel10k

zplugin snippet OMZ::lib/completion.zsh
zplugin snippet OMZ::lib/directories.zsh
zplugin snippet OMZ::lib/history.zsh
zplugin snippet OMZ::lib/key-bindings.zsh

zplugin wait lucid for \
  OMZ::plugins/brew/brew.plugin.zsh \
  OMZ::plugins/common-aliases/common-aliases.plugin.zsh \
  OMZ::plugins/dotenv/dotenv.plugin.zsh \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh \
  OMZ::plugins/tmux/tmux.plugin.zsh

zplugin ice wait lucid blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-syntax-highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if command -v thefuck &> /dev/null; then eval $(thefuck --alias); fi

autoload -Uz compinit
compinit

export PYENV_ROOT="$HOME/.pyenv"
if [ -s $PYENV_ROOT ]; then PATH="$PYENV_ROOT/bin:$PATH"; fi
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init --path)"; fi
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv virtualenv-init -)"; fi

if [ -s "$HOME/.foreman/bin" ]; then PATH="$HOME/.foreman/bin:$PATH"; fi

alias gcd='git checkout development'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
