ARG ARCH=
FROM ${ARCH}openjdk:8-jre-alpine

# For constant fileowner uuid
# Needed so there is no mismatch in rights when adding sftp container
RUN adduser --disabled-password --uid 1000 mindustry

# Actually running everything following as this user
USER mindustry

# Mindustrys folder
WORKDIR /home/mindustry

# Expose Ports both tcp and Udp
# For the Server
EXPOSE 6567 6567/udp \
    6567 6567/tcp \
# For the Socket Input
    6859 6859/udp \
    6859 6859/tcp

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
    ALLOW_CUSTOM_CLIENTS=false \
    AUTO_UPDATE=false \
    AUTOSAVE=false \
    AUTOSAVE_AMOUNT=10 \
    AUTOSAVE_SPACING=300 \
    SOCKET_INPUT=false \
    SOCKET_INPUT_ADDRESS=0.0.0.0

# Set the Version
ARG VERSION=122.1
# Since they added beta versions to the releases latest isn' always for the stable version
# ADD https://github.com/Anuken/Mindustry/releases/latest/download/server-release.jar .
ADD --chown=mindustry https://github.com/Anuken/Mindustry/releases/download/v${VERSION}/server-release.jar .

CMD java -jar server-release.jar config name ${NAME},config desc $DESCRIPTION,config motd ${MESSAGE_OF_THE_DAY},config showConnectMessages ${SHOW_CONNECT_MESSAGES},config antiSpam ${ANTI_SPAM},config enableVotekick ${ENABLE_VOTEKICK},config autoUpdate ${AUTO_UPDATE},config autosave ${AUTOSAVE},config autosaveAmount ${AUTOSAVE_AMOUNT},config autosaveSpacing ${AUTOSAVE_SPACING},config socketInput ${SOCKET_INPUT},config socketInputAddress ${SOCKET_INPUT_ADDRESS},playerlimit ${PLAYERLIMIT},shuffle ${SHUFFLE},host ${MAP} ${GAMEMODE}