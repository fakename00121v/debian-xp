#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt install -y --no-install-recommends ntfs-3g exfatprogs dosfstools

sudo sh -c 'echo "blacklist ntfs3" > /etc/modprobe.d/blacklist-ntfs3.conf'
sudo modprobe -r ntfs3
sudo mkdir -p /etc/udev/rules.d
sudo sh -c 'cat <<EOF > /etc/udev/rules.d/99-ntfs3-disable.rules
SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs-3g"
EOF'
sudo udevadm control --reload-rules && sudo udevadm trigger

sudo apt install -y --no-install-recommends gvfs gvfs-backends scrot
sudo apt install -y --no-install-recommends git wget 7zip unzip zip
#sudo apt install -y --no-install-recommends librsvg2-common libgdk-pixbuf2.0-common libgdk-pixbuf-2.0-0
sudo apt install -y --no-install-recommends pipewire pipewire-audio-client-libraries pipewire-pulse pipewire-alsa wireplumber pavucontrol pnmixer
sudo apt install -y --no-install-recommends udisks2

sudo apt install -y --no-install-recommends \
    xorg openbox obconf tint2 lxappearance pcmanfm jgmenu xcape udiskie \
    lxsession-logout dunst picom dbus-x11 alacritty gxkb libnotify-bin python3-gi gir1.2-notify-0.7

sudo apt install -y --no-install-recommends firefox-esr mousepad mpv galculator gpicview xarchiver lxtask gdebi
sudo apt purge fortune-mod -y --no-install-recommends
sudo apt purge "^ibus.*" -y --no-install-recommends
sudo apt purge mlterm mlterm-tiny mlterm-common --no-install-recommends -y
sudo apt autoremove -y

sudo apt install -y --no-install-recommends fastfetch cava ranger

sudo apt install -y --no-install-recommends locales
echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo update-locale LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_CTYPE="ru_RU.UTF-8" LC_NUMERIC="ru_RU.UTF-8" LC_TIME="ru_RU.UTF-8" LC_COLLATE="ru_RU.UTF-8" LC_MONETARY="ru_RU.UTF-8" LC_MESSAGES="ru_RU.UTF-8" LC_PAPER="ru_RU.UTF-8" LC_NAME="ru_RU.UTF-8" LC_ADDRESS="ru_RU.UTF-8" LC_TELEPHONE="ru_RU.UTF-8" LC_MEASUREMENT="ru_RU.UTF-8" LC_IDENTIFICATION="ru_RU.UTF-8" LC_ALL="ru_RU.UTF-8"

mkdir -p ~/.icons ~/.themes
sudo mkdir -p /usr/share/themes /usr/share/icons

git clone --depth 1 https://github.com/B00merang-Artwork/Windows-XP.git ~/.icons/Windows-XP
sudo cp -r ~/.icons/Windows-XP /usr/share/icons/

TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/B00merang-Project/Windows-XP.git "$TMP/gtk"
cp -r "$TMP/gtk/Windows XP Embedded" ~/.themes/
sudo cp -r "$TMP/gtk/Windows XP Embedded" /usr/share/themes/
rm -rf $TMP

mkdir -p ~/.config/openbox
mkdir -p ~/.config/pcmanfm/default
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/tint2
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/pnmixer
mkdir -p ~/.config/picom
mkdir -p ~/.config/ranger
mkdir -p ~/.config/cava
mkdir -p ~/.config/jgmenu
mkdir -p ~/.local/share/gxkb/flags
mkdir -p ~/.local/bin

wget -O ~/.local/bin/layout_switch.sh https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/bin/layout_switch.sh &

wget -O ~/.local/share/gxkb/flags/ru.png https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/share/gxkb/flags/ru.png &
wget -O ~/.local/share/gxkb/flags/us.png https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/share/gxkb/flags/us.png &

wget -O ~/.config/tint2/tint2rc https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/tint2/tint2rc &
wget -O ~/.config/pcmanfm/default/wallpaper.jpg https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/pcmanfm/default/wallpaper.jpg &
wget -O ~/.config/gtk-3.0/settings.ini https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/gtk-3.0/settings.ini &
wget -O ~/.config/openbox/rc.xml https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/openbox/rc.xml &
wget -O ~/.config/mimeapps.list https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/mimeapps.list &
wget -O ~/.config/pnmixer/config https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/pnmixer/config &
wget -O ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/alacritty/alacritty.toml &
wget -O ~/.config/picom/picom.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/picom/picom.conf &
wget -O ~/.config/openbox/autostart https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/openbox/autostart &
wget -O ~/.config/ranger/rc.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/ranger/rc.conf &
wget -O ~/.config/cava/config https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/cava/config &
wget -O ~/.config/pcmanfm/default/pcmanfm.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/pcmanfm/default/pcmanfm.conf &
wget -O ~/.config/jgmenu/append.csv https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/jgmenu/append.csv &

wait
chmod +x ~/.local/bin/layout_switch.sh

sudo apt install -y --no-install-recommends lightdm lightdm-gtk-greeter

sudo mkdir -p /etc/lightdm
sudo mkdir -p /usr/share/xsessions
sudo mkdir -p /usr/share/backgrounds

sudo wget -O /etc/lightdm/lightdm.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/lightdm/lightdm.conf
sudo wget -O /etc/lightdm/lightdm-gtk-greeter.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/lightdm/lightdm-gtk-greeter.conf
sudo wget -O /usr/share/xsessions/openbox.desktop https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/xsessions/openbox.desktop
sudo wget -O /usr/share/backgrounds/lightdm-wallpaper.jpg https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/lightdm/wallpaper.jpg

sudo rm -f /etc/systemd/system/display-manager.service
sudo ln -s /lib/systemd/system/lightdm.service /etc/systemd/system/display-manager.service
sudo systemctl enable lightdm.service
sudo systemctl daemon-reload

cat << EOF > $HOME/.config/pcmanfm/default/desktop-items-0.conf
[*]
wallpaper_mode=stretch
wallpaper_common=1
wallpaper=$HOME/.config/pcmanfm/default/wallpaper.jpg
desktop_bg=#000000
desktop_fg=#ffffff
desktop_shadow=#000000
desktop_font=Sans 12
show_wm_menu=0
sort=mtime;ascending;
show_documents=1
show_trash=1
show_mounts=1
EOF

systemctl --user enable --now pipewire.service wireplumber.service pipewire-pulse.service
set +e
sudo systemctl stop display-manager.service

loginctl terminate-user "$USER"
