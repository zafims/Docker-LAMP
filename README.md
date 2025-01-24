# docker-compose-lamp - lamp stack environment for developer

![screenshot](https://raw.githubusercontent.com/robertsaupe/docker-compose-lamp/master/.github/screenshot.png)

[Supporting](https://github.com/robertsaupe/docker-compose-lamp#supporting) |
[Features](https://github.com/robertsaupe/docker-compose-lamp#features) |
[License](https://github.com/robertsaupe/docker-compose-lamp#license) |
[Installing](https://github.com/robertsaupe/docker-compose-lamp#installing) |
[Getting started](https://github.com/robertsaupe/docker-compose-lamp#getting-started) |
[Credits](https://github.com/robertsaupe/docker-compose-lamp#credits)

## Features

- Apache with vhosts and SSL (<http://localhost> & <https://localhost>)
- PHP [Currently Supported Versions] (8.1.x, 8.2.x, 8.3.x)
- PHP [End of life / not recommended] (5.4.x, 5.6.x, 7.0.x, 7.1.x, 7.2.x, 7.3.x, 7.4.x, 8.0.x)
- MySQL (5.7, 8.x)
- MariaDB (lts, latest, 10.x, 10.3, 10.4, 10.5, 10.6, 10.7, 10.8, 10.9, 10.10, 10.11, 11.x, 11.0, 11.1, 11.2, 11.3-rc)
- phpMyAdmin
- XDebug
- Imagick
- Redis

## License

This software is distributed under the MIT license. Please read [LICENSE](LICENSE) for information.

## Installing

### German introduction / deutsche Einleitung

[blog.robertsaupe.de/docker-compose](https://blog.robertsaupe.de/docker-compose/)

### Requirements

- Debian/Ubuntu

```bash
sudo apt install docker
sudo apt install docker-compose
```

- Arch/Manjaro

```bash
sudo pacman -S docker
sudo pacman -S docker-compose
```

- Fedora

```bash
sudo dnf install docker
sudo dnf install docker-compose
```

- macOS
  - Install Docker Desktop according to [these instructions](https://docs.docker.com/desktop/mac/install/).

- Windows
  - Install Docker Desktop according to [these instructions](https://docs.docker.com/desktop/windows/install/).

### Service (Linux)

```bash
sudo systemctl start docker.service
sudo systemctl enable docker.service
```

### Run without root (Linux)

```bash
sudo usermod -aG docker $USER
sudo reboot
```

### Environment

```bash
git clone https://github.com/robertsaupe/docker-compose-lamp.git
cd docker-compose-lamp/
cp sample.env .env

### modify .env as needed

### builds and starts the environment:
./build.sh

### starts the environment:
./start.sh

### stops the environment:
./stop.sh
```

#### on Windows (with WSL) Explorer

```cmd
### builds and starts the environment:
build.cmd

### starts the environment:
start.cmd

### stops the environment:
stop.cmd
```

## Getting started

### Visit

#### insecure

- Dashboard
  - [http://localhost](http://localhost)

- phpMyAdmin
  - [http://localhost:8080](http://localhost:8080)

phpMyAdmin is configured to run on port 8080. Use following default credentials.

http://localhost:8080/  
username: root  
password: tiger

- virtual domains
  - [http://dash.localhost](http://dash.localhost)
  - [http://app.localhost](http://app.localhost)
  - [http://projects.localhost](http://projects.localhost)

##### secure

- Dashboard
  - [https://localhost](https://localhost)

- phpMyAdmin
  - [https://localhost:8443](https://localhost:8443)

- virtual domains
  - [https://dash.localhost](https://dash.localhost)
  - [https://app.localhost](https://app.localhost)
  - [https://projects.localhost](https://projects.localhost)

In order to use the above URL, you still need to change the hosts file.

### SSL (HTTPS)

Support for https domains is built-in and enabled by default.

### Virtual-Hosts

#### Linux/macOS

```bash
sudo nano /etc/hosts
```

#### Windows

You can just use Notepad for this. To do this, right-click on "Run as administrator" in the start menu. Then go to Open, show all files and navigate to the folder **C:\Windows\System32\drivers\etc**. Now you can open and edit the **hosts** file.

#### hosts-file

```text
...
127.0.0.1  dash.localhost
127.0.0.1  projects.localhost
127.0.0.1  app.localhost
...
```

### Database

#### PHP Access

```php
<?php
//some before
$db_hostname="database";
//some after
?>
```

#### MYSQL_INITDB_DIR

```text
When a container is started for the first time files in this directory with the extensions:
.sh, .sql, .sql.gz and .sql.xz
will be executed in alphabetical order.

default location is ./config/initdb
```

### Xdebug

Xdebug comes installed by default and it's version depends on the PHP version chosen in the `".env"` file.

**Xdebug versions:**

PHP <= 7.3: Xdebug 2.X.X

PHP >= 7.4: Xdebug 3.X.X

To use Xdebug you need to enable the settings in the `./config/php/php.ini` file according to the chosen version PHP.

Example:

```text
# Xdebug 2
#xdebug.remote_enable=1
#xdebug.remote_autostart=1
#xdebug.remote_connect_back=1
#xdebug.remote_host = host.docker.internal
#xdebug.remote_port=9000

# Xdebug 3
#xdebug.mode=debug
#xdebug.start_with_request=yes
#xdebug.client_host=host.docker.internal
#xdebug.client_port=9003
#xdebug.idekey=VSCODE
```

Xdebug VS Code: you have to install the Xdebug extension "PHP Debug". After installed, go to Debug and create the launch file so that your IDE can listen and work properly.

Example:

**VERY IMPORTANT:** the `pathMappings` depends on how you have opened the folder in VS Code. Each folder has your own configurations launch, that you can view in `.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for Xdebug",
      "type": "php",
      "request": "launch",
      // "port": 9000, // Xdebug 2
      "port": 9003, // Xdebug 3
      "pathMappings": {
        // "/var/www/html": "${workspaceFolder}/www" // if you have opened VSCODE in root folder
        "/var/www/html": "${workspaceFolder}" // if you have opened VSCODE in ./www folder
      }
    }
  ]
}
```

Now, make a breakpoint and run debug.

**Tip!** After theses configurations, you may need to restart container.

### Redis

It comes with Redis. It runs on default port `6379`.

## Why you shouldn't use this stack unmodified in production

We want to empower developers to quickly create creative Applications. Therefore we are providing an easy to set up a local development environment for several different Frameworks and PHP Versions.
In Production you should modify at a minimum the following subjects:

- php handler: mod_php=> php-fpm
- secure mysql users with proper source IP limitations

_**PHP_INI**_
Define your custom `php.ini` modification to meet your requirments.

---

#### Apache

---

_**DOCUMENT_ROOT**_

It is a document root for Apache server. The default value for this is `./www`. All your sites will go here and will be synced automatically.

_**APACHE_DOCUMENT_ROOT**_

Apache config file value. The default value for this is /var/www/html.

_**VHOSTS_DIR**_

This is for virtual hosts. The default value for this is `./config/vhosts`. You can place your virtual hosts conf files here.

> Make sure you add an entry to your system's `hosts` file for each virtual host.

_**APACHE_LOG_DIR**_

This will be used to store Apache logs. The default value for this is `./logs/apache2`.

---
#### Database

---

> For Apple Silicon Users:
> Please select Mariadb as Database. Oracle doesn't build their SQL Containers for the arm Architecture

_**DATABASE**_

Define which MySQL or MariaDB Version you would like to use.

_**MYSQL_INITDB_DIR**_

When a container is started for the first time files in this directory with the extensions `.sh`, `.sql`, `.sql.gz` and
`.sql.xz` will be executed in alphabetical order. `.sh` files without file execute permission are sourced rather than executed.
The default value for this is `./config/initdb`.

_**MYSQL_DATA_DIR**_

This is MySQL data directory. The default value for this is `./data/mysql`. All your MySQL data files will be stored here.

_**MYSQL_LOG_DIR**_

This will be used to store Apache logs. The default value for this is `./logs/mysql`.

## Web Server

Apache is configured to run on port 80. So, you can access it via `http://localhost`.

#### Apache Modules

By default following modules are enabled.

- rewrite
- headers

> If you want to enable more modules, just update `./bin/phpX/Dockerfile`. You can also generate a PR and we will merge if seems good for general purpose.
> You have to rebuild the docker image by running `docker compose build` and restart the docker containers.

#### Connect via SSH

You can connect to web server using `docker compose exec` command to perform various operation on it. Use below command to login to container via ssh.

```shell
docker compose exec webserver bash
```

## PHP

The installed version of php depends on your `.env`file.

#### Extensions

By default following extensions are installed.
May differ for PHP Versions <7.x.x

- mysqli
- pdo_sqlite
- pdo_mysql
- mbstring
- zip
- intl
- mcrypt
- curl
- json
- iconv
- xml
- xmlrpc
- gd

> If you want to install more extension, just update `./bin/webserver/Dockerfile`. You can also generate a PR and we will merge if it seems good for general purpose.
> You have to rebuild the docker image by running `docker compose build` and restart the docker containers.
> ## SSL (HTTPS)

Support for `https` domains is built-in but disabled by default. There are 3 ways you can enable and configure SSL; `https` on `localhost` being the easiest. If you are trying to recreating a testing environment as close as possible to a production environment, any domain name can be supported with more configuration.

**Notice:** For every non-localhost domain name you wish to use `https` on, you will need to modify your computers [hosts file](https://en.wikipedia.org/wiki/Hosts_%28file%29) and point the domain name to `127.0.0.1`. If you fail to do this SSL will not work and you will be routed to the internet every time you try to visit that domain name locally.

### 1) HTTPS on Localhost

To enable `https` on `localhost` (https://localhost) you will need to:

1. Use a tool like [mkcert](https://github.com/FiloSottile/mkcert#installation) to create an SSL certificate for `localhost`:
   - With `mkcert`, in the terminal run `mkcert localhost 127.0.0.1 ::1`.
   - Rename the files that were generated `cert.pem` and `cert-key.pem` respectively.
   - Move these files into your docker setup by placing them in `config/ssl` directory.
2. Uncomment the `443` vhost in `config/vhosts/default.conf`.

Done. Now any time you turn on your LAMP container `https` will work on `localhost`.

### 2) HTTPS on many Domains with a Single Certificate

If you would like to use normal domain names for local testing, and need `https` support, the simplest solution is an SSL certificate that covers all the domain names:

1. Use a tool like [mkcert](https://github.com/FiloSottile/mkcert#installation) to create an SSL certificate that covers all the domain names you want:
   - With `mkcert`, in the terminal run `mkcert example.com "*.example.org" myapp.dev localhost 127.0.0.1 ::1` where you replace all the domain names and IP addresses to the ones you wish to support.
   - Rename the files that were generated `cert.pem` and `cert-key.pem` respectively.
   - Move these files into your docker setup by placing them in `config/ssl` directory.
2. Uncomment the `443` vhost in `config/vhosts/default.conf`.

Done. Since you combined all the domain names into a single certificate, the vhost file will support your setup without needing to modify it further. You could add domain specific rules if you wish however. Now any time you turn on your LAMP container `https` will work on all the domains you specified.

### 3) HTTPS on many Domain with Multiple Certificates

If you would like your local testing environment to exactly match your production, and need `https` support, you could create an SSL certificate for every domain you wish to support:

1. Use a tool like [mkcert](https://github.com/FiloSottile/mkcert#installation) to create an SSL certificate that covers the domain name you want:
   - With `mkcert`, in the terminal run `mkcert [your-domain-name(s)-here]` replacing the bracket part with your domain name.
   - Rename the files that were generated to something unique like `[name]-cert.pem` and `[name]-cert-key.pem` replacing the bracket part with a unique name.
   - Move these files into your docker setup by placing them in `config/ssl` directory.
2. Using the `443` example from the vhost file (`config/vhosts/default.conf`), make new rules that match your domain name and certificate file names.

Done. The LAMP container will auto pull in any SSL certificates in `config/ssl` when it starts. As long as you configure the vhosts file correctly and place the SSL certificates in `config/ssl`, any time you turn on your LAMP container `https` will work on your specified domains.
