echo "Creating container networks:\n"
docker network create st-internal
docker network create nginx-proxy
docker network create st-mariadb-102
docker network create st-postgres-95
docker network create st-redis-32
