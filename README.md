# keschrich/deluged Docker image
## Description
**keschrich/deluged** ([Docker Hub](https://hub.docker.com/r/keschrich/deluged), [GitHub](https://github.com/keschrich/docker_deluged)) is the Docker container running the **Deluge 1.3.15** BitTorrent client.

It is based on **keschrich/deluge-common** ([Docker Hub](https://hub.docker.com/r/keschrich/deluge-common), [GitHub](https://github.com/keschrich/docker_deluge-common)) and executes the *deluged* daemon process.

See **keschrich/deluge-web** ([Docker Hub](https://hub.docker.com/r/keschrich/deluge-web), [GitHub](https://github.com/keschrich/docker_deluge-web)) for corresponding container with deluge-web.

See the readme for keschrich/deluge-common for the rationale on *yet another* deluge container.
## Volumes
Two volumes are specified in the Dockerfile:
- /config <-- Deluge configuration dir
- /data <-- Torrents and in progress/completed downloads.

Alternatively, you can break */data* into separate volumes:
- /data/torrents
- /data/downloads
- /data/completed
## Ports
The following ports are exposed:
- 58846/tcp - Deluge console port
- 58946/tcp - BitTorrent incoming
- 58946/udp - BitTorrent incoming
## Environment Variables
- $DELUGE_ALLOW_REMOTE=[true|false] - Enable or disable remote connections to deluge console port
- $DELUGE_ADD_USER=*username* - Username to add to deluge *auth* file. User will be added with a level of 10. If specified, $DELUGE_ADD_PASS must also be specified!
- $DELUGE_ADD_PASS=*password* - Plaintext password for user added as above.
## Usage
    docker run -p 58846:58846 -p 58946:58946 -p 58946:58946/udp -v /host/deluge-config:/config -v /host/deluge-data:/data -e DELUGE_ALLOW_REMOTE=true -e DELUGE_ADD_USER=someuser -e DELUGE_ADD_PASS=somepass keschrich/deluged

Example docker-compose files running both services can be found here: [https://github.com/keschrich/docker_deluge-common/tree/master/examples](https://github.com/keschrich/docker_deluge-common/tree/master/examples).