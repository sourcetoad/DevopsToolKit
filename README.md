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
cd ./devop-tools/docker/data-source-services && docker compose up --build -d
```

### Windows
* Kill, and optionally disable, the `World Wide Web Publishing Service`
* Run `set COMPOSE_CONVERT_WINDOWS_PATHS=1` in your CMD or PowerShell terminal
* Optionally, [read](https://github.com/docker/compose/issues/4303#issuecomment-379563170) this bug report.

---

## Data Source Tools
* Optionally included is the following tools:
  * phpMyAdmin
  * Mailpit
  * MinIO

```bash
cd ./devop-tools/docker/data-source-tools && docker compose up --build -d
```

### phpMyAdmin
_For managing MySQL/MariaDB databases visually._

* Viewable at: http://localhost:8080
* It supports the following databases...
  * mariadb1011 (lts, deprecated)
  * mariadb1104 (lts)

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

### MinIO
_For running an S3 service locally._

* Edit the `/etc/hosts` file on your system and make a reference for `127.0.0.1 s3.docker`
* Open the admin console http://s3.docker:10001 and login.
  * username: root
  * password: password
* Create an appropriate bucket for each project as needed.
* Modify the project's `.env` as follows:
  * `FILESYSTEM_DRIVER=s3`
  * `AWS_ACCESS_KEY_ID=root`
  * `AWS_SECRET_ACCESS_KEY=password`
  * `AWS_DEFAULT_REGION=us-east-1`
  * `AWS_BUCKET=[project-bucket-name]`
  * `AWS_ENDPOINT=http://s3.docker:10000`
  * `AWS_USE_PATH_STYLE_ENDPOINT=true`

---

## Scripts

Inside the `scripts` folder you will find one-off scripts to help with tasks.

* `db_migrate.sh` - Helps migrate databases between versions of mysql.

## CLI Tooling Setup

Add the `bin` directory to your path to use **Hop** and **Git Scripts**.

## Hop

A script that makes it easy to hop into your project containers and run commands.

## Git Scripts

Custom scripts that extend Git functionality, to streamline the process of tracking tickets and managing releases

### `git-tickets`

This command is used to get the tickets since staging was last updated.
By default, it does not update the branches.

```shell
git tickets [options] [arguments]
```

| Options  | Description                                                     | Default |
|----------|-----------------------------------------------------------------|---------|
| --update | Update the specified branches from the remote before comparison | N/A     |

| Arguments | Description                          | Default | Any of     |
|-----------|--------------------------------------|---------|------------|
| branch 1  | the target branch that is up to date | master  | any branch |
| branch 2  | the branch that is behind            | staging | any branch |

### Tickets Example

```shell
  git tickets --update master staging
```

### `git-make-release`

This command automates the process of preparing a new software release.
It creates a release branch from the current branch, increments the version number, updates the `CHANGELOG.md`

```shell
    git make-release [options]
```

| Options | Description                                               | Default |
|---------|-----------------------------------------------------------|---------|
| --dry   | Perform a dry run without any changes to branches or tags | N/A     |

### Make Release Example

```shell
git make-release --dry
```

## Docs

* [Hop](docs/hop/README.md)
* [Setting up Nginx-Proxy](docs/nginx-proxy/README.md)
* [Setting up PHP Testing in PhpStorm](docs/phpstorm-docker/README.md)
* [Leveraging Yii2 Shell](docs/yii2/yii-shell.md)
