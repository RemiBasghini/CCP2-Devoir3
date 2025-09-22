# Mesures de sécurité, qualité et éco-conception

## 1. Sécurité
- **Variables sensibles** stockées dans `.env` (jamais en clair dans le code).
- Utilisation de **requêtes préparées PDO** pour éviter les injections SQL.
- Droits MySQL limités à un utilisateur spécifique (pas `root`).
- **Permissions serveur** : `750` sur les fichiers, propriétaire `www-data`.
- **Logs activés** mais `display_errors=Off` en production.
- `.htaccess` bloque l'accès aux fichiers sensibles.

## 2. Qualité
- Code organisé en plusieurs fichiers (`db.php`, `create.php`, `list.php`, etc.).
- Validation côté serveur des champs saisis (notes entre 0 et 10).
- Utilisation de `htmlspecialchars()` pour éviter le XSS.
- Ajout de messages d'erreur clairs pour l'utilisateur.

## 3. Éco-conception
- **Optimisation des requêtes SQL** : index sur clés primaires et étrangères.
- Code **simple et léger** sans dépendances inutiles.
- Possibilité d'héberger sur un petit serveur (empreinte énergétique réduite).
- Logs centralisés pour éviter une surcharge de stockage.
