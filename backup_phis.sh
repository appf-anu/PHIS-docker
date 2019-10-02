#!/bin/bash
d=`date -Idate`
docker exec --user postgres -e PGPASSWORD=azerty -t phis-postgres pg_dump -h postgres -U phis phis > "$d.pgsql"
echo "postgres backup: "$(du -h "$d.pgsql")
rsync -ah --partial --info=progress2 --chmod "D2775,F665" "$d.pgsql" "gdd801@r-dm.nci.org.au:/g/data/xe2/appf/database-backups/phis/postgres/"
rm "$d.pgsql"

docker exec -it phis-mongodb mongodump --gzip --archive > $d.dump.gz
echo "mongodb backup: "$(du -h "$d.dump.gz")
rsync -ah --partial --info=progress2 --chmod "D2700,F600" "$d.dump.gz" "gdd801@r-dm.nci.org.au:/g/data/xe2/appf/database-backups/phis/mongodb"
rm "$d.dump.gz"

docker exec phis-rdf4j /bin/bash /tmp/backup-data.sh 
docker cp "phis-rdf4j:/tmp/phis.nt" $d.nt
docker exec -i phis-rdf4j rm "phis.nt"
echo ""
echo "rdf4j backup: "$(du -h "$d.nt")
rsync -ah --partial --info=progress2 --chmod "D2700,F600" "$d.nt" "gdd801@r-dm.nci.org.au:/g/data/xe2/appf/database-backups/phis/rdf4j"
rm "$d.nt"