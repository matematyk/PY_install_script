#!/usr/bin/env bash
# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'
echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych MySQL."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."
echo
echo "Instaluję narzędzia konsolowe..."
# install Command Line Tools for Xcode
xcode-select --install
echo
echo "Instaluję homebrew..."
# install brew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo -e '\nexport PATH=/opt/homebrew/bin:$PATH\n' >> ~/.zshrc
echo
echo "Dodaję niezbędne repozytoria homebrew..."
# add external taps
# brew tap homebrew/dupes #deprecated
# brew tap homebrew/versions #deprecated
brew tap homebrew/services
brew tap homebrew/cask-versions
echo
echo "Instaluję narzędzia systemowe..."
# install all used tools
# brew tap caskroom/cask
# brew install caskroom/cask/brew-cask
# brew install homebrew/completions/brew-cask-completion #deprecated
brew install pip3
brew install curl vim git python3 wget screen
pip3 install --user virtualenv termcolor pycodestyle
brew install --cask oracle-jdk-javadoc
echo
echo "Instaluję PostgreSQL..."
# install pgsql
brew install --cask sqlpro-for-postgres
# start service
brew services start sqlpro-for-postgres
sleep 15
# change password
createuser postgres
createdb coderslab
psql -c "ALTER USER postgres WITH PASSWORD '${PASSWORD}';"
# ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
echo
echo "Instaluję PyCharm"
brew install --cask pycharm
echo
echo "Tworzę katalog roboczy..."
# creating and linkng Workspace
sudo mkdir ~/workspace
sleep 3
sudo chmod 777 -R ~/workspace
echo
echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
brew update
brew upgrade
echo "#############################"
echo "####INSTALACJA ZAKOŃCZONA####"
echo "#############################"
