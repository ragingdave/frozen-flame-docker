# Frozen Flame Dedicated Server

Hello and welcome! Hopefully this can help anyone get up and running with Frozen Flame!

Issues are welcome but pull requests are even more welcome if you can!

## Specials thanks

My work are based on the docker server of satisfactory from [wolveix](https://github.com/wolveix/satisfactory-server)

## Background

I spun this up initially because well like anyone else, I wanted to run a dedicated server, but there wasn't yet a Frozen Flame docker image.

This image is based on cm2network/steamcmd image and built out using a combination of help from the satisfactory and valheim images using the same base.

## Setup

For people who want use the image you can use [docker compose](https://docs.docker.com/compose/) up -d:
```yaml
version: "3.7"
services:
  frozen_flame:
    container_name: frozen-flame-server
    image: ghcr.io/ragingdave/frozen-flame-docker:main
    #network_mode: "host"
    volumes:
      - "/path/to/config:/config"
    ports:
      - 7779:7779
      - 7780:7780/udp
      - 27017:27017/udp
    expose:
      - 7779
      - 7780/udp
      - 27017/udp
    environment:
      - "SERVER_NAME=FrozenFlameServer"
      - "SERVER_QUERY_PORT=7780"
      - "SERVER_PORT=7779"
      - "RCON_PORT=27017"
      - "RCON_PASSWORD=password"
      - "MAXPLAYERS=10"
      - "SERVERPASSWORD=password"
      - "FREEPVP=true" #Enable PVP for non-friends
      - "DAYDURATION=3600" #How long a day lasts
      - "PUID=1000"
      - "PGID=1000"
      - "TZ=Etc/UTC"
    #tmpfs:
    #  - "/run:exec,mode=777"
    #  - "/tmp:exec,mode=777"
    restart: "unless-stopped"
```
You can use the safer way with ports forwarding, or the network mod host.

Or you can use a quick and dirty `docker run`:
```bash
run -d --net=host -v </path/to/config>:/home/steam/frozen-flame-dedicated/FrozenFlame/Saved --name=frozen-flame-dedicated ghcr.io/ragingdave/frozen-flame-docker:main 
```
This is currently using the host network simplicity but you should be able to map the ports how you wish without it, but that's untested by me.

**NOTE: The server use the last Game.ini from https://github.com/DreamsideInteractive/FrozenFlameServer#configuration-file. Read the documentation for what you want change.**

## Environment Variables

| Parameter               |  Default  | Function                                            |
| ----------------------- | :-------: | --------------------------------------------------- |
| `SERVER_NAME` | `FrozenFlameServer` | set the name of the server in Frozen Flame          |
| `SERVER_PORT`           |   `7779`  | Sets custom Game port. This is used by client to connect |
| `SERVER_QUERY_PORT`     |   `7780`  | Sets custom Query Port. Used by Steam to get server info |
| `SERVERPASSWORD`        | `password`| Set server password                                 |
| `RCON_PORT`             |   `27017` | Set Rcon port                                       |
| `RCON_PASSWORD`         | `password`| Set Rcon password                                   |
| `MAXPLAYERS`            |    `10`   | set the player limit for your server                |
| `PGID`                  |   `1000`  | set the group ID of the user the server will run as |
| `PUID`                  |   `1000`  | set the user ID of the user the server will run as  |
