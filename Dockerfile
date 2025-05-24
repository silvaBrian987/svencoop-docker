FROM cm2network/steamcmd:steam-bookworm

ENV HOME "${HOMEDIR}"
ENV STEAMAPPID 276060
ENV STEAMAPP svends
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

USER root

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt install -y libssl3 lib32z1

USER steam

RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    && chown -R "${USER}:${USER}" "${STEAMAPPDIR}" \
    && bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" validate \
    +quit

WORKDIR "${STEAMAPPDIR}"

EXPOSE 27015/udp

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [""]