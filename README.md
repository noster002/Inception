# Inception
42 School - Level05

An infrastructure composed of different services under specific rules

The project was set up on a virtual machine on Ubuntu to test it.

## Rules

+ Set up __docker-compose__ with different services.
+ Each service has their own __Dockerfile__.
+ The containers must be built either from the penultimate stable version of __Alpine__ or __Debian__.
+ It is forbidden to pull ready-made Docker images (__Alpine__/__Debian__ being excluded from this rule).

#### Services
+ NGINX with TLSv1.2 or TLSv1.3 only
+ WordPress + php-fpm (without nginx)
+ mariadb (without ngnix)

#### Volumes
+ WordPress database
+ WordPress website files

+ The volumes will be available in the `/home/<login>/data` folder of the host machine.

#### Network
+ Docker-network

+ The NGINX container must be the only entrypoint into your infrastructure via the port 443
