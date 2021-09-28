FROM cm2network/steamcmd

USER root

RUN dpkg --add-architecture i386 && \
apt-get update -y && \
apt install -y libssl1.1:i386 lib32z1

USER steam

RUN ./steamcmd.sh +login anonymous +force_install_dir "/tmp/svends" +app_update 276060 validate +exit

WORKDIR /tmp/svends

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [""]