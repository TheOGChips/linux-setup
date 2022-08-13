#!/bin/zsh

ZSHRC="$HOME"/.zshrc
ZPROFILE="$HOME"/.zprofile
ZSHENV="$HOME"/.zshenv
ZKBD="$HOME"/.zkbd
ALIASES="$HOME"/.zsh_aliases

autoload -Uz zsh-newuser-install
zsh-newuser-install # This should run the Z shell new user script, but will only create .zshrc
autoload -Uz zkbd
zkbd

# .zshrc
echo >> "$ZSHRC"
echo "source $ZPROFILE" >> "$ZSHRC"
echo "source $ALIASES" >> "$ZSHRC"
echo >> "$ZSHRC"
## Fix keybindings for Home, End, Insert, and Delete keys using zkbd
echo 'source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}' >> "$ZSHRC"
echo 'if [ -n "${key[Home]}" ]' >> "$ZSHRC"
echo '    then' >> "$ZSHRC"
echo '    bindkey -M viins "${key[Home]}" beginning-of-line' >> "$ZSHRC"
echo '    bindkey -M vicmd "${key[Home]}" beginning-of-line' >> "$ZSHRC"
echo 'fi' >> "$ZSHRC"
echo >> "$ZSHRC"
echo 'if [ -n "${key[End]}" ]' >> "$ZSHRC"
echo '    then' >> "$ZSHRC"
echo '    bindkey -M viins "${key[End]}" end-of-line' >> "$ZSHRC"
echo '    bindkey -M vicmd "${key[End]}" end-of-line' >> "$ZSHRC"
echo 'fi' >> "$ZSHRC"
echo >> "$ZSHRC"
echo 'if [ -n "${key[Delete]}" ]' >> "$ZSHRC"
echo '    then' >> "$ZSHRC"
echo '    bindkey -M viins "${key[Delete]}" delete-char' >> "$ZSHRC"
echo '    bindkey -M vicmd "${key[Delete]}" delete-char' >> "$ZSHRC"
echo 'fi' >> "$ZSHRC"
echo >> "$ZSHRC"
echo 'if [ -n "${key[Insert]}" ]' >> "$ZSHRC"
echo '    then' >> "$ZSHRC"
echo '    bindkey -M viins "${key[Insert]}" vi-cmd-mode' >> "$ZSHRC"    # only because setting to undefined-key doesn't seem to do anything
echo '    bindkey -M vicmd "${key[Insert]}" vi-insert' >> "$ZSHRC"
echo 'fi' >> "$ZSHRC"
echo >> "$ZSHRC"
echo 'eval $(thefuck --alias)' >> "$ZSHRC"

# .zprofile
echo 'BF="%B%F"' >> "$ZPROFILE"
echo 'bf="%f%b"' >> "$ZPROFILE"
echo 'export PS1="[ $BF{green}%n$bf$BF{yellow}@$bf$BF{magenta}%m$bf: $BF{blue}%~ $bf] $ "' >> "$ZPROFILE"
#echo 'export HISTCONTROL=ignoreboth:erasedups' >> "$ZPROFILE"

# .zshenv
echo 'if [ -d /opt/local/sbin ]' >> "$ZSHENV"
echo '    then' >> "$ZSHENV"
echo '    export PATH="/opt/local/sbin:$PATH"' >> "$ZSHENV"
echo 'fi' >> "$ZSHENV"
echo >> "$ZSHENV"
echo 'if [ -d /opt/local/bin ]' >> "$ZSHENV"
echo '    then' >> "$ZSHENV"
echo '    export PATH="/opt/local/bin:$PATH"' >> "$ZSHENV"
echo 'fi' >> "$ZSHENV"
echo >> "$ZSHENV"
echo 'if [ -d "$HOME"/.local/bin ]' >> "$ZSHENV"
echo '    then' >> "$ZSHENV"
echo '    export PATH="$HOME/.local/bin:$PATH"' >> "$ZSHENV"
echo 'fi' >> "$ZSHENV"
echo >> "$ZSHENV"

# .zkbd
# This assumes the file xterm-256color-:0.0 is being copied to xterm-256color-:0
norm_zkbd="$(ls -1 $ZKBD)"
#vscodium_zkbd="$(ls -1 $ZKBD | cut -b -17)"
#cp "$ZKBD"/"$norm_zkbd" "$ZKBD"/"$vscodium_zkbd"
cp "$ZKBD"/screen."$norm_zkbd"

# Change system default shell to Z shell
chsh -s /usr/bin/zsh

# Copy config files over to root's home directory
sudo cp -r "$HOME"/.z{shrc,profile,shenv,kbd} /root/
sudo sed -i "s;source /home/chris/.zprofile;source /root/.zprofile;" /root/.zshrc
sudo sed -i "s;source /home/chris/.zsh_aliases;source /root/.zsh_aliases;" /root/.zshrc
sudo sed -i "s;green;red;" /root/.zprofile
sudo touch /root/.zsh_aliases
sudo ln -s /root/.zsh_aliases /root/.bash_aliases
