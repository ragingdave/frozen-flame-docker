FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="davemc08@gmail.com"

ENV STEAMAPPID 1348640 
ENV STEAMAPP frozen-flame
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY --chown="$USER:$USER" entry.sh "${HOMEDIR}/entry.sh"
COPY --chown="$USER:$USER" entry.sh "${HOMEDIR}/tinientry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		lib32z1=1:1.2.11.dfsg-2+deb11u2 \
		tini=0.19.0-1 \
		libc6-dev=2.31-13+deb11u5 \
		file=1:5.39-3 \
	&& mkdir -p "${STEAMAPPDIR}/FrozenFlame/Saved" \
	# Add entry scripts
	&& chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" \
	&& chown -R "${USER}:${USER}" "${STEAMAPPDIR}"  \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*


FROM build_stage AS bullseye-base

ENV SERVER_NAME="FrozenFlameDedicated" \
	RCON_PORT="" \
	RCON_PASSWORD="password" \
	STEAMCMD_UPDATE_ARGS=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

EXPOSE 25575 \
	27015/udp \
	27015 \
	7777/udp \
	7777

VOLUME /home/steam/frozen-flame-dedicated/FrozenFlame/Saved

ENTRYPOINT ["tini", "-g", "--", "/home/steam/tinientry.sh"]
