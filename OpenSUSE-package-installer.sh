#! /usr/bin/bash

printf "\n\e[1;31m Welcome To OpenSUSE Tumbleweed \e[0m\n\n"

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

# Install Package With Zypper
function installPackage() {
  case "$1" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Installing $2\e[0m\n"
    sudo zypper install -y $2
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
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "PACKMAN FLATPAK"

# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE PANTHEON XFCE"

# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "CODIUM VSCODE CODEOSS SUBLIME VIM DOCKER NVM NPM YARN GIT"

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
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE CALIBRE SIGNAL OKULAR THUNDERBIRD MAILSPRING"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO YOUTUBE_DL"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FALKON FIREFOX BRAVE MIDORI VIVALDI EDGE LIBREWOLF"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"

# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "ROFI PLANK"

# B. Process

# B.1. Update the System
case "$UPDATE" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m  Update \e[0m\n"
  sudo zypper ref
  sudo zypper dup -y
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
  sudo zypper install flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  printf "\n✅\e[1;32m flatpak\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

# PACKMAN
case "$PACKMAN" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m  Adding PACKMAN\e[0m\n"
  sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
  sudo zypper dup --from packman --allow-vendor-change
  printf "\n✅\e[1;32m PACKMAN\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac