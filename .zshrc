# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
  OMZ::plugins/common-aliases/common-aliases.plugin.zsh \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh \
  OMZ::plugins/tmux/tmux.plugin.zsh

zplugin ice wait lucid blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit
