#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Debian \e[0m\n\n"
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

# Install Package With Flatpack
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

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES EXPERIMENTAL_KERNEL INSTALL_PACKAGES"
for QUESTION in $QUESTIONS
	do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

# A.2. 🧰 Add ADD_REPOSITORIES
optionsList "$ADD_REPOSITORIES" "🧰 Repositories" "SANP FLATPAK"


# A.3 🛠️ Install Packages
optionsList "$INSTALL_PACKAGES" "🛠️ Choose Packages Categories"  "DESKTOP_ENVIRONMENT DEV_TOOLS OFFICE MEDIA BROWSERS PHOTO_EDITING TERMINAL OTHER"


# 🎨 A.3.1. Choose Desktop Environment
optionsList "$DESKTOP_ENVIRONMENT"   "🎨 Choose Desktop Environment(s)" "AWESOME BUDGIE CINNAMON GNOME KDE MATE XFCE"


# 👨‍💻 A.3.2 DEV_TOOLS
optionsList "$DEV_TOOLS" "👨‍💻  Choose Developer Tools" "WEBSTORM VSCODE CODIUM CODEOSS SUBLIME VIM DOCKER NODE NPM YARN GIT"

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
optionsList "$MEDIA" "📺  Choose Media Packages" "CODECS AUDACIOUS VLC MPV CLEMENTINE OBS_STUDIO MP3INFO YOUTUBE_DL FFMPEG"

# 🌐 A.3.5 Choose Browsers
optionsList "$BROWSERS" "🌐  Choose Browsers" "CHROMIUM CHROME FALKON FIREFOX BRAVE MIDORI VIVALDI EDGE WATERFOX LIBREWOLF"

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
    sudo apt update
    sudo apt install -y  snapd
    sudo snap install core
    sudo snap install hello-world
    sudo apt-get update -y
    sudo apt-get install -y gnome-software-plugin-snap
    printf "\n✅ \e[1;32m Reboot to use Sanp\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac
# Flatpak
case "$FLATPAK" in [yY] | [yY][eE][sS])
    printf "\n\n📥\e[1;32m  Adding Flatpak\e[0m\n"
    sudo apt install -y flatpak
    sudo apt install -y gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    printf "\n✅\e[1;32m flatpak\e[0m\n"
    ;;
    *)
    printf ""
    ;;
esac

# EXPERIMENTAL_KERNEL
case "$EXPERIMENTAL_KERNEL" in [yY] | [yY][eE][sS])
  printf "\n\n📥\e[1;32m  Installing EXPERIMENTAL_KERNEL\e[0m\n"
  echo "deb http://deb.debian.org/debian experimental main contrib non-free" | sudo tee -a /etc/apt/sources.list  
  echo "deb-src http://deb.debian.org/debian experimental main contrib non-free" | sudo tee -a /etc/apt/sources.list  
  sudo cat /etc/apt/sources.list
  sudo apt update -y
  sudo apt install -t experimental linux-image-amd64 -y
  sudo apt update -y 
  sudo apt upgrade -y
  uname -a
  printf "\n✅\e[1;32m EXPERIMENTAL_KERNEL\e[0m\n"
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
installPackage "$BUDGIE" " gnome-tweak-tool budgie-desktop-doc  budgie-desktop budgie-indicator-applet"
# 🧩 Install Cinnamon
installPackage "$CINNAMON" "cinnamon"
# 🧩 Install Gnome
installPackage "$GNOME" " gnome-session gnome-control-center gnome-panel gnome-shell-extensions nautilus gnome-tweak-tool chrome-gnome-shell"
# 🧩 Install KDE
installPackage "$KDE" "kde-standard"
# 🧩 Install MATE
installPackage "$MATE" " mate-core  mate-desktop-environment mate-menu mate-applet-brisk-menu mate-applets mate-tweak"
# 🧩 Install Xfce
installPackage "$XFCE" " task-xfce-desktop xfce4-clipman-plugin xfce4-systemload-plugin "

# 👨‍💻 B.3.2. Developer Tools
# 🧩 Install WEBSTORM
installPackageFlatpack "$WEBSTORM" "com.jetbrains.WebStorm"
# 🧩 Install CODIUM
case "$CODIUM" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing CODIUM\e[0m\n"
    printf "\n Add the GPG key of the repository \n"
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
    printf "\n Add the repository \n"
    echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
    printf "\n Update then install vscodium \n"
    sudo apt update
    sudo apt install codium
    printf "\n✅\e[1;32m CODIUM Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install VSCODE
case "$VSCODE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing VSCODE\e[0m\n"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update -y
    sudo apt install code -y
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
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update -y
    sudo apt install sublime-text -y
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
    sudo apt-get update -y
	sudo apt-get install -y \
	    ca-certificates \
	    curl \
	    gnupg \
	    lsb-release
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
	  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    printf "\n✅\e[1;32m DOCKER Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 Install NODE & NPM
case "$NODE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Nodejs & NPM\e[0m\n"
    curl -sL https://deb.nodesource.com/setup_16.x | sudo bash - && cat /etc/apt/sources.list.d/nodesource.list && sudo apt update && sudo apt -y install nodejs  && sudo npm install -g npm-check-updates 
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
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && sudo apt update && sudo apt install yarn -y
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
installPackage "$FONTS" "fonts-noto-color-emoji ttf-mscorefonts-installer ttf-ancient-fonts ttf-ancient-fonts-symbola"

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
case "$CHROME" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing Google Chrome\e[0m\n"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt-get --fix-broken install ./google-chrome-stable_current_amd64.deb
    rm -rf ./google-chrome-stable_current_amd64.deb
    printf "\n✅\e[1;32m Google Chrome Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 FALKON
installPackage  "$FALKON" "falkon"
# 🧩 FIREFOX
installPackage "$FIREFOX" "firefox-esr"
# 🧩 BRAVE
case "$BRAVE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing BRAVE\e[0m\n"
    sudo apt install apt-transport-https curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
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
    wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
    sudo add-apt-repository -y 'deb https://repo.vivaldi.com/archive/deb/ stable main'
    sudo apt update -y
    sudo apt install vivaldi-stable -y
    printf "\n✅\e[1;32m VIVALDI Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 EDGE
case "$EDGE" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing MS Edge\e[0m\n"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    sudo apt update
    sudo apt install microsoft-edge-dev -y
    printf "\n✅\e[1;32m MS Edge Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
# 🧩 WATERFOX
installPackage "$WATERFOX" "waterfox-g3"
# 🧩 LIBREWOLF
installPackageFlatpack "$LIBREWOLF" "io.gitlab.librewolf-community"

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

# 👾 OTHER
# 🧩 ROFI
installPackage "$ROFI" "rofi"
# 🧩 PLANK
installPackage  "$PLANK" "plank"
# 🧩 BALENA_ETCHER
case "$BALENA_ETCHER" in [yY] | [yY][eE][sS])
    printf "\n📥 \e[1;32m Installing BALENA_ETCHER\e[0m\n"
    curl -1sLf \
    'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
    | sudo -E bash
    sudo apt-get update
    sudo apt-get install balena-etcher-electron
    printf "\n✅\e[1;32m BALENA_ETCHER Installed\e[0m\n"
    ;;
  *)
    printf ""
    ;;
esac
