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
      read -p "$counter. Do you want to $option β y/n: " $option
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
    printf "\n\nπ₯\e[1;32m  Installing $2\e[0m\n"
    sudo zypper install -y $2
    printf "\nβ\e[1;32m  $2\e[0m\n"
    ;;
  *)
    printf ""
    ;;
  esac
}

# Install Package With Flatpack
function installPackageFlatpack() {
  case "$1" in [yY] | [yY][eE][sS])
    printf "\n\nπ₯\e[1;32m  Installing $2\e[0m\n"
    sudo flatpak install -y flathub $2
    printf "\nβ\e[1;32m  $2\e[0m\n"
    ;;
  *)
    printf ""
    ;;
  esac
}

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS; do
  read -p "Do you want to $QUESTIONβ y/n: " $QUESTION
done

# A.2. π§° Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "π§° Repositories" "PACKMAN FLATPAK"

# A.3 π οΈ Install Packages
optionsList "$INSTALL_PACKAGES" "π οΈ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# π¨ A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "π¨ Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE PANTHEON XFCE"

# π¨βπ» A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "π¨βπ»  Choose Developer Tools" "CODIUM VSCODE CODEOSS SUBLIME VIM DOCKER NVM NPM YARN GIT"

# Ask for Git config
case "$GIT" in [yY] | [yY][eE][sS])
  read -p "What is git user name β " GIT_NAME
  read -p "What is git user Email β " GIT_EMAIL
  # echo " $GIT_NAME"
  ;;
*)
  printf ""
  ;;
esac

# π A.3.3 Choose Office
optionsList "$OFFICE" "π  Choose Office Packages" "LIBREOFFICE CALIBRE SIGNAL OKULAR THUNDERBIRD MAILSPRING"

# πΊ A.3.4 Choose Media
optionsList "$MEDIA" "πΊ  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO YOUTUBE_DL"

# π A.3.5 Choose Browsers
optionsList "$BROWSERS" "π  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FALKON FIREFOX BRAVE MIDORI VIVALDI EDGE LIBREWOLF"

# πΌοΈ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "πΌοΈ  Choose Photo Editing" "GIMP INKSCAPE"

# π» A.3.7 Choose Terminal
optionsList "$TERMINAL" "π»  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"

# πΎ A.3.8 Choose OTHER
optionsList "$OTHER" "πΎ  Choose OTHER" "ROFI PLANK"

# B. Process

# B.1. Update the System
case "$UPDATE" in [yY] | [yY][eE][sS])
  printf "\n\nπ₯\e[1;32m  Update \e[0m\n"
  sudo zypper ref
  sudo zypper dup -y
  printf "\nβ\e[1;32m  Update\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

# B.2. ADD_REPOSITORIES

# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
  printf "\n\nπ₯\e[1;32m  Adding Flatpak\e[0m\n"
  sudo zypper install flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  printf "\nβ\e[1;32m flatpak\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

# PACKMAN
case "$PACKMAN" in [yY] | [yY][eE][sS])
  printf "\n\nπ₯\e[1;32m  Adding PACKMAN\e[0m\n"
  sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
  sudo zypper dup --from packman --allow-vendor-change
  printf "\nβ\e[1;32m PACKMAN\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

# B.3 Install Packages

# π΅ B.3.2. Developer Tools
# π§© Install CODIUM
case "$CODIUM" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing CODIUM\e[0m\n"
  sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
  sudo zypper install -y codium
  printf "\nβ\e[1;32m CODIUM Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© Install VSCODE
case "$VSCODE" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing VSCODE\e[0m\n"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo zypper addrepo  https://packages.microsoft.com/yumrepos/vscode vscode
  sudo zypper ref
  sudo zypper install -y code
  printf "\nβ\e[1;32m VSCODE Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© Install CODEOSS
installPackageFlatpack "$CODEOSS" "com.visualstudio.code-oss"
# π§© Install SUBLIME
case "$SUBLIME" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing SUBLIME\e[0m\n"
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo zypper addrepo -g -f https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  sudo zypper ref
  sudo zypper install -y sublime-text
  printf "\nβ\e[1;32m SUBLIME Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© Install VIM
installPackage "$VIM" "vim"
# π§© Install DOCKER
case "$DOCKER" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing DOCKER\e[0m\n"
  sudo zypper update
  sudo zypper install docker-compose
  printf "\nβ\e[1;32m Docker Installed\e[0m\n"

  sudo systemctl enable docker
  sudo systemctl start docker
  printf "\nβ\e[1;32m Enable Docker\e[0m\n"

  sudo groupadd docker
  sudo gpasswd -a $USER docker
  printf "\nβ\e[1;32m Add user to Docker Group\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© Install NVM (NODE & NPM)
case "$NVM" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing NVM & Nodejs & NPM\e[0m\n"
  sudo zypper install -y curl
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  source ~/.bashrc
  source ~/.zshrc
  nvm install --lts
  nvm install node
  nvm ls
  printf "\n\e[1;33m Node: " && node -v && printf "\e[0m\n\e[1;33m npm:" && npm -v && printf "\e[0m\n"
  printf "\nβ\e[1;32m NODE NPM npm-check-updates Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© Install YARN
installPackage "$YARN" "yarn"
# π§© Install GIT
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

# π΅ B.3.4. Media
# π§© CODECS
case "$CODECS" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing CODECS\e[0m\n"
  installPackage "$CODECS" "opi ffmpeg ffmpegthumbs"
  opi codecs
  printf "\nβ\e[1;32m CODECS Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# π§© YOUTUBE_DL
installPackage "$YOUTUBE_DL" "youtube-dl yt-dlp"

# π΅ B.3.5. Browsers
# π§© UNGOOGLEDCHROMIUM
installPackageFlatpack "$UNGOOGLEDCHROMIUM" "com.github.Eloston.UngoogledChromium"
# π§© CHROMIUM
installPackage "$CHROMIUM" "chromium"
# π§© CHROME
case "$CHROME" in [yY] | [yY][eE][sS])
  printf "\nπ₯ \e[1;32m Installing Google Chrome\e[0m\n"
  sudo zypper addrepo http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
  sudo zypper refresh
  wget https://dl.google.com/linux/linux_signing_key.pub
  sudo rpm --import linux_signing_key.pub
  sudo zypper install -y --no-confirm google-chrome-stable
  printf "\nβ\e[1;32m Google Chrome Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac