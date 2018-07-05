echo "Creating container networks:\n"
docker network create nginx-proxy
docker network create st-mariadb-101
docker network create st-mysql-56
docker network create st-postgres-95
docker network create st-redis-32
