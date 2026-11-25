
# EduTech Campus - Infrastructure Linux et DevSecOps

Projet 420-3R4-VL, Cégep de Valleyfield.

## Architecture
- gladisserver : Ubuntu Server 26.04 (pare-feu UFW, SSH par clés, Fail2ban, BIND9, DHCP, Docker)
- gladisclient : poste client sur le LAN interne 10.10.10.0/24
- Pile Docker : Nginx (reverse proxy TLS), portail web, API, MySQL isolée, Prometheus, Node Exporter, cAdvisor, Grafana

## Contenu du dépôt
- docker/ : docker-compose.yml, docker-compose.override.yml, nginx/, prometheus/, html/
- scripts/backup.sh : sauvegarde chiffrée (AES-256) de MySQL et des volumes Docker
- config/ : planification cron et rotation du journal d'audit

## Déploiement
1. Créer le fichier mysql.env (MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD). Il n'est pas versionné.
2. Générer un certificat auto-signé dans docker/nginx/certs (non versionné) avec openssl.
3. Lancer : sudo docker compose up -d

## Sauvegarde
Le script scripts/backup.sh exporte la base MySQL, archive les volumes Docker, chiffre le tout avec une clé locale et écrit une ligne dans un journal d'audit. Il est planifié chaque nuit à 2 h par cron.

## Sécurité
