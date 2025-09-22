# Procédure de déploiement de l'application de notation de films

## 1. Préparation de l'environnement serveur

- Installer **Apache2**, **PHP 8+** et **MySQL/MariaDB** :

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 php php-mysql mysql-server git unzip -y
```

- Vérifier la version de PHP :
```bash
php -v
```

## 2. Configuration de la base de données

- Se connecter à MySQL :
```bash
sudo mysql -u root -p
```

- Créer la base et l'utilisateur dédié :
```sql
CREATE DATABASE notation_films;
CREATE USER 'notateur'@'localhost' IDENTIFIED BY 'motdepassefort';
GRANT ALL PRIVILEGES ON notation_films.* TO 'notateur'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

- Importer le schéma SQL :
```bash
mysql -u notateur -p notation_films < database.sql
```

## 3. Déploiement du code

- Cloner le dépôt GitHub :
```bash
cd /var/www/html
sudo git clone https://github.com/UTILISATEUR/notation-films-Devoir-2.git notation-films
sudo chown -R www-data:www-data notation-films
```

- Configurer les variables sensibles via un fichier .env :
```ini
DB_HOST=localhost
DB_NAME=notation_films
DB_USER=notateur
DB_PASS=motdepassefort
```

- Modifier db.php pour charger ces variables avec getenv().

## 4. Configuration de la sécurité

- Désactiver display_errors en production dans /etc/php/8.2/apache2/php.ini.

- Donner les bons droits :
```bash
sudo chmod -R 750 /var/www/html/notation-films
```

- Empêcher l'accès direct aux fichiers sensibles avec .htaccess :
```sql
<FilesMatch "\.(env|sql|sh)$">
  Order allow,deny
  Deny from all
</FilesMatch>
```

## 5. Surveillance et logs

- Activer les logs PHP :
```ini
error_log = /var/log/php_errors.log
```

- Vérifier régulièrement les journaux :
```bash
tail -f /var/log/apache2/error.log
```
