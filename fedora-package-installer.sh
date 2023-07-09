#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Fedora \e[0m\n\n"

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

# Install Config dnf
function configDnf() {
  case "$1" in [yY] | [yY][eE][sS])
    printf "\n\n\e[1;34m $2\e[0m\n"
    sudo echo $3 | sudo tee -a /etc/dnf/dnf.conf
    cat /etc/dnf/dnf.conf
    printf "\n\e[1;34m  $2\e[0m\n"
    ;;
  *)
    printf ""
    ;;
  esac
}

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
QUESTIONS="UPDATE ADD_REPOSITORIES CONFIG_DNF INSTALL_PACKAGES"
for QUESTION in $QUESTIONS; do
  read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. 🧰 Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "FUSION SANP FLATPAK"

# A.3 CONFIG_DNF
optionsList "$CONFIG_DNF" "Config dnf" "FASTEST_MIRROR DELTA_RPM  PARALLEL_DOWNLOADS  DEFAULT_YES"

# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories" "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MESSAGING MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"

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

# 💬 A.3.3 Choose Messaging
optionsList "$MESSAGING" "💬  Choose Messaging Packages" "SIGNAL WHATSAPP"

# 📝 A.3.3 Choose Office
optionsList "$OFFICE" "📝  Choose Office Packages" "LIBREOFFICE CALIBRE OKULAR THUNDERBIRD MAILSPRING"

# 📺 A.3.4 Choose Media
optionsList "$MEDIA" "📺  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE RHYTHMBOX OBS_STUDIO YOUTUBE_DL"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM UNGOOGLEDCHROMIUM CHROME FALKON FIREFOX BRAVE MIDORI VIVALDI EDGE LIBREWOLF"

# 🖼️ A.3.6 Choose PHOTO_EDITING
optionsList "$PHOTO_EDITING" "🖼️  Choose Photo Editing" "GIMP INKSCAPE"

# 💻 A.3.7 Choose Terminal
optionsList "$TERMINAL" "💻  Choose TERMINAL" "BPYTOP HTOP SL CMATRIX LOLCAT NEOFETCH TREE TERMINATOR ZSH RETRO_TERM"

# 👾 A.3.8 Choose OTHER
optionsList "$OTHER" "👾  Choose OTHER" "ROFI PLANK QT5CT"

# B. Process

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
  sudo flatpak override --filesystem=xdg-data/themes
  printf "\n✅\e[1;32m flatpak\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac

# Config dnf
# 🧩 FASTEST_MIRROR
configDnf "$FASTEST_MIRROR" "Set Fastest Mirror" 'fastestmirror=true'
# 🧩 DELTA_RPM
configDnf "$DELTA_RPM" "Set Delta rpm" 'deltarpm=true'
# 🧩 PARALLEL_DOWNLOADS
configDnf "$PARALLEL_DOWNLOADS" "Set parallel downloads" 'max_parallel_downloads=5'
# 🧩 DEFAULT_YES
configDnf "$DEFAULT_YES" "Set dnf default to Yes" 'defaultyes=True'

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
installPackage "$CINNAMON" "@cinnamon-desktop-environment copyq "
# 🧩 Install Gnome
case "$GNOME" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing Gnome\e[0m\n"
  sudo dnf group install -y "GNOME Desktop Environment" && sudo dnf install -y gnome-tweaks gnome-extensions-app
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
# 🧩 Install CODIUM
case "$CODIUM" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing CODIUM\e[0m\n"
  printf "\n Add the GPG key of the repository \n"
  sudo rpmkeys -y --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "\n Add the repository \n"
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  printf "\n Update then install vscodium \n"
  sudo dnf install codium -y
  printf "\n✅\e[1;32m CODIUM Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
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
# 🧩 Install CODEOSS
installPackageFlatpack "$CODEOSS" "com.visualstudio.code-oss"
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
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  printf "\n✅\e[1;32m DOCKER Installed\e[0m\n"
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
# 🧩 Install NODE & NPM
case "$NVM" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing NVM & Nodejs & NPM\e[0m\n"
  sudo dnf install curl -y
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  source ~/.bashrc
  source ~/.zshrc
  nvm install node --lts
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
  installPackage "$GIT" "git git-subtree"
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

# 🔵 B.3.3. Office
# 🧩 LIBREOFFICE
installPackage "$LIBREOFFICE" "libreoffice"
# 🧩 CALIBRE
installPackage "$CALIBRE" "calibre"
# 🧩 SIGNAL
installPackageFlatpack "$SIGNAL" "org.signal.Signal"
# 🧩 OKULAR
installPackage "$OKULAR" "okular"
# 🧩 THUNDERBIRD
installPackage "$THUNDERBIRD" "thunderbird"
# 🧩 MAILSPRING
installPackageFlatpack "$MAILSPRING" "com.getmailspring.Mailspring"

# 💬 A.3.3 Choose Messaging
# 🧩 SIGNAL
installPackageFlatpack "$SIGNAL" "org.signal.Signal"
# 🧩 WHATSAPP
installPackageFlatpack "$WHATSAPP" "io.github.mimbrero.WhatsAppDesktop"

# 🔵 B.3.4. Media
# 🧩 CODECS
case "$CODECS" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing Media CODECS\e[0m\n"
  # sudo dnf groupupdate multimedia --setop="install\*weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y && sudo dnf groupupdate sound-and-video -y
  sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
  sudo dnf install -y lame\* --exclude=lame-devel
  sudo dnf group upgrade --with-optional Multimedia
  sudo dnf install -y ffmpegthumbs
  sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf -y install ffmpeg && sudo dnf -y install ffmpeg-devel
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
# 🧩 Rhythmbox
installPackage "$RHYTHMBOX" "rhythmbox"

# 🔵 B.3.5. Browsers
# 🧩 UNGOOGLEDCHROMIUM
installPackageFlatpack "$UNGOOGLEDCHROMIUM" "com.github.Eloston.UngoogledChromium"
# case "$UNGOOGLEDCHROMIUM" in [yY] | [yY][eE][sS])
#     printf "\n📥 \e[1;32m Installing Ungoogled Chrome\e[0m\n"
#     sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/ungoogled_chromium/Fedora_35/home:ungoogled_chromium.repo
#     sudo dnf install ungoogled-chromium
#     printf "\n✅\e[1;32m Ungoogled Chrome Installed\e[0m\n"
#     ;;
#   *)
#     printf ""
#     ;;
# esac
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
installPackage "$FALKON" "falkon"
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
  printf "\n📥 \e[1;32m Installing MS Edge Stable\e[0m\n"
  sudo dnf install dnf-plugins-core -y
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo dnf -y config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
  Adding repo from: https://packages.microsoft.com/yumrepos/edge
  sudo dnf update --refresh
  sudo dnf install -y microsoft-edge-stable
  microsoft-edge -version
  printf "\n✅\e[1;32m MS Edge Stable Installed\e[0m\n"
  ;;
*)
  printf ""
  ;;
esac
# 🧩 LIBREWOLF
case "$LIBREWOLF" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing Librewolf\e[0m\n"
  sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
  sudo dnf install librewolf
  printf "\n✅\e[1;32m Librewolf Installed\e[0m\n"
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
installPackage "$PLANK" "plank"
# 🧩 QT5CT
case "$QT5CT" in [yY] | [yY][eE][sS])
  printf "\n📥 \e[1;32m Installing qt5ct\e[0m\n"
  sudo dnf install -y qt5ct
  printf "\n✅\e[1;32m qt5ct Installed\e[0m\n"

  printf "\n\e[1;32m Set environment variables in ~/.profile\e[0m\n"
  echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' >>~/.profile
  ;;
*)
  printf ""
  ;;
esac
