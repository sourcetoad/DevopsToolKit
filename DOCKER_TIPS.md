# Docker Tips

## Typical Docker Commands

```bash
# Start all environments services
docker-compose up --build

# Restart a specific container
docker restart [service name]

# List all containers
docker ps -a

# List running containers
docker ps

# See used space
docker system df

# Remove un-used data
docker system prune
```

## Passwords

* MariaDB
  * `username: mariadb_user`
  * `password: mariadb_pass`

## Running Xdebug with PhpStorm alongside Docker
From Docker versions 18.03 and above, Docker creates a special DNS name that resolves
to the internal IP address used by the host.

* Old logic (that has not updated to special DNS name) will need to point to the IP of `10.254.254.254`.

```bash
sudo ifconfig lo0 alias 10.254.254.254
```
