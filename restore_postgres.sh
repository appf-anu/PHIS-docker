#bin/bash
cat $1 | docker exec -e PGPASSWORD=azerty -i phis-postgres psql -h postgres -U phis phis