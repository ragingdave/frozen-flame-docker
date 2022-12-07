#!/bin/bash

set -e

set_ini_prop() {
    sed "/\[$2\]/,/^\[/ s/$3\=.*/$3=$4/" -i "${GAMECONFIGDIR}/$1"
}

set_ini_val() {
    sed "/\[$2\]/,/^\[/ s/((\"$3\",.*))/((\"$3\", $4))/" -i "/home/steam/$1"
}

NUMCHECK='^[0-9]+$'
launchDate=`date +"%Y_%m_%d_%H_%M_%s"`

if [ -f "${GAMECONFIGDIR}/Game.ini" ]; then
    tar cf "/config/backups/${launchDate}.tar" "/config/saves" "${GAMECONFIGDIR}"
fi

## Initialise and update files
if ! [[ "${SKIPUPDATE,,}" == "true" ]]; then

    space=$(stat -f --format="%a*%S" .)
    space=$((space/1024/1024/1024))
    printf "Checking available space...%sGB detected\\n" "${space}"

    if [[ "$space" -lt 5 ]]; then
        printf "You have less than 5GB (%sGB detected) of available space to download the game.\\nIf this is a fresh install, it will probably fail.\\n" "${space}"
    fi

    printf "Downloading the latest version of the game...\\n"

    /home/steam/steamcmd/steamcmd.sh +force_install_dir /config/gamefiles +login anonymous +app_update "$STEAMAPPID" +quit
else
    printf "Skipping update as flag is set\\n"
fi

if [ ! -f "${GAMECONFIGDIR}/Game.ini" ]; then
    mkdir -p "${GAMECONFIGDIR}"
    wget -P "${GAMECONFIGDIR}" "${GAMECONFIGLINK}"
fi

# cp /home/steam/*.ini "${GAMECONFIGDIR}"
if [ ! -L "${GAMESAVESDIR}" ]; then
    ln -sf "/config/saves" "${GAMESAVESDIR}"
fi

## START [/Script/Engine.GameSession]
if ! [[ "$MAXPLAYERS" =~ $NUMCHECK ]] ; then
    printf "Invalid max players number given: %s\\n" "${MAXPLAYERS}"
    MAXPLAYERS=10
fi
set_ini_prop "Game.ini" "\/Script\/Engine\.GameSession" "MaxPlayers" "${MAXPLAYERS}"
## END

## START [/Script/FrozenFlame.FGameSession]
set_ini_prop "Game.ini" "\/Script\/FrozenFlame\.FGameSession" "ServerPassword" "\"${SERVERPASSWORD}\""
## END

## START [/Script/FrozenFlame.GameBalance]
if [[ "${FREEPVP,,}" == "false" ]]; then
    set_ini_prop "Game.ini" "\/Script\/FrozenFlame\.GameBalance" "bFreePVP" "False;"
fi
if ! [[ "$DAYDURATION" =~ $NUMCHECK ]] ; then
    printf "Invalid day duration number given: %s\\n" "${DAYDURATION}"
    DAYDURATION=3600
fi
set_ini_prop "Game.ini" "\/Script\/FrozenFlame\.GameBalance" "DurationOfDay" "${DAYDURATION};"
## END

cd /config/gamefiles || exit 1

exec ./FrozenFlameServer.sh -log -MetaGameServerName="${SERVER_NAME}" -RconPassword="${RCON_PASSWORD}" -RconPort="${RCON_PORT}" -Port="${SERVER_PORT}" -queryPort="${SERVER_QUERY_PORT}"
