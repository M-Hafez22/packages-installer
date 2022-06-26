#! /usr/bin/bash

printf "\n\e[1;31m Welcome To Debian \e[0m\n\n"

# A. Ask
QUESTIONS="UPDATE ADD_REPOSITORIES INSTALL_PACKAGES"
for QUESTION in $QUESTIONS
	do
    read -p "Do you want to $QUESTION❔ y/n: " $QUESTION
done

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
