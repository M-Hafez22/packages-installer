#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Debian \e[0m\n\n"

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS
	do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. Add ADD_REPOSITORIES
case "$ADD_REPOSITORIES" in [yY] | [yY][eE][sS])
    printf "\n🧰\e[1;32m  Choose Repositories: \e[0m\n\n"
    REPOS="YAY SANP FLATPAK"
    for REPO in $REPOS
        do
        read -p "Do you want to Add $REPO Repositories❔ y/n: " $REPO
        done
    ;;
    *)
    printf ""
    ;;
esac


# A.4 Install Packages

case "$INSTALL_PACKAGES" in [yY] | [yY][eE][sS])
    printf "\n🛠️\e[1;32m  Choose Packages Categories: \e[0m\n\n"

    # Choose Packages Categories
    PACKAGES_CATEGORIES="DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"
    CATEGORIE_INDEX=1
    for PACKAGES_CATEGORIE in $PACKAGES_CATEGORIES
        do
        read -p "$CATEGORIE_INDEX. Do you want to install $PACKAGES_CATEGORIE packages❔ y/n: " $PACKAGES_CATEGORIE
        ((CATEGORIE_INDEX++))
    done
    ;;
  *)
    printf ""
    ;;
esac

# 🎨 A.3.1. Choose Desktop Environment
case "$DESKTOP_ENVIRONMENT" in [yY] | [yY][eE][sS])
    printf "\n🎨\e[1;32m  Choose Desktop Environment(s): \e[0m\n\n"
    DES="AWESOME BUDGIE CINNAMON GNOME KDE MATE XFCE"
    DE_INDEX=1
    for DE in $DES
        do
        read -p "$DE_INDEX. Do you want to $DE❔ y/n: " $DE
        ((DE_INDEX++))
        done
        ;;
    *)
        printf ""
        ;;
esac

# 👨‍💻 A.3.2 DEV_TOOLS
case "$DEV_TOOLS" in [yY] | [yY][eE][sS])
    printf "\n👨‍💻\e[1;32m  Choose Developer Tools: \e[0m\n\n"
    DEVS="CODIUM VSCODE SUBLIME VIM NODE NPM YARN GIT"
    DEV_INDEX=1
    for DEV in $DEVS
        do
        read -p "$DEV_INDEX. Do you want to $DEV❔ y/n: " $DEV
        ((DEV_INDEX++))
    done
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
        ;;
    *)
        printf ""
        ;;
esac

# 📝 A.3.3 Choose Office
case "$OFFICE" in [yY] | [yY][eE][sS])
    printf "\n📝\e[1;32m  Choose Office Packages: \e[0m\n\n"
    OFFICE_PACKAGES="LIBREOFFICE OKULAR THUNDERBIRD FONTS"
    OFFICE_INDEX=1
    for OFFICE_PACKAGE in $OFFICE_PACKAGES
        do
        read -p "$OFFICE_INDEX. Do you want to $OFFICE_PACKAGE❔ y/n: " $OFFICE_PACKAGE
        ((OFFICE_INDEX++))
        done
        ;;
    *)
        printf ""
        ;;
esac

# 📺 A.3.4 Choose Media
case "$MEDIA" in [yY] | [yY][eE][sS])
    printf "\n📺\e[1;32m  Choose Media Packages: \e[0m\n\n"
    MEDIA_PACKAGES="AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO MP3INFO YOUTUBE_DL FFMPEG"
    MEDIA_INDEX=1
    for MEDIA_PACKAGE in $MEDIA_PACKAGES
        do
        read -p "$MEDIA_INDEX. Do you want to $MEDIA_PACKAGE❔ y/n: " $MEDIA_PACKAGE
        ((MEDIA_INDEX++))
        done
    ;;
    *)
        printf ""
    ;;
esac

# 🌐 A.3.5 Choose Browsers
case "$BROWSERS" in [yY] | [yY][eE][sS])
    printf "\n🌐\e[1;32m  Choose Browsers: \e[0m\n\n"
    BROWSERS_PACKAGES="CHROMIUM CHROME FALKON FIREFOX FIREFOX_DEV BRAVE MIDORI VIVALDI EDGE WATERFOX"
    BROWSERS_INDEX=1
    for BROWSERS_PACKAGE in $BROWSERS_PACKAGES
        do
        read -p "$BROWSERS_INDEX. Do you want to $BROWSERS_PACKAGE❔ y/n: " $BROWSERS_PACKAGE
        ((BROWSERS_INDEX++))
        done
    ;;
    *)
        printf ""
    ;;
esac

# 🖼️ A.3.6 Choose PHOTO_EDITING
case "$PHOTO_EDITING" in [yY] | [yY][eE][sS])
    printf "\n🖼️\e[1;32m  Choose PHOTO_EDITING: \e[0m\n\n"
    PHOTO_EDITING_PACKAGES="GIMP INKSCAPE"
    PHOTO_EDITING_INDEX=1
    for PHOTO_EDITING_PACKAGE in $PHOTO_EDITING_PACKAGES
        do
        read -p "$PHOTO_EDITING_INDEX. Do you want to $PHOTO_EDITING_PACKAGE❔ y/n: " $PHOTO_EDITING_PACKAGE
        ((PHOTO_EDITING_INDEX++))
        done
    ;;
    *)
        printf ""
    ;;
esac

# 💻 A.3.7 Choose Terminal
case "$TERMINAL" in [yY] | [yY][eE][sS])
    printf "\n💻\e[1;32m  Choose TERMINAL: \e[0m\n\n"
    TERMINAL_PACKAGES="BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"
    TERMINAL_INDEX=1
    for TERMINAL_PACKAGE in $TERMINAL_PACKAGES
        do
        read -p "$TERMINAL_INDEX. Do you want to $TERMINAL_PACKAGE❔ y/n: " $TERMINAL_PACKAGE
        ((TERMINAL_INDEX++))
        done
    ;;
    *)
        printf ""
    ;;
esac

# 👾 A.3.8 Choose OTHER
case "$OTHER" in [yY] | [yY][eE][sS])
    printf "\n👾\e[1;32m  Choose OTHER: \e[0m\n\n"
    OTHER_PACKAGES="ROFI PLANK EXFAT"
    OTHER_INDEX=1
    for OTHER_PACKAGE in $OTHER_PACKAGES
        do
        read -p "$OTHER_INDEX. Do you want to $OTHER_PACKAGE❔ y/n: " $OTHER_PACKAGE
        ((OTHER_INDEX++))
        done
    ;;
    *)
        printf ""
    ;;
esac

# B. Process

# Install Package Pacman
function installPackagePacman() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        sudo pacman -S $2
        printf "\n✅\e[1;32m  $2\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
}

# Install Package Yay
function installPackageYay() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        printf "\n\n📥\e[1;32m  Adding YAY\e[0m\n"
        sudo pacman -S --needed base-devel git
        git clone https://aur.archlinux.org/yay-git.git
        cd yay-git
        makepkg -si
        printf "\n✅\e[1;32m YAY\e[0m\n"
        yay -S $2
        printf "\n✅\e[1;32m  $2\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
}

# B.1. Update the System
case "$UPDATE" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Update \e[0m\n"
    sudo pacman -Syyu -y 
    printf "\n✅\e[1;32m  Update\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.2. ADD_REPOSITORIES
# YAY
case "$YAY" in [yY] | [yY][eE][sS])
    read -p "Do you want to install Pamac❔ y/n: " $PAMAC
    printf "\n\n📥\e[1;32m  Adding YAY\e[0m\n"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg -si
    printf "\n✅\e[1;32m YAY\e[0m\n"
    case "$UPDATE" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Pamac \e[0m\n"
        yay -S pamac-aur
        printf "\n✅\e[1;32m  Pamac\e[0m\n"
        ;;
        *)
        printf ""
        ;;
    esac
    ;;
    *)
    printf ""
    ;;
esac
# Snap
case "$SANP" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m Adding Snap\e[0m\n"
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
    printf "\n✅ \e[1;32m Reboot to use Sanp\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac
# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding Flatpak\e[0m\n"
    sudo pacman -S  flatpak 
    printf "\n✅\e[1;32m flatpak\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.3 Install Packages
# 🎨 B.3.1. Install Desktop Environments
# 🧩 Install Awesome
installPackagePacman "$AWESOME" "awesome"
# 🧩 Install Budgie
installPackagePacman "$BUDGIE" "budgie-desktop"
# 🧩 Install Cinnamon
installPackagePacman "$CINNAMON" "cinnamon"
# 🧩 Install Gnome
installPackagePacman "$GNOME" "gnome chrome-gnome-shell"
# 🧩 Install KDE
installPackagePacman "$KDE" "plasma"
# 🧩 Install MATE
installPackagePacman "$MATE" "mate mate-extra  mate-menu mate-applet-brisk-menu mate-applets mate-tweak"
# 🧩 Install Xfce
installPackagePacman "$XFCE" "xfce4 xfce4-goodies xfce4-clipman-plugin xfce4-systemload-plugin xfce4-whiswmenu-plugin"

# 👨‍💻 B.3.2. Developer Tools
# 🧩 Install CODIUM
installPackageYay "$CODIUM" "vscodium-bin"
# 🧩 Install VSCODE
installPackagePacman "$VSCODE" "code"
# 🧩 Install SUBLIME
installPackageYay "$SUBLIME" "sublime-text-3"
# 🧩 Install VIM
installPackagePacman "$VIM" "vim"
# 🧩 Install DOCKER
# 🧩 Install NODE
installPackagePacman "$NODE" "nodejs"
# 🧩 Install NPM
installPackagePacman "$NPM" "npm"
# 🧩 Install YARN
installPackagePacman "$YARN" "yarn"
# 🧩 Install GIT
case "$GIT" in [yY] | [yY][eE][sS])
    installPackagePacman "$GIT" "git"
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
installPackagePacman "$LIBREOFFICE" "libreoffice"
# 🧩 OKULAR
installPackagePacman "$OKULAR" "okular"
# 🧩 THUNDERBIRD
installPackagePacman "$THUNDERBIRD" "thunderbird"
# 🧩 FONTS
installPackagePacman "$FONTS" "otf-cascadia-code  ttf-joypixels  woff2-cascadia-code ttf-droid ttf-cascadia-code noto-fonts-emoji noto-fonts-cjk awesome-terminal-fonts noto-fonts ttf-dejavu  ttf-droid  ttf-inconsolata  ttf-indic-otf  ttf-liberation "

# 📺 B.3.4. Media
# 🧩 AUDACIOUS
installPackagePacman "$AUDACIOUS" "audacious audacious-plugins"
# 🧩 VLC
installPackagePacman "$VLC" "vlc" 
# 🧩 MPV
installPackagePacman "$MPV" "mpv"
# 🧩 CLEMENTINE
installPackagePacman "$CLEMENTINE" "clementine"
# 🧩 OBS_STUDIO
installPackagePacman "$OBS_STUDIO" "obs-studio"
# 🧩 YOUTUBE_DL
installPackagePacman "$YOUTUBE_DL" "youtube-dl"
# 🧩 MP3INFO
installPackagePacman "$MP3INFO" "mp3info"
# 🧩 FFPROBE
installPackagePacman "$FFPROBE" "ffmpeg"

# 🌐 B.3.5. Browsers
# 🧩 CHROMIUM
installPackagePacman "$CHROMIUM" "chromium"
# 🧩 CHROME
installPackageYay    "$CHROME" "google-chrome"
# 🧩 FALKON
installPackagePacman "$FALKON" "falkon"
# 🧩 FIREFOX
installPackagePacman "$FIREFOX" "firefox-esr"
# 🧩 FIREFOX_DEV
installPackagePacman "$FIREFOX_DEV" "firefox-developer-edition"
# 🧩 BRAVE
installPackageYay "$BRAVE" "brave"
# 🧩 MIDORI
installPackagePacman "$MIDORI" "midori"
# 🧩 VIVALDI
installPackagePacman "$VIVALDI" "vivaldi"
# 🧩 LIBREWOLF
installPackageYay "$LIBREWOLF" "librewolf"
# 🧩 EDGE
installPackageYay "$EDGE" "microsoft-edge-dev-bin"
# 🧩 WATERFOX
installPackagePacman "$WATERFOX" "waterfox-g3"

# 🖼️ A.3.6 PHOTO_EDITE
# 🧩 GIMP
installPackagePacman "$GIMP" "gimp"
# 🧩 INKSCAPE
installPackagePacman "$INKSCAPE" "inkscape"

# 💻 TERMINAL
# 🧩 BPYTOP
installPackagePacman "$BPYTOP" "bpytop"
# 🧩 HTOP
installPackagePacman "$HTOP" "htop"
# 🧩 SL
installPackagePacman "$SL" "sl"
# 🧩 CMATRIX
installPackagePacman "$CMATRIX" "cmatrix"
# 🧩 LOLCAT
installPackagePacman "$LOLCAT" "lolcat"
# 🧩 NEOFETCH
installPackagePacman "$NEOFETCH" "neofetch"
# 🧩 TREE
installPackagePacman "$TREE" "tree"
# 🧩 TERMINATOR
installPackagePacman "$TERMINATOR" "terminator"
# 🧩 ZSH
installPackagePacman "$ZSH" "zsh"
# 🧩 RETRO_TERM
installPackagePacman "$RETRO_TERM" "cool-retro-term"

# 👾 OTHER
# 🧩 ROFI
installPackagePacman "$ROFI" "rofi"
# 🧩 PLANK
installPackagePacman  "$PLANK" "plank"
# 🧩 BALENA_ETCHER
installPackagePacman "$BALENA_ETCHER" "etcher"
# 🧩 EXFAT
installPackagePacman "$EXFAT" "exfat-utils"