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
    sudo flatpak install -y flathub $2
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
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MAIL MESSAGING MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT" "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE PANTHEON XFCE"

# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "CODIUM VSCODE CODEOSS SUBLIME VIM NEOVIM DOCKER NVM NPM YARN TYPESCRIPT GIT GITHUB_DESKTOP"

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
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE CALIBRE OKULAR FONTS TODOIST"

# 📧 A.3.3 Choose Mail
optionsList "$MAIL" "📧  Choose Mail Packages" "THUNDERBIRD MAILSPRING"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE RHYTHMBOX OBS_STUDIO MP3INFO YOUTUBE_DL"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FIREFOX BRAVE VIVALDI EDGE LIBREWOLF"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE FIGMA"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"

# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "ROFI PLANK QT5CT FLATSEAL"

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
  sudo flatpak override --filesystem=xdg-data/themes
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

# B.3 Install Packages

# 🔵 B.3.2. Developer Tools
# 🧩 Install CODIUM
case "$CODIUM" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing CODIUM\e[0m\n"
  sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
  sudo zypper install -y codium
  printf "\n✅\e[1;32m CODIUM Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 Install VSCODE
case "$VSCODE" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing VSCODE\e[0m\n"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
  sudo zypper ref
  sudo zypper install -y code
  printf "\n✅\e[1;32m VSCODE Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 Install CODEOSS
installPackageFlatpack "$CODEOSS" "com.visualstudio.code-oss"
# 🧩 Install SUBLIME
case "$SUBLIME" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing SUBLIME\e[0m\n"
  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo zypper addrepo -g -f https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  sudo zypper ref
  sudo zypper install -y sublime-text
  printf "\n✅\e[1;32m SUBLIME Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 Install VIM
installPackage "$VIM" "vim"
# 🧩 Install NEOVIM
installPackage "$NEOVIM" "neovim"
# 🧩 Install DOCKER
case "$DOCKER" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing DOCKER\e[0m\n"
  sudo zypper update
  sudo zypper install docker-compose
  printf "\n✅\e[1;32m Docker Installed\e[0m\n"

  sudo systemctl enable docker
  sudo systemctl start docker
  printf "\n✅\e[1;32m Enable Docker\e[0m\n"

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
  sudo zypper install -y curl
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
# 🧩 Install YARN
installPackage "$YARN" "yarn"
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
# 🧩 CALIBRE
installPackage "$CALIBRE" calibre
# 🧩 FONTS
installPackage "$FONTS" "noto-fonts-emoji twemoji nerd-fonts noto-fonts-cjk unicode-emoji twemoji noto-fonts-emoji  noto-fonts-emoji"
# 🧩 TODOIST
installPackageFlatpack "$TODOIST" "com.todoist.Todoist"

# 📧 Mail
# 🧩 THUNDERBIRD
installPackage "$THUNDERBIRD" "thunderbird"
# 🧩 MAILSPRING
installPackageFlatpack "$MAILSPRING" "com.getmailspring.Mailspring"

# 🔵 B.3.4. Media
# 🧩 CODECS
case "$CODECS" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing CODECS\e[0m\n"
  installPackage "$CODECS" "opi ffmpeg ffmpegthumbs"
  opi codecs
  printf "\n✅\e[1;32m CODECS Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
installPackage "$AUDACIOUS" "audacious audacious-plugins"
# 🧩 VLC
installPackage "$VLC" "vlc"
# 🧩 MPV
installPackage "$MPV" "mpv"
# 🧩 CLEMENTINE
installPackage "$CLEMENTINE" "clementine"
# 🧩 Rhythmbox
installPackage "$RHYTHMBOX" "rhythmbox"
# 🧩 OBS_STUDIO
installPackage "$OBS_STUDIO" "obs-studio"
# 🧩 MP3INFO
installPackage "$MP3INFO" "mp3info"
# 🧩 YOUTUBE_DL
installPackage "$YOUTUBE_DL" "youtube-dl yt-dlp"

# 🔵 B.3.5. Browsers
# 🧩 UNGOOGLEDCHROMIUM
installPackageFlatpack "$UNGOOGLEDCHROMIUM" "com.github.Eloston.UngoogledChromium"
# 🧩 CHROMIUM
installPackage "$CHROMIUM" "chromium"
# 🧩 CHROME
case "$CHROME" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing Google Chrome\e[0m\n"
  sudo zypper addrepo http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
  sudo zypper refresh
  wget https://dl.google.com/linux/linux_signing_key.pub
  sudo rpm --import linux_signing_key.pub
  sudo zypper install -y --no-confirm google-chrome-stable
  printf "\n✅\e[1;32m Google Chrome Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 FIREFOX
installPackage "$FIREFOX" "firefox"
# 🧩 BRAVE
case "$BRAVE" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m curl\e[0m\n"
  sudo zypper install curl
  printf "\n📥 \e[1;32m Add Brave Browsers Repos\e[0m\n"
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  printf "\n📥 \e[1;32m Installing Brave Browsers\e[0m\n"
  sudo zypper install brave-browser
  printf "\n✅\e[1;32m Brave Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 LIBREWOLF
# installPackageFlatpack "$LIBREWOLF" "io.gitlab.librewolf-community"
case "$LIBREWOLF" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Add Librewolf Browsers Repos\e[0m\n"
  sudo zypper addrepo https://rpm.librewolf.net/librewolf-repo.repo
  printf "\n📥 \e[1;32m Installing Librewolf\e[0m\n"
  sudo zypper refresh
  sudo zypper install librewolf
  printf "\n✅\e[1;32m Librewolf Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 EDGE
case "$EDGE" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Add MS Edge Stable Browsers Repos and GPG key\e[0m\n"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo zypper ar https://packages.microsoft.com/yumrepos/edge microsoft-edge-stable
  printf "\n📥 \e[1;32m Installing MS Edge Stable\e[0m\n"
  sudo zypper refresh
  sudo zypper install microsoft-edge-stable
  printf "\n✅\e[1;32m MS Edge Stable Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 VIVALDI
case "$VIVALDI" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Add Vivaldi Browsers Repos\e[0m\n"
  sudo zypper ar https://repo.vivaldi.com/archive/vivaldi-suse.repo
  printf "\n📥 \e[1;32m Installing Vivaldi\e[0m\n"
  sudo zypper refresh
  sudo zypper install vivaldi-stable
  printf "\n✅\e[1;32m Vivaldi Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

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
case "$CMATRIX" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Add  utilities repo\e[0m\n"
  zypper addrepo https://download.opensuse.org/repositories/utilities/openSUSE_Factory/utilities.repo
  printf "\n📥 \e[1;32m Install cmatrix \e[0m\n"
  zypper refresh
  zypper install cmatrix
  printf "\n✅\e[1;32m cmatrix Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
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

# 👾 OTHER
# 🧩 ROFI
installPackage "$ROFI" "rofi"
# 🧩 PLANK
installPackage "$PLANK" "plank"
# 🧩 QT5CT
case "$QT5CT" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing qt5ct\e[0m\n"
  sudo zypper install -y qt5ct
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
