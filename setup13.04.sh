#!/bin/bash
# Install programs
sudo apt-get install git zsh gdebi ubuntu-restricted-extras sl imagemagick vlc

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi google-chrome-stable_current_amd64.deb

# Remove stuff
sudo apt-get autoremove unity-lens-shopping unity-lens-music unity-lens-photos unity-lens-gwibber unity-lens-video
sudo service apport stop

# no stupid warnings
sudo sed -i -e s/^enabled\=1$/enabled\=0/ /etc/default/apport

# settings...
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.settings-daemon.peripherals.touchpad scroll-method 'two-finger-scrolling'
gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true
gsettings set org.gnome.settings-daemon.peripherals.touchpad horiz-scroll-enabled true
gsettings set com.canonical.desktop.interface scrollbar-mode normal
gsettings set com.canonical.Unity.Launcher favorites "['application://gnome-terminal.desktop', 'application://google-chrome.desktop', 'application://sublime-text-2.desktop', 'application://nautilus.desktop', 'application://gnome-control-center.desktop', 'application://ubuntu-software-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1

# Background... doesn't work for unity right now
cp wallpaper.jpg ~/Pictures
gsettings set org.gnome.desktop.background picture

# zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

# Copy dotfiles
cp .bashrc ~
cp .zshrc ~
cp .profile ~
cp .gitconfig ~

# Update
sudo apt-get update
sudo apt-get upgrade

echo "Get sublime 3 and run once..."
read
mv ~/.config/sublime-text-3/Packages ~/.config/sublime-text-3/Packages-old
git clone https://github.com/mattdangerw/sublime-packages.git ~/.config/sublime-text-3/Packages

#TODO automate
echo "Set capslock to control..."
read
echo "Graphics drivers..."
read
echo "Half maximize shortcuts if you want..."
read
