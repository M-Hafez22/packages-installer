#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Fedora \e[0m\n\n"

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS
	do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
	done

# A.2. Add ADD_REPOSITORIES
case "$ADD_REPOSITORIES" in [yY] | [yY][eE][sS])
    REPOS="FUSION SANP FLATPAK"
    for REPO in $REPOS
        do
        read -p "Do you want to Add $REPO Repositories❔ y/n: " $REPO
        done
    ;;
    *)
    printf ""
    ;;
esac

# A.3 Install Packages
printf "\n🛠️\e[1;32m  Choose Packages Categories: \e[0m\n\n"

# Choose Packages Categories
PACKAGES_CATEGORIES="DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"
CATEGORIE_INDEX=1
for PACKAGES_CATEGORIE in $PACKAGES_CATEGORIES
    do
    read -p "$CATEGORIE_INDEX. Do you want to install $PACKAGES_CATEGORIE packages❔ y/n: " $PACKAGES_CATEGORIE
    ((CATEGORIE_INDEX++))
done

# 🔵 A.3.1. Choose Desktop Environment
case "$DESKTOP_ENVIRONMENT" in [yY] | [yY][eE][sS])
    printf "\n🎨\e[1;32m  Choose Desktop Environment(s): \e[0m\n\n"
    DES="AWESOME BUDGIE CINNAMON GNOME KDE MATE PANTHEON XFCE"
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

# 🔵 A.3.2 DEV_TOOLS
case "$DEV_TOOLS" in [yY] | [yY][eE][sS])
    printf "\n👨‍💻\e[1;32m  Choose Developer Tools: \e[0m\n\n"
    DEVS="VSCODE SUBLIME VIM DOCKER NODE NPM YARN GIT"
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

# 🔵 A.3.4 Choose Office
case "$OFFICE" in [yY] | [yY][eE][sS])
    printf "\n📝\e[1;32m  Choose Office Packages: \e[0m\n\n"
    OFFICE_PACKAGES="LIBREOFFICE OKULAR THUNDERBIRD"
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

# 🔵 A.3.4 Choose Media
case "$MEDIA" in [yY] | [yY][eE][sS])
    printf "\n📺\e[1;32m  Choose Media Packages: \e[0m\n\n"
    MEDIA_PACKAGES="CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO YOUTUBE_DL FFPROBE"
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

# 🔵 A.3.5 Choose Browsers
case "$BROWSERS" in [yY] | [yY][eE][sS])
    printf "\n🌐\e[1;32m  Choose Browsers: \e[0m\n\n"
    BROWSERS_PACKAGES="CHROMIUM CHROME FALKON FIREFOX BRAVE MIDORI VIVALDI EDGE"
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

# 🔵 A.3.6 Choose PHOTO_EDITING
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

# 🔵 A.3.7 Choose Terminal
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

# 🔵 A.3.8 Choose OTHER
case "$OTHER" in [yY] | [yY][eE][sS])
    printf "\n👾\e[1;32m  Choose OTHER: \e[0m\n\n"
    OTHER_PACKAGES="ROFI PLANK"
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

# Install Package function
function installPackage() {
    case "$1" in [yY] | [yY][eE][sS])
        printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
        sudo dnf install -y $2
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
    sudo dnf update -y 
    printf "\n✅\e[1;32m  Update\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.2. ADD_REPOSITORIES
# FUSION
case "$FUSION" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m Adding FUSION Repos\e[0m\n"
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  printf "\n✅ \e[1;32m FUSION Repos\e[0m\n"
  ;;
  *)
  printf ""
  ;;
esac
# Snap
case "$SANP" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m Adding Snap\e[0m\n"
  sudo dnf install snapd -y && sudo ln -s /var/lib/snapd/snap /snap
  printf "\n✅ \e[1;32m Reboot to use Sanp\e[0m\n"
  ;;
  *)
  printf ""
  ;;
esac
# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m  Adding Flatpak\e[0m\n"
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  printf "\n✅\e[1;32m flatpak\e[0m\n"
  ;;
  *)
  printf ""
  ;;
esac

# B.3 Install Packages
# 🔵 B.3.1. Install Desktop Environments
# 🧩 Install Awesome
installPackage "$AWESOME" "awesome"
# 🧩 Install Budgie
case "$BUDGIE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Budgie\e[0m\n"
    sudo dnf copr enable stenstorp/budgie -y && sudo dnf install budgie-desktop budgie-extras -y
    printf "\n✅\e[1;32m Budgie Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install Cinnamon
installPackage "$CINNAMON"  "@cinnamon-desktop-environment copyq "
# 🧩 Install Gnome
case "$GNOME" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Gnome\e[0m\n"
    sudo dnf group install -y "GNOME Desktop Environment" && sudo dnf install -y gnome-tweaks.noarch gnome-extensions-app
    printf "\n✅\e[1;32m Gnome Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install KDE
case "$KDE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing KDE\e[0m\n"
    sudo dnf -y group install "KDE Plasma Workspaces"
    printf "\n✅\e[1;32m KDE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install MATE
case "$MATE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing MATE\e[0m\n"
    sudo dnf -y group install "MATE Desktop"
    printf "\n✅\e[1;32m MATE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install Pantheon
case "$PANTHEON" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Pantheon\e[0m\n"
    sudo dnf group install -y "pantheon desktop"
    printf "\n✅\e[1;32m Pantheon Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install Xfce
installPackage "$XFCE" "@xfce-desktop-environment xfce4-clipman-plugin xfce4-systemload-plugin xfce4-whiskermenu-plugin"

# 🔵 B.3.2. Developer Tools
# 🧩 Install VSCODE
case "$VSCODE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing VSCODE\e[0m\n"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && sudo dnf install code -y
    printf "\n✅\e[1;32m VSCODE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install SUBLIME
case "$SUBLIME" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing SUBLIME\e[0m\n"
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg && sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo && sudo dnf install sublime-text -y
    printf "\n✅\e[1;32m SUBLIME Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install VIM
installPackage "$VIM" "vim"
# 🧩 Install DOCKER
case "$DOCKER" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing DOCKER\e[0m\n"
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    printf "\n✅\e[1;32m DOCKER Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install NODE & NPM
case "$NODE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Nodejs & NPM\e[0m\n"
    sudo dnf install nodejs -y
    printf "\n\e[1;33m Node: " && node -v && printf "\e[0m\n\e[1;33m npm:" && npm -v && printf "\e[0m\n"
    printf "\n✅\e[1;32m NODE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install YARN
case "$YARN" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing YARN\e[0m\n"
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo && sudo yum install yarn -y
     printf "\n\e[1;33m Yarn: " && yarn -version && printf "\e[0m\n"
    printf "\n✅\e[1;32m YARN Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
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

# 🔵 B.3.3. Office
# 🧩 LIBREOFFICE
installPackage "$LIBREOFFICE" "libreoffice"
# 🧩 OKULAR
installPackage "$OKULAR" "okular"
# 🧩 THUNDERBIRD
installPackage "$THUNDERBIRD" "thunderbird"

# 🔵 B.3.4. Media
# 🧩 CODECS
case "$CODECS" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Media CODECS\e[0m\n"
    sudo dnf groupupdate multimedia --setop="install\*weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y && sudo dnf groupupdate sound-and-video -y
    printf "\n✅\e[1;32m Media CODECS Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 AUDACIOUS
installPackage "$AUDACIOUS" "audacious"
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
# 🧩 FFPROBE
case "$FFPROBE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing FFPROBE\e[0m\n"
     sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm  &&  sudo dnf -y install ffmpeg  &&  sudo dnf -y install ffmpeg-devel
    printf "\n✅\e[1;32m FFPROBE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac

# 🔵 B.3.5. Browsers
# 🧩 CHROMIUM
installPackage "$CHROMIUM" "chromium"
# 🧩 CHROME
case "$CHROME" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Google Chrome\e[0m\n"
    sudo dnf install fedora-workstation-repositories -y
    sudo dnf config-manager --set-enabled google-chrome -y
    sudo dnf install google-chrome-stable -y
    printf "\n✅\e[1;32m Google Chrome Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 FALKON
installPackage  "$FALKON" "falkon"
# 🧩 FIREFOX
installPackage "$FIREFOX" "firefox"
# 🧩 BRAVE
case "$BRAVE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing BRAVE\e[0m\n"
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo dnf install brave-browser -y
    printf "\n✅\e[1;32m BRAVE Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 MIDORI
installPackage "$MIDORI" "midori"
# 🧩 VIVALDI
case "$VIVALDI" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing VIVALDI\e[0m\n"
    sudo dnf install dnf-utils -y
    sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
    sudo dnf install vivaldi-stable -y
    printf "\n✅\e[1;32m VIVALDI Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 EDGE
case "$EDGE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing MS Edge\e[0m\n"
    sudo dnf install dnf-plugins-core -y
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo dnf -y config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    Adding repo from: https://packages.microsoft.com/yumrepos/edge
    sudo dnf update --refresh
    sudo dnf install -y microsoft-edge-stable
    microsoft-edge -version
    printf "\n✅\e[1;32m MS Edge Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac

# 🔵 A.3.6 PHOTO_EDITE
# 🧩 GIMP
installPackage "$GIMP" "gimp"
# 🧩 INKSCAPE
installPackage "$INKSCAPE" "inkscape"

# 🔵 TERMINAL
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

# 🔵 OTHER
# 🧩 ROFI
installPackage "$ROFI" "rofi"
# 🧩 PLANK
installPackage  "$PLANK" "plank"
