#!/bin/bash
echo "Déploiement de l'application notation-films..."

APP_DIR="/var/www/html/notation-films"
REPO="https://github.com/UTILISATEUR/notation-films-Devoir-2.git"
DB_NAME="notation_films"
DB_USER="notateur"
DB_PASS="motdepassefort"

# Installation des dépendances
sudo apt update && sudo apt install -y apache2 php php-mysql mysql-server git unzip

# Clonage du dépôt
if [ -d "$APP_DIR" ]; then
  echo "Mise à jour du dépôt existant..."
  cd $APP_DIR && git pull
else
  sudo git clone $REPO $APP_DIR
fi

# Droits
sudo chown -R www-data:www-data $APP_DIR
sudo chmod -R 750 $APP_DIR

# Base de données
mysql -u root -p <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Import du schéma
mysql -u $DB_USER -p$DB_PASS $DB_NAME < $APP_DIR/database.sql

echo "Déploiement terminé avec succès."
