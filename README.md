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

# Docker

## Data Source Services

```bash
git clone git@github.com:sourcetoad/DevopsToolKit.git devop-tools
./devop-tools/docker/data-source-services/network-creation.sh
cd ./devop-tools/docker/data-source-services && docker-compose up --build -d
```

### Windows
* Kill, and optionally disable, the `World Wide Web Publishing Service`
* Run `set COMPOSE_CONVERT_WINDOWS_PATHS=1` in your CMD or PowerShell terminal
* Optionally, [read](https://github.com/docker/compose/issues/4303#issuecomment-379563170) this bug report.
#### MinIO Setup - Local S3 Buckets
 * [Setting up MinIO for local development](docs/minio/README.md)

---

## Data Source Tools
* Optionally included is the following tools:
  * phpMyAdmin
  * Mailpit

```bash
cd ./devop-tools/docker/data-source-tools && docker-compose up --build -d
```

### phpMyAdmin
_For managing MySQL/MariaDB databases visually._

* Viewable at: http://localhost:8080
* It supports the following databases...
  * mariadb106 (lts)
  * mariadb1011 (lts)

### Mailpit
_For mimicking an email inbox (ala mailtrap) for local usage._

* Viewable at: http://localhost:8025
* Configurable in projects via `.env`
  * `MAIL_MAILER=smtp`
  * `MAIL_HOST=sourcetoad_mailpit`
  * `MAIL_PORT=1025`
  * `MAIL_USERNAME=null`
  * `MAIL_PASSWORD=null`
  * `MAIL_ENCRYPTION=null`

---

## Scripts
Inside the `scripts` folder you will find one-off scripts to help with tasks.

* `db_migrate.sh` - Helps migrate databases between versions of mysql.

## Docs
* [Hop](docs/hop/README.md)
* [Setting up Nginx-Proxy](docs/nginx-proxy/README.md)
* [Setting up PHP Testing in PhpStorm](docs/phpstorm-docker/README.md)
* [Leveraging Yii2 Shell](docs/yii2/yii-shell.md)
