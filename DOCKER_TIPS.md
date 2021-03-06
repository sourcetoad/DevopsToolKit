## Typical Docker Commands
    ### Start all environments services
    > docker-compose up --build

    ### Restart a specific container
    > docker restart [service name]

    ### List all containers
    > docker ps -a

    ### List running containers
    > docker ps

    ### See used space
    > docker system df

    ### Remove un-used data
    > docker system prune

## Passwords
    ### PostgreSQL
    > username: postgres_user
    > password: postgres_pass

    ### MariaDB
    > username: mariadb_user
    > password: mariadb_pass


## Running Xdebug with PHPStorm alongside Docker.
From Docker versions 18.03 and above, Docker creates a special DNS name that resolves
to the internal IP address used by the host.

Old logic (that has not updated to special DNS name) will need to point to the IP of `10.254.254.254`.

```
sudo ifconfig lo0 alias 10.254.254.254
```
