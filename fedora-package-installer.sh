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

# B. Process
