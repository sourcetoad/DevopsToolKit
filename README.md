# Sourcetoad Internal Development Tools (SIDT)

Sourcetoad Internal Development Tools includes a growing collection of tutorials
for managing IDEs, hooking up tools with Docker and any combination of those 
things.

Additionally, this repository holds our data source services which is 
a collection of databases and other services that projects will more than likely 
need. It also provides a proxy setup via nginx-proxy so that multiple projects 
can be run at the same time without the need for different ports.

This means docker configurations for each project only needs to worry about the 
the language and other tools it may need, as the databases and other services are
standardized in this project. Since most cloud providers provide managed versions
of these services, you likely would not use a docker version of them in production.

## Docker

### devop-tools (data source services / domain tools)
1. Execute `git clone git@github.com:sourcetoad/DevopsToolKit.git devop-tools`
2. `cd devop-tools`
3. `cd ./docker/data-source-services/`
4. Execute `./network-creation.sh`
- If this fails, then manual configuration is necessary before compilation. Perform the following:
   1. `docker network create nginx-proxy`
   2. `docker network create st-mariadb-102`
   3. `docker network create st-mysql-56`
   4. `docker network create st-postgres-95`
   5. `docker network create st-redis-32`
5. Execute `docker-compose up --build`
- If you're in a Windows environment, then perform the following if your build fails:
   1. Kill, and optionally disable, the `World Wide Web Publishing Service`.
   2. Run `set COMPOSE_CONVERT_WINDOWS_PATHS=1` in your CMD or PowerShell terminal.
   3. Redo step `5` or follow more detailed steps [here](https://github.com/docker/compose/issues/4303#issuecomment-379563170).
6. Wait for the terminal to complete executing.
7. You now have Sourcetoad data sources running and logging to the console.

## Examples
Inside the `examples` folder you will find example Docker configurations for
popular frameworks like Laravel and Yii2.

The examples make the assumption that any domain used for local development is 
already added to the `/etc/hosts` file. You can edit to add `127.0.0.1 domain.docker`.

## Docs
 * [Setting up D4M-NFS](docs/d4m-nfs/README.md)
 * [Setting up Nginx-Proxy](docs/nginx-proxy/README.md)
 * [Setting up PHP Testing in PHPStorm](docs/phpstorm-docker/README.md)
 * [Setting up Python Debugging in Pycharm](docs/pycharm-debugging/README.md)
 * [Building a new Upsource Project](docs/upsource/README.md)

