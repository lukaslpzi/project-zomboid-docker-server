FROM cm2network/steamcmd:root

LABEL maintainer=""

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

WORKDIR ${HOMEDIR}
VOLUME "${STEAMAPPDIR}/Saves/"
VOLUME "${STEAMAPPDIR}/Server/"
	
CMD	"${STEAMAPPDIR}/start-serve.sh"
