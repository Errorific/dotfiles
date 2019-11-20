if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . /home/chris/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -s "$HOME/.cabal/bin" ]; then PATH=$HOME/.cabal/bin:$PATH; fi
