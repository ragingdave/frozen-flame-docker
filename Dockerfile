FROM cm2network/steamcmd:root

LABEL maintainer="davemc08@gmail.com"

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y gosu wget --no-install-recommends\
    && rm -rf /var/lib/apt/lists/*  \
    && gosu nobody true

RUN mkdir -p /config \
 && chown steam:steam /config

COPY init.sh /

COPY --chown=steam:steam run.sh /home/steam/

WORKDIR /config

ENV SERVER_NAME="FrozenFlameServer" \
    SERVER_PORT=7779 \
    SERVER_QUERY_PORT=7780 \
    RCON_PORT=27017 \
    RCON_PASSWORD="password" \
    STEAMAPPID=1348640 \
    MAXPLAYERS=10 \
    SERVERPASSWORD="password" \
    FREEPVP=true \
    DAYDURATION=3600 \
    PUID=1000 \
    PGID=1000 \
    GAMECONFIGDIR="/config/gamefiles/FrozenFlame/Saved/Config/LinuxServer" \
    GAMECONFIGLINK="https://raw.githubusercontent.com/DreamsideInteractive/FrozenFlameServer/main/Game.ini" \
    GAMESAVESDIR="/config/gamefiles/FrozenFlame/Saved/SaveGames" \
    SKIPUPDATE="false"


ENTRYPOINT [ "/init.sh" ]
