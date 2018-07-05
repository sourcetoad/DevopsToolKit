# nginx-proxy

The data source services includes an application called nginx-proxy. This allows you to run multiple projects at the same time on different virtual hosts without port conflicts. You do not need to expose the webserver to the host machine through a port map.

In order for nginx-proxy to operate, you must follow the following steps.

## Setup hosts file
1. Choose a virtual host for your project. RFC-6761 recommends against using a .dev TLD, and instead using a .localhost TLD. Therefore, your domain might be mysite.localhost
2. Edit your hosts file and add this domain to your loopback address (127.0.0.1) using your preferred text editor. *make sure to use sudo*
```
sudo nano /etc/hosts

add:
127.0.0.1 mysite.localhost
```

## Setup docker-compose for project
1. In order for nginx-proxy to detect and proxy to the correct virtual host, you must first identify the container that is running the "web server." In a php project, this would be the nginx container, for example.
2. You will then add an environment variable of `VIRTUAL_HOST=mysite.localhost` to this service, place that service on the nginx-proxy network, and import that nginx-proxy network to the project. See the below snippet:

```
version: '2'
services:
    [APP_NAME]_nginx:
        image: nginx:latest
        environment:
            - VIRTUAL_HOST=mysite.localhost
```