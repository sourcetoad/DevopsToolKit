# Sourcetoad Internal Development Tools (SIDT)

[![GitHub Super-Linter](https://github.com/sourcetoad/DevopsToolKit/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

Sourcetoad Internal Development Tools includes a growing collection of tutorials
for managing IDEs, hooking up tools with Docker and any combination of those
things.

Additionally, this repository holds our data source services which is
a collection of databases and other services that projects will more than likely
need. It also provides a proxy setup via nginx-proxy so that multiple projects
can be run at the same time without the need for different ports.

This means docker configurations for each project only needs to worry about the
language and other tools it may need, as the databases and other services are
standardized in this project. Since most cloud providers provide managed versions
of these services, you likely would not use a docker version of them in production.

## Docker

### Required: data source services

```bash
git clone git@github.com:sourcetoad/DevopsToolKit.git devop-tools
./devop-tools/docker/data-source-services/network-creation.sh
cd ./devop-tools/docker/data-source-services && docker-compose up --build -d
```

#### Specific Setup - Windows
 * Kill, and optionally disable, the `World Wide Web Publishing Service`
 * Run `set COMPOSE_CONVERT_WINDOWS_PATHS=1` in your CMD or PowerShell terminal
 * Optionally, [read](https://github.com/docker/compose/issues/4303#issuecomment-379563170) this bug report.

### Optional: Data Source Tools
* Optionally included is the following tools:
  * phpMyAdmin
* `cd ./devop-tools/docker/data-source-tools && docker-compose up --build -d`

## phpMyAdmin
If the optional tools are launched, you can find phpMyAdmin at: localhost:8080
  * It supports the following databases...
    * mariadb102 (deprecated)
    * mariadb103
    * mariadb104
    * mariadb105

## Examples
Inside the `examples` folder you will find example Docker configurations for
popular frameworks like Laravel and Yii2.

The examples make the assumption that any domain used for local development is
already added to the `/etc/hosts` file. You can edit to add `127.0.0.1 domain.docker`.

## Scripts
Inside the `scripts` folder you will find one-off scripts to help with tasks.

 * `db_migrate.sh` - Helps migrate databases between versions of mysql.

## Docs
 * [Setting up Nginx-Proxy](docs/nginx-proxy/README.md)
 * [Setting up PHP Testing in PHPStorm](docs/phpstorm-docker/README.md)
 * [Leveraging Yii2 Shell](docs/yii2/yii-shell.md)
