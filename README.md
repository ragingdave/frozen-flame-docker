<p align="center">
  <a href="https://github.com/ragingdave/frozen-flame-docker">
    <img alt="Frozen Flame Dedicated Server" src="assets/banner.jpg" height="250" style="border-radius: 10px;">
  </a>
  <p align="center">Dockerized Frozen Flame Dedicated Server.</p>
</p>

<div align="center">

![Github stars](https://badgen.net/github/stars/ragingdave/frozen-flame-docker?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/ragingdave/frozen-flame-docker?icon=github&label=forks) 
![Github issues](https://img.shields.io/github/issues/ragingdave/frozen-flame-docker)
![Github last-commit](https://img.shields.io/github/last-commit/ragingdave/frozen-flame-docker)

</div>

## Background
The creation of this image was motivated by the desire to establish a dedicated server for Frozen Flame, as there was previously no available Docker image. Utilizing the cm2network/steamcmd image as a foundation, this image was developed through the utilization of resources and guidance from the satisfactory and valheim images, all of which share the same base.

## Docker CLI
```sh
run -d --net=host -v </path/to/config>:/home/steam/frozen-flame-dedicated/FrozenFlame/Saved --name=frozen-flame-dedicated ghcr.io/ragingdave/frozen-flame-docker:main 
```

## Docker Compose
```yml
version: "3"
services:
  server:
    image: 'ghcr.io/ragingdave/frozen-flame-docker:main'
    network_mode: bridge
    volumes:
      - './saved:/home/steam/frozen-flame-dedicated/FrozenFlame/Saved'
    environment:
      - SERVER_NAME=FrozenFlameServer
    ports:
      - '25575:25575'
      - '27015:27015/udp'
      - '7777:7777/udp'
    restart: always
```

## Game.ini
> Upon initial launch of the server, it is necessary to generate the Game.ini file in order to implement various configurations, such as password protection. Detailed instructions on how to do so can be found at the following link: [How to](https://github.com/DreamsideInteractive/FrozenFlameServer#configuration-file)

## Note
> This is currently using the host network simplicity but you should be able to map the ports how you wish without it, but that's untested by me. The ports are exposed in the Dockerfile just not used here yet.
