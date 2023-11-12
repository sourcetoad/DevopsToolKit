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
  * mariadb106 (lts)
  * mariadb1011 (lts)

## Scripts
Inside the `scripts` folder you will find one-off scripts to help with tasks.

* `db_migrate.sh` - Helps migrate databases between versions of mysql.

## Git Scripts
Custom scripts that extend Git functionality, to streamline the process of tracking tickets and managing releases

### Installation
Either copy the scripts into your `PATH` or run the following command to add the scripts to your `PATH`
```shell
scripts/link-git-commands.sh
```
* This will link git scripts to a `bin` folder in your home directory. If you do not have a `bin` folder, it will create one for you.

`git-tickets`
---------
This command is used to get the tickets since staging was was last updated. By default it does not update the branches

```shell
git tickets [options] [arguments]
``` 

| Options  | Description                                                     | Default | Any of |
|----------|-----------------------------------------------------------------|---------|--------|
| --update | Update the specified branches from the remote before comparison |         |        |

| Arguments | Description                          | Default | Any of     |
|-----------|--------------------------------------|---------|------------|
| branch 1  | the target branch that is up to date | master  | any branch |
| branch 2  | the branch that is behind            | staging | any branch |

### Example
```shell
  git tickets --update master staging
```

`git-make-release`
---------
This command automates the process of preparing a new software release. It creates a release branch from the current branch, increments the version number, updates the `CHANGELOG.md`

```shell
    git make-release [options]
```

| Options  | Description                                               | Default |
|----------|-----------------------------------------------------------|---------|
| --dry    | Perform a dry run without any changes to branches or tags | N/A     |

### Example
```shell
git make-release --dry
```

## Docs
* [Setting up Nginx-Proxy](docs/nginx-proxy/README.md)
* [Setting up PHP Testing in PhpStorm](docs/phpstorm-docker/README.md)
* [Leveraging Yii2 Shell](docs/yii2/yii-shell.md)
