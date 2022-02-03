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
RUN ln -s "${HOMEDIR}/Zomboid/Saves/" /server-saves

RUN mkdir -p "${HOMEDIR}/Zomboid/Server/" && chown steam:steam "${HOMEDIR}/Zomboid/Server/"
RUN ln -s "${HOMEDIR}/Zomboid/Server/" /server-conf

WORKDIR ${HOMEDIR}

VOLUME "/server-conf"
VOLUME "/server-saves"

CMD	"${STEAMAPPDIR}/start-server.sh" -adminpassword "${ADMINPASSWORD}"
