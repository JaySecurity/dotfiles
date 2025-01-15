#!/usr/bin/bash

mkdir .ssh
# Copy ssh keys drom thumbdrive

sudo pacman -S acpi acpica acpid adwaita-cursors adwaita-icon-theme adwaita-icon-theme-legacy arc-icon-theme archlinux-keyring base-devel breeze-icons btop buf bzip2 chromium clang curl delve direnv discord dmenu dmidecode docker docker-buildx docker-compose dotnet-host dotnet-runtime dotnet-sdk dotnet-targeting-pack dunst fd ffmpeg ffmpeg4.4 ffmpegthumbnailer ffmpegthumbs firefox flatpak fmt font-manager freecad fzf gimp git gnome-keyring gnome-keyring gnome-themes-extra go go-tools gvfs gzip hexchat htop i3-gaps i3blocks i3lock i3status jq kitty kubectl kvantum kvantum-qt5 latex2html lazygit libadwaita libgnome-keyring libreoffice-still libsecret lightdm-gtk-greeter lightdm-gtk-greeter-settings linux-lts linux-lts-headers lshw lua lua51-lpeg luarocks lxappearance  mpv muparser neovim network-manager-applet networkmanager nextcloud-client nitrogen nm-connection-editor numlockx nvidia-dkms nvidia-utils nwg-look obsidian picom pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse pnpm polkit polkit-gnome polkit-qt6 poppler poppler-data poppler-glib protobuf python python-pip python-pipenv qt5ct qt6ct qutebrowser ripgrep rsync rust rust-analyzer scrcpy scrot sed stow sudo tar thunar thunar-archive-plugin thunar-shares-plugin thunar-volman timeshift tmux transmission-gtk tree tree-sitter tree-sitter-c tree-sitter-cli tree-sitter-lua tree-sitter-markdown tree-sitter-query tree-sitter-vim tree-sitter-vimdoc unzip vi viewnior vlc webp-pixbuf-loader wget wireplumber xarchiver xclip xfce4-screenshooter xorg-xfontsel xorg-xlsfonts xss-lock yazi zip zsh  --noconfirm

visudo

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git config --global user.email "jasonnicholls1981@gmail.com"
git config --global user.name "Jason Nicholls"

mkdir Downloads
cd Downloads/
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
yay -Y --gendb

cd
yay -S appimagelauncher gnome-thumbnailers-git gnome-thumbnailers-git gnome-thumbnailers-git gst-libav i3exit kvantum-theme-libadwaita-git libjpeg-turbo libpng librecad-git libtiff libwebp poppler-glib slack-desktop telegram-desktop-bin ttf-dejavu-nerd ttf-dejavu-nerd ttf-firacode-nerd ttf-firacode-nerd ttf-liberation ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-noto-nerd ttf-noto-nerd tumbler-extra-thumbnailers tumbler-extra-thumbnailers tumbler-folder-thumbnailer tumbler-folder-thumbnailer xcursor-maia-git xcursor-neo-alien-dark xcursor-themes brave-bin devpod mongodb-compass mongodb-tools pwvucontrol tumbler-folder-thumbnailer vlc-plugin-pipewire --noconfirm

systemctl --user restart pipewire pipewire-pulse wireplumber
systemctl --user enable pipewire pipewire-pulse wireplumber
sudo systemctl enable acpid.service


mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

curl -fsSL https://fnm.vercel.app/install | bash
fnm completions --shell zsh

mkdir ~/Dotfiles
git clone git@github.com:JaySecurity/dotfiles.git ~/Dotfiles
cd Dotfiles
stow *
cd~/Downloads

curl -fsSL https://ollama.com/install.sh | sh
curl -LsSf https://aider.chat/install.sh | sh

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest