FROM cm2network/steamcmd:root

LABEL maintainer=""

ENV ADMINPASSWORD admin
ENV STEAMAPPID 380870
ENV STEAMAPP projectzomboid
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-server"
ENV BETABRANCH b41multiplayer

RUN "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
	+login anonymous \
	+app_update "${STEAMAPPID}" \
	-beta "${BETABRANCH}" \
	+quit

USER ${USER}

RUN mkdir -p "${HOMEDIR}/Zomboid/Saves/" && chown steam:steam "${HOMEDIR}/Zomboid/Saves/"
RUN mkdir -p "${HOMEDIR}/Zomboid/Server/" && chown steam:steam "${HOMEDIR}/Zomboid/Server/"

WORKDIR ${HOMEDIR}

VOLUME "${HOMEDIR}/Zomboid/Saves/"
VOLUME "${HOMEDIR}/Zomboid/Server/"

CMD	"${STEAMAPPDIR}/start-server.sh" -adminpassword "${ADMINPASSWORD}"
