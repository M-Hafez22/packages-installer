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

# 🔵 A.3.3 Choose Office
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
    MEDIA_PACKAGES="CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO YOUTUBE_DL"
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
        sudo apt install -y $2
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
    sudo apt update -y && sudo apt upgrade -y 
    printf "\n✅\e[1;32m  Update && Upgrade\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# B.2. ADD_REPOSITORIES
# Snap
case "$SANP" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m Adding Snap\e[0m\n"
  sudo apt update &&  sudo apt install -y  snapd &&  sudo snap install core &&  sudo snap install hello-world &&  sudo apt-get update -y  &&  sudo apt-get install -y gnome-software-plugin-snap
  printf "\n✅ \e[1;32m Reboot to use Sanp\e[0m\n"
  ;;
  *)
  printf ""
  ;;
esac
# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m  Adding Flatpak\e[0m\n"
  sudo apt install flatpak && sudo apt install gnome-software-plugin-flatpak  && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  printf "\n✅\e[1;32m flatpak\e[0m\n"
  ;;
  *)
  printf ""
  ;;
esac
