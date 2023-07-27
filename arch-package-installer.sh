#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Arch \e[0m\n\n"
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

# Install Package With Flatpack
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

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS; do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. 🧰 Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "YAY FLATPAK SANP"

# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MESSAGING MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE XFCE"

# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "VSCODE CODEOSS CODIUM SUBLIME VIM NVM NODE NPM YARN TYPESCRIPT GIT"
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
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE OKULAR THUNDERBIRD MAILSPRING FONTS"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "AUDACIOUS VLC MPV CLEMENTINE RHYTHMBOX OBS_STUDIO MP3INFO YOUTUBE_DL FFMPEG"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FALKON FIREFOX FIREFOX_DEV BRAVE MIDORI VIVALDI EDGE WATERFOX LIBREWOLF GNOME_BROWSER"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"

# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "ROFI PLANK EXFAT QT5CT FLATSEAL"

# B. Process

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
    case "$PAMAC" in [yY] | [yY][eE][sS])
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
    sudo pacman -S flatpak
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
installPackagePacman "$XFCE" "xfce4 xfce4-goodies xfce4-clipman-plugin xfce4-systemload-plugin xfce4-whiskermenu-plugin"

# 👨‍💻 B.3.2. Developer Tools
# 🧩 Install CODIUM
installPackageYay "$CODIUM" "vscodium-bin"
# 🧩 Install VSCODE
installPackageYay "$VSCODE" "visual-studio-code-bin"
# 🧩 Install CODEOSS
installPackageFlatpack "$CODEOSS" "com.visualstudio.code-oss"
# 🧩 Install SUBLIME
installPackageYay "$SUBLIME" "sublime-text-3"
# 🧩 Install VIM
installPackagePacman "$VIM" "vim"
# 🧩 Install DOCKER
# 🧩 Install NODE
# 🧩 Install NVM
case "$NVM" in [yY] | [yY][eE][sS])
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.bashrc
    source ~/.zshrc
    nvm install node
    nvm install --lts
    nvm ls
    ;;
*)
    printf ""
    ;;
esac
# 🧩 Install NPM
installPackagePacman "$NPM" "npm"
# 🧩 Install YARN
installPackagePacman "$YARN" "yarn"
# 🧩 Install TYPESCRIPT
case "$TYPESCRIPT" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Typescript\e[0m\n"
    npm install -g typescript
    printf "\n✅\e[1;32m Typescript Installed\e[0m\n"
    ;;
*)
    printf ""
    ;;
esac
# 🧩 Install GIT
case "$GIT" in [yY] | [yY][eE][sS])
    installPackagePacman "$GIT" "git"
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

# 💬 A.3.3 Choose Messaging
# 🧩 SIGNAL
installPackageFlatpack "$SIGNAL" "org.signal.Signal"
# 🧩 WHATSAPP
installPackageFlatpack "$WHATSAPP" "io.github.mimbrero.WhatsAppDesktop"

# 📝 B.3.3. Office
# 🧩 LIBREOFFICE
installPackagePacman "$LIBREOFFICE" "libreoffice"
# 🧩 OKULAR
installPackagePacman "$OKULAR" "okular"
# 🧩 THUNDERBIRD
installPackagePacman "$THUNDERBIRD" "thunderbird"
# 🧩 MAILSPRING
installPackageFlatpack "$MAILSPRING" "com.getmailspring.Mailspring"
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
# 🧩 Rhythmbox
installPackage "$RHYTHMBOX" "rhythmbox"
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
# 🧩 UNGOOGLEDCHROMIUM
installPackageFlatpack "$UNGOOGLEDCHROMIUM" "com.github.Eloston.UngoogledChromium"
# 🧩 CHROME
installPackageYay "$CHROME" "google-chrome"
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
installPackageYay "$EDGE" "microsoft-edge-stable-bin"
# 🧩 WATERFOX LIBREWOLF
installPackagePacman "$WATERFOX LIBREWOLF" "waterfox LIBREWOLF-g3"
# 🧩 LIBREWOLF
installPackageFlatpack "$LIBREWOLF" "io.gitlab.librewolf-community"
# 🧩 GNOME_BROWSER
installPackagePacman "$GNOME_BROWSER" "epiphany"

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
installPackagePacman "$PLANK" "plank"
# 🧩 BALENA_ETCHER
installPackagePacman "$BALENA_ETCHER" "etcher"
# 🧩 EXFAT
installPackagePacman "$EXFAT" "exfat-utils"
# 🧩 QT5CT
case "$QT5CT" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing qt5ct\e[0m\n"
    sudo pacman -S -y qt5ct
    printf "\n✅\e[1;32m qt5ct Installed\e[0m\n"

    printf "\n\e[1;32m Set environment variables in ~/.profile\e[0m\n"
    echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' >>~/.profile
    ;;
*)
    printf ""
    ;;
esac
# 🧩 FLATSEAL
installPackageFlatpack "$FLATSEAL" "com.github.tchx84.Flatseal"
