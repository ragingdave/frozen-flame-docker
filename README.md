# Frozen Flame Dedicated Server

Hello and welcome! Hopefully this can help anyone get up and running with Frozen Flame!

Issues are welcome but pull requests are even more welcome if you can!

## Specials thanks

My work is based on the docker server of satisfactory from [wolveix](https://github.com/wolveix/satisfactory-server)

## Background

I spun this up initially because well like anyone else, I wanted to run a dedicated server, but there wasn't yet a Frozen Flame docker image.

This image is based on cm2network/steamcmd image and built out using a combination of help from the satisfactory and valheim images using the same base.

## Setup

For people who want to use [docker compose](https://docs.docker.com/compose/), you can just run `docker-compose up -d` in this repo after cloning, or by using the example `docker-compose.yml` file in this repo copied on it's own. Just be sure to change the volume mapping before starting up.

Or you can use a quick and dirty `docker run`:
```bash
run -d --net=host -v </path/to/config>:/home/steam/frozen-flame-dedicated/FrozenFlame/Saved --name=frozen-flame-dedicated ghcr.io/ragingdave/frozen-flame-docker:main 
```

It's worth noting that using docker-compose is the preferred method.

**NOTE: The server use the last Game.ini from https://github.com/DreamsideInteractive/FrozenFlameServer#configuration-file. Read the documentation for what you want change.**

## Environment Variables

| Parameter               |  Default  | Function                                            |
| ----------------------- | :-------: | --------------------------------------------------- |
| `SERVER_NAME` | `FrozenFlameServer` | set the name of the server in Frozen Flame          |
| `SERVERPASSWORD`        | `password`| Set server password                                 |
| `RCON_PASSWORD`         | `password`| Set Rcon password                                   |
| `MAXPLAYERS`            |    `10`   | set the player limit for your server                |
| `PGID`                  |   `1000`  | set the group ID of the user the server will run as |
| `PUID`                  |   `1000`  | set the user ID of the user the server will run as  |

The following options are only useful for advanced configurations where you would need to change the ports in the container itself and do not wish to use the simpler port mapping built into docker.

| Optional Parameter      |  Default  | Function                                            |
| ----------------------- | :-------: | --------------------------------------------------- |
| `SERVER_PORT`           |   `7779`  | Sets custom Game port. This is used by client to connect |
| `SERVER_QUERY_PORT`     |   `7780`  | Sets custom Query Port. Used by Steam to get server info |
| `RCON_PORT`             |   `27017` | Set Rcon port                                       |
