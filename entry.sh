#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

cd "${STEAMAPPDIR}"

# Run the Game

${STEAMAPPDIR}/FrozenFlameServer.sh -log \
	-MetaGameServerName="${SERVER_NAME}" \
	-RconPassword="${RCON_PASSWORD}" \
	-RconPort="${RCON_PORT}" \
	{{ADDITIONAL_ARGS}}
