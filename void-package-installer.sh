#! /usr/bin/bash

printf "\n\e[32m Welcome To Void \e[0m\n\n"
# Functions
# Ask For Options
function optionsList() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\e[1;32m $2: \e[0m\n\n"
        options="$3"
        counter=1
        for option in $options; do
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
        flatpak install -y flathub $2
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
for QUESTION in $QUESTIONS; do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. 🧰 Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "FLATPAK VOIDPKG VOID_NONFREE"

# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MESSAGING MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE XFCE"

# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "CODIUM VSCODE CODEOSS SUBLIME WEBSTORM VIM NEOVIM NANO DOCKER NVM NODE NPM YARN GIT GITHUB_DESKTOP"
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

# 💬 A.3.3 Choose Messaging
optionsList "$MESSAGING" "💬  Choose Messaging Packages" "SIGNAL WHATSAPP"

# 📝 A.3.3 Choose Office
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE OKULAR THUNDERBIRD MAILSPRING FONTS PLANNER TODOIST"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO MP3INFO YOUTUBE_DL FFMPEG"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FALKON FIREFOX FIREFOX_DEV BRAVE MIDORI VIVALDI EDGE LIBREWOLF"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE FIGMA"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM UTILITIES"

# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "NEMO CONKY ROFI PLANK BALENA_ETCHER EXFAT FIRMWARE BLUETOOTH"

# B. Process

# B.1. Update the System
case "$UPDATE" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Update \e[0m\n"
    sudo xbps-install -Suv && sudo xbps-install -u xbps -y && sudo xbps-install -y -Su && printf "***\n \e[1;33m  Update Is Completed!  \e[0m\n***\n"
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
    sudo xbps-install -S -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    printf "***\n \e[1;33m  Flatpak Installed\n  Restart your system \e[0m\n***\n"
    sudo flatpak override --filesystem=xdg-data/themes
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
    echo XBPS_ALLOW_RESTRICTED=yes >>etc/conf
    printf "\n✅\e[1;32m flatpak\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac
# VOID_NONFREE
case "$VOID_NONFREE" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  void-repo-nonfree\e[0m\n"
    sudo xbps-install -S -y void-repo-nonfree
    printf "\n✅\e[1;32m void-repo-nonfree\e[0m\n"
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
installPackage "$GNOME" "gnome chrome-gnome-shell power-profiles-daemon"
# 🧩 Install KDE
installPackage "$KDE" "kde5 konsole"
# 🧩 Install MATE
installPackage "$MATE" "mate mate-extra upower0 mate-menu  mate-applets mate-tweak"
# 🧩 Install Xfce
installPackage "$XFCE" "xfce4  xfce4-battery-plugin  xfce4-clipman-plugin   xfce4-cpufreq-plugin  xfce4-cpugraph-plugin xfce4-datetime-plugin  xfce4-dict   xfce4-diskperf-plugin   xfce4-docklike-plugin xfce4-fsguard-plugin  xfce4-genmon-plugin  xfce4-i3-workspaces-plugin   xfce4-mailwatch-plugin  xfce4-netload-plugin  xfce4-notifyd  xfce4-panel   xfce4-panel-appmenu   xfce4-places-plugin   xfce4-plugins   xfce4-power-manager    xfce4-pulseaudio-plugin    xfce4-screensaver    xfce4-screenshooter    xfce4-sensors-plugin  xfce4-session   xfce4-systemload-plugin   xfce4-taskmanager   xfce4-verve-plugin  xfce4-wavelan-plugin   xfce4-weather-plugin   xfce4-whiskermenu-plugin  xfce4-xkb-plugin "

# 👨‍💻 B.3.2. Developer Tools
# 🧩 Install CODIUM
installPackageFlatpack "$CODIUM" "com.vscodium.codium"
# 🧩 Install CODEOSS
installPackage "$CODEOSS" "vscode"
# 🧩 Install VSCODE
installPackageFlatpack "$VSCODE" "com.visualstudio.code"
# 🧩 Install SUBLIME
installPackage "$SUBLIME" "sublime-text4"
# 🧩 Install WEBSTORM
installPackageFlatpack "$WEBSTORM" "com.jetbrains.WebStorm"
# 🧩 Install VIM
installPackage "$VIM" "vim"
# 🧩 Install NEOVIM
installPackage "$NEOVIM" "neovim"
# 🧩 Install NANO
installPackage "$NANO" "nano"
# 🧩 Install DOCKER
case "$DOCKER" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding DOCKER\e[0m\n"
    sudo xbps-install -Syu
    sudo xbps-install -S -y docker
    printf "\n✅\e[1;32m Install DOCKER\e[0m\n"

    sudo ln -s /etc/sv/containerd /var/service
    sudo ln -s /etc/sv/docker /var/service
    docker --version
    printf "\n✅\e[1;32m Enable Docker\e[0m\n"

    # sudo docker pull hello-world
    # sudo docker run hello-world

    sudo groupadd docker
    sudo gpasswd -a $USER docker
    printf "\n✅\e[1;32m Add user to Docker Group\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac
# 🧩 Install NVM (NODE & NPM)
case "$NVM" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing NVM & Nodejs & NPM\e[0m\n"
    sudo xbps-install -Sy curl
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.bashrc
    source ~/.zshrc
    nvm install --lts
    nvm install node
    nvm ls
    printf "\n\e[1;33m Node: " && node -v && printf "\e[0m\n\e[1;33m npm:" && npm -v && printf "\e[0m\n"
    printf "\n✅\e[1;32m NODE NPM npm-check-updates Installed\e[0m\n"
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
    git config --global user.name $GIT_NAME
    printf "\n\e[1;34m " && git config user.name && printf "\e[0m\n"
    # Add GIT EMAIL
    printf "\n\e[1;32m Add Your Git user Email $GIT_EMAIL\e[0m\n"
    git config --global user.email $GIT_EMAIL
    printf "\n\e[1;34m " && git config user.email && printf "\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac
# 🧩 GITHUB_DESKTOP
installPackageFlatpack "$GITHUB_DESKTOP" "io.github.shiftey.Desktop"

# 💬 A.3.3 Choose Messaging
# 🧩 SIGNAL
installPackageFlatpack "$SIGNAL" "org.signal.Signal"
# 🧩 WHATSAPP
installPackageFlatpack "$WHATSAPP" "io.github.mimbrero.WhatsAppDesktop"

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
installPackage "$FONTS" "noto-fonts-emoji twemoji nerd-fonts noto-fonts-cjk unicode-emoji twemoji noto-fonts-emoji  noto-fonts-emoji"
# 🧩 TODOIST
installPackageFlatpack "$TODOIST" "com.todoist.Todoist"
# 🧩 PLANNER
installPackage "$PLANNER" "planner"
# 📺 B.3.4. Media
installPackage "$CODECS" "mesa-vdpau intel-ucode"
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
installPackage "$YOUTUBE_DL" "youtube-dl yt-dlp"
# 🧩 MP3INFO
installPackage "$MP3INFO" "mp3info"
# 🧩 FFPROBE
installPackage "$FFPROBE" "ffmpeg"

# 🌐 B.3.5. Browsers
# 🧩 CHROMIUM
installPackage "$CHROMIUM" "chromium"
# 🧩 UNGOOGLEDCHROMIUM
installPackageFlatpack "$UNGOOGLEDCHROMIUM" "com.github.Eloston.UngoogledChromium"
# 🧩 CHROME
installPackageVoidPkg "$CHROME" "google-chrome"
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
# 🧩 FIGMA
installPackageFlatpack "$FIGMA" "io.github.Figma_Linux.figma_linux"

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
# 🧩 NEMO
installPackage "$NEMO" "nemo totem nemo-fileroller"
# 🧩 CONKY
case "$CONKY" in [yY] | [yY][eE][sS])
    printf "\n\e[1;32m Install Conky Manager 2\e[0m\n"
    sudo xbps-install base-devel git ImageMagick p7zip rsync conky json-glib-devel gtk+3-devel libgee08-devel vala-devel psmisc
    git clone https://github.com/zcot/conky-manager2.git
    cd conky-manager2
    make
    sudo make install
    printf "\n\e[1;32m Conky Manager 2 is ready\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac

# 🧩 ROFI
installPackage "$ROFI" "rofi"
# 🧩 PLANK
installPackage "$PLANK" "plank"
# 🧩 BALENA_ETCHER
installPackage "$BALENA_ETCHER" "etcher"
# 🧩 EXFAT
installPackage "$EXFAT" "exfat-utils"
# 🧩 FIRMWARE
installPackage "$FIRMWARE" "linux-firmware linux-firmware-network"
# 🧩 BLUETOOTH
case "$BLUETOOTH" in [yY] | [yY][eE][sS])
    printf "\n\e[1;32m Install bluez bluez-alsa\e[0m\n"
    sudo xbps-install -S dbus bluez bluez-alsa
    printf "\n\e[1;32m Add Bluetooth services\e[0m\n"
    sudo ln -s /etc/sv/dbus /var/service
    sudo ln -s /etc/sv/bluetoothd /var/service
    printf "\n\e[1;32m Bluetooth is ready\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac
