ARG ARCH=
FROM ${ARCH}openjdk:8-jre-alpine

RUN adduser --disabled-password --uid 1000 mindustry

USER mindustry

# Mindustrys folder
WORKDIR /home/mindustry
RUN wget https://github.com/Anuken/Mindustry/releases/latest/download/server-release.jar -O server.jar

ENV MAP=fortress \
    GAMEMODE=survival \
    DIFFICULTY=normal \
    PLAYERLIMIT=off \
    SHUFFLE=none \
    # Config
    NAME=Server \
    DESCRIPTION="Containered Mindustry Server by checker8763/minustry" \
    MESSAGE_OF_THE_DAY=off \
    SHOW_CONNECT_MESSAGES=true \
    ANTI_SPAM=true \
    ENABLE_VOTEKICK=true \
    AUTO_UPDATE=true \
    SOCKET_INPUT=false \
    SOCKET_INPUT_ADDRESS=0.0.0.0

# Expose Ports both tcp and Udp
# For the Server
EXPOSE 6567 6567/udp \
# For the Socket Input
    6859 6859/udp


CMD java -jar server.jar config startCommands config name ${NAME},config desc $DESCRIPTION,config motd ${MESSAGE_OF_THE_DAY0},config showConnectMessages ${SHOW_CONNECT_MESSAGES},config antiSpam ${ANTI_SPAM},config enableVotekick ${ENABLE_VOTEKICK},config autoUpdate ${AUTO_UPDATE},config socketInput ${SOCKET_INPUT},config socketInputAddress ${SOCKET_INPUT_ADDRESS},difficulty ${DIFFICULTY},playerlimit ${PLAYERLIMIT},shuffle ${SHUFFLE},host ${MAP} ${GAMEMODE}
