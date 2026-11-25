cd /home/gladis/backups
mkdir -p tmp
docker exec edutech-db-1 sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --all-databases' > tmp/db.sql
tar czf tmp/volumes.tar.gz /var/lib/docker/volumes/edutech_dbdata /var/lib/docker/volumes/edutech_grafanadata
tar czf - tmp | openssl enc -aes-256-cbc -pbkdf2 -pass file:/home/gladis/.backup.key -out backup-$(date +%F).enc
rm -rf tmp
echo "$(date) sauvegarde OK" >̾> audit.log ̾


