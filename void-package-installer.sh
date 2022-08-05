#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Void \e[0m\n\n"
# Functions
# Ask For Options
function optionsList() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\e[1;32m $2: \e[0m\n\n"
        options="$3"
        counter=1
        for option in $options
            do
            read -p "$counter. Do you want to $option ❔ y/n: " $option
            ((counter++))
            done
        ;;
        *)
        printf ""
        ;;
    esac    
}

# Install Package 
function installPackage() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        sudo xbps-install -Sy $2
        printf "\n✅\e[1;32m  $2\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
}

# Install Package with Flatpack
function installPackageFlatpack() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        flatpak install -y flathub  $2
        printf "\n✅\e[1;32m  $2\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
}

# Install Package VoidPkg
function installPackageVoidPkg() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        cd ~/rap/void-packages
        ./xbps-src pkg $2
        sudo xbps-install --repository=/home/hafez/rap/void-packages/hostdir/binpkgs/nonfree $2
        printf "\n✅\e[1;32m  $2\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
}


# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS
	do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. 🧰 Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "FLATPAK VOIDPKG"

# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE XFCE"

# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "CODIUM VSCODE SUBLIME WEBSTORM VIM NANO DOCKER NODE NPM YARN GIT"
# Ask for Git config
case "$GIT" in [yY] | [yY][eE][sS])
    read -p "What is git user name ❔ " GIT_NAME
    read -p "What is git user Email ❔ " GIT_EMAIL
    # echo " $GIT_NAME"
    ;;
    *)
    printf ""
    ;;
esac

# 📝 A.3.3 Choose Office
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE OKULAR THUNDERBIRD MAILSPRING FONTS"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO MP3INFO YOUTUBE_DL FFMPEG"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM CHROME FALKON FIREFOX FIREFOX_DEV BRAVE MIDORI VIVALDI EDGE WATERFOX"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM UTILITIES"


# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "ROFI PLANK EXFAT"

# B. Process

# B.1. Update the System
case "$UPDATE" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Update \e[0m\n"
	sudo xbps-install -Suv && sudo xbps-install -u xbps -y && sudo xbps-install  -y  -Su  && printf "***\n \e[1;33m  Update Is Completed!  \e[0m\n***\n"
    printf "\n✅\e[1;32m  Update\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.2. ADD_REPOSITORIES
# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding Flatpak\e[0m\n"
    sudo xbps-install -S -y  flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
    printf "***\n \e[1;33m  Flatpak Installed\n  Restart your system \e[0m\n***\n"
    printf "\n✅\e[1;32m flatpak\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac
# VOIDPKG
case "$VOIDPKG" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding Void-Packages\e[0m\n"
    cd
    mkdir ~/rap && cd ~/rap
    git clone https://github.com/void-linux/void-packages.git
    cd void-packages
    ./xbps-src binary-bootstrap
    echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
    printf "\n✅\e[1;32m flatpak\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.3 Install Packages
# 🎨 B.3.1. Install Desktop Environments
# 🧩 Install Awesome
installPackage "$AWESOME" "awesome"
# 🧩 Install Budgie
installPackage "$BUDGIE" "budgie-desktop"
# 🧩 Install Cinnamon
installPackage "$CINNAMON" "cinnamon"
# 🧩 Install Gnome
installPackage "$GNOME" "gnome chrome-gnome-shell"
# 🧩 Install KDE
installPackage "$KDE" "kde5"
# 🧩 Install MATE
installPackage "$MATE" "mate mate-extra upower0 mate-menu mate-applet-brisk-menu mate-applets mate-tweak"
# 🧩 Install Xfce
installPackage "$XFCE" "xfce4  xfce4-battery-plugin  xfce4-clipman-plugin   xfce4-cpufreq-plugin  xfce4-cpugraph-plugin xfce4-datetime-plugin  xfce4-dict   xfce4-diskperf-plugin   xfce4-docklike-plugin xfce4-fsguard-plugin  xfce4-genmon-plugin  xfce4-i3-workspaces-plugin   xfce4-mailwatch-plugin  xfce4-netload-plugin  xfce4-notifyd  xfce4-panel   xfce4-panel-appmenu   xfce4-places-plugin   xfce4-plugins   xfce4-power-manager    xfce4-pulseaudio-plugin    xfce4-screensaver    xfce4-screenshooter    xfce4-sensors-plugin  xfce4-session   xfce4-systemload-plugin   xfce4-taskmanager   xfce4-verve-plugin  xfce4-wavelan-plugin   xfce4-weather-plugin   xfce4-whiskermenu-plugin  xfce4-xkb-plugin "

# 👨‍💻 B.3.2. Developer Tools
# 🧩 Install CODIUM
installPackageFlatpack "$CODIUM" "com.vscodium.codium"
# 🧩 Install VSCODE
installPackageFlatpack "$VSCODE" "com.visualstudio.code"
# 🧩 Install SUBLIME
installPackageFlatpack "$SUBLIME" "com.sublimetext.three"
# 🧩 Install WEBSTORM
installPackageFlatpack "$WEBSTORM" "com.jetbrains.WebStorm"
# 🧩 Install VIM
installPackage "$VIM" "vim"
# 🧩 Install NANO
installPackage "$NANO" "nano"
# 🧩 Install DOCKER
case "$DOCKER" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding DOCKER\e[0m\n"
    sudo xbps-install -Syu
    sudo xbps-install -S Docker
    sudo ln  -s /etc/sv/containerd /var/service
    sudo ln  -s /etc/sv/docker /var/service
    docker --version
    # sudo docker pull hello-world
    # sudo docker run hello-world
    printf "\n✅\e[1;32m DOCKER\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# 🧩 Install NODE
installPackage "$NODE" "nodejs"
# 🧩 Install NPM
installPackage "$NPM" "npm"
# 🧩 Install YARN
installPackage "$YARN" "yarn"
# 🧩 Install GIT
case "$GIT" in [yY] | [yY][eE][sS])
    installPackage "$GIT" "git"
    # Add GIT NAME
    printf "\n\e[1;32m Add Your Git user name $GIT_NAME\e[0m\n"
    git config --global user.name  $GIT_NAME
    printf "\n\e[1;34m " && git config user.name && printf "\e[0m\n"
    # Add GIT EMAIL
    printf "\n\e[1;32m Add Your Git user Email $GIT_EMAIL\e[0m\n"
    git config --global user.email  $GIT_EMAIL
    printf "\n\e[1;34m " && git config user.email && printf "\e[0m\n" 
    ;;
  *)
    printf ""
    ;;
esac

# 📝 B.3.3. Office
# 🧩 LIBREOFFICE
installPackage "$LIBREOFFICE" "libreoffice"
# 🧩 OKULAR
installPackage "$OKULAR" "okular"
# 🧩 THUNDERBIRD
installPackage "$THUNDERBIRD" "thunderbird"
# 🧩 MAILSPRING
installPackageFlatpack "$MAILSPRING" "com.getmailspring.Mailspring"
# 🧩 FONTS
installPackage "$FONTS" "noto-fonts-emoji twemoji   noto-fonts-cjk unicode-emoji twemoji noto-fonts-emoji   noto-fonts-emoji"

# 📺 B.3.4. Media
# 🧩 AUDACIOUS
installPackage "$AUDACIOUS" "audacious audacious-plugins"
# 🧩 VLC
installPackage "$VLC" "vlc" 
# 🧩 MPV
installPackage "$MPV" "mpv"
# 🧩 CLEMENTINE
installPackage "$CLEMENTINE" "clementine"
# 🧩 OBS_STUDIO
installPackage "$OBS_STUDIO" "obs-studio"
# 🧩 YOUTUBE_DL
installPackage "$YOUTUBE_DL" "youtube-dl"
# 🧩 MP3INFO
installPackage "$MP3INFO" "mp3info"
# 🧩 FFPROBE
installPackage "$FFPROBE" "ffmpeg"

# 🌐 B.3.5. Browsers
# 🧩 CHROMIUM
installPackage "$CHROMIUM" "chromium"
# 🧩 CHROME
installPackageFlatpack "$CHROME" "com.google.Chrome"
# 🧩 FALKON
installPackage "$FALKON" "falkon"
# 🧩 FIREFOX
installPackage "$FIREFOX" "firefox"
# 🧩 FIREFOX_DEV
installPackage "$FIREFOX_DEV" "firefox-developer-edition"
# 🧩 BRAVE
installPackageFlatpack "$BRAVE" "com.brave.Browser"
# 🧩 MIDORI
installPackage "$MIDORI" "midori"
# 🧩 VIVALDI
installPackageVoidPkg "$VIVALDI" "vivaldi"
# 🧩 LIBREWOLF
installPackageFlatpack "$LIBREWOLF" "io.gitlab.librewolf-community"
# 🧩 EDGE
installPackageFlatpack "$EDGE" "com.microsoft.Edge"

# 🖼️ A.3.6 PHOTO_EDITE
# 🧩 GIMP
installPackage "$GIMP" "gimp"
# 🧩 INKSCAPE
installPackage "$INKSCAPE" "inkscape"

# 💻 TERMINAL
# 🧩 BPYTOP
installPackage "$BPYTOP" "bpytop"
# 🧩 HTOP
installPackage "$HTOP" "htop"
# 🧩 SL
installPackage "$SL" "sl"
# 🧩 CMATRIX
installPackage "$CMATRIX" "cmatrix"
# 🧩 LOLCAT
installPackage "$LOLCAT" "lolcat"
# 🧩 NEOFETCH
installPackage "$NEOFETCH" "neofetch"
# 🧩 TREE
installPackage "$TREE" "tree"
# 🧩 TERMINATOR
installPackage "$TERMINATOR" "terminator"
# 🧩 ZSH
installPackage "$ZSH" "zsh"
# 🧩 RETRO_TERM
installPackage "$RETRO_TERM" "cool-retro-term"
# 🧩 UTILITIES
installPackage "$UTILITIES" "ark  curl wget unzip gcc make  android-tools  ntfs-3g  xz  bc"

# 👾 OTHER
# 🧩 ROFI
installPackage "$ROFI" "rofi"
# 🧩 PLANK
installPackage  "$PLANK" "plank"
# 🧩 BALENA_ETCHER
installPackage "$BALENA_ETCHER" "etcher"
# 🧩 EXFAT
installPackage "$EXFAT" "exfat-utils"