#!/usr/bin/env bash
 
# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo "Witaj w CodersLab!"
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "oraz skonfiguruje bazę danych MySQL. W tym czasie na ekranie pojawi się wiele"
echo "komunikatów. ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU"
echo "W TRAKCIE TRWANIA INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

# pausing updating grub as it might triger ui
sudo apt-mark hold grub*
 
echo "Aktualizuję system..."

# update / upgrade
sudo apt update
sudo apt -y upgrade
 
echo "Instaluję narzędzia systemowe..."

# install all used tools
sudo apt install -y curl vim git virtualenv mysql-workbench
  

echo "Instaluję bazę danych MySQL..."

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt install -y mysql-server
 
echo "Instaluję serwer poczty Postfix..."

# install postfix
sudo debconf-set-selections <<< "postfix postfix/mailname string $HOSTNAME"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt install -y postfix

echo "Tworzę katalog roboczy..."
# creating and linkng Workspace
sudo mkdir ~/workspace
sudo chmod 777 ~/workspace
# sudo rm -r /var/www/html
# sudo ln -s ~/Workspace /var/www/html
sudo chmod 777 -R ~/workspace


echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
sudo apt update -y
sudo apt upgrade -y


# TODO: install Eclipse
# install NetBeans
# wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-php-linux-x64.sh
# chmod 777 ./netbeans-8.1-php-linux-x64.sh
# ./netbeans-8.1-php-linux-x64.sh --silent
# rm ./netbeans-8.1-php-linux-x64.sh

# unpausing updating grub
sudo apt-mark unhold grub*
