
FROM openjdk:8-jre-alpine

# For constant fileowner uuid
# Needed so there is no mismatch in rights when adding sftp container
RUN adduser --disabled-password --uid 1000 mindustry

# Actually running everything following as this user
USER mindustry

# Mindustrys folder
WORKDIR /home/mindustry

# Since they added beta versions to the releases latest isn' always for the stable version
# Latest stable version: 104.6
# ADD https://github.com/Anuken/Mindustry/releases/latest/download/server-release.jar .
ADD --chown=mindustry https://github.com/Anuken/Mindustry/releases/download/v104.6/server-release.jar .

# Make the Server as customizable as possible
ENV MAP=fortress \
    GAMEMODE=survival \
    DIFFICULTY=normal \
    PLAYERLIMIT=off \
    SHUFFLE=none \
    # Config
    NAME=Server \
    DESCRIPTION="Containered Mindustry Server by checker8763/mindustry" \
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


CMD java -jar server-release.jar config startCommands config name ${NAME},config desc $DESCRIPTION,config motd ${MESSAGE_OF_THE_DAY},config showConnectMessages ${SHOW_CONNECT_MESSAGES},config antiSpam ${ANTI_SPAM},config enableVotekick ${ENABLE_VOTEKICK},config autoUpdate ${AUTO_UPDATE},config socketInput ${SOCKET_INPUT},config socketInputAddress ${SOCKET_INPUT_ADDRESS},difficulty ${DIFFICULTY},playerlimit ${PLAYERLIMIT},shuffle ${SHUFFLE},host ${MAP} ${GAMEMODE}
