# Frozen Flame Dedicated Server

Hello and welcome! Hopefully this can help anyone get up and running with Frozen Flame!

Issues are welcome but pull requests are even more welcome if you can!

## Background

I spun this up initially because well like anyone else, I wanted to run a dedicated server, but there wasn't yet a Frozen Flame docker image.

This image is based on cm2network/steamcmd image and built out using a combination of help from the satisfactory and valheim images using the same base.

## Setup

You can use really whatever method you want to get up and running, but I originally just used a quick and dirty `docker run`

```sh
run -d --net=host -v </path/to/config>:/home/steam/frozen-flame-dedicated/FrozenFlame/Saved --name=frozen-flame-dedicated ghcr.io/ragingdave/frozen-flame-docker:main 
```

This is currently using the host network simplicity but you should be able to map the ports how you wish without it, but that's untested by me. The ports are exposed in the Dockerfile just not used here yet.
