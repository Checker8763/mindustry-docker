# Docker image for Mindustry Server
## Run the Image

`docker run -dit -p {PORT_ON_YOUR_MACHINE}:6567 -p {PORT_ON_YOUR_MACHINE}:6567/udp --name mind checker8763/mindustry`

-dit
: -d run with detached console, -i interactive otherwise you can not write to console, -t correct terminal translation (recommended)

-p {PORT_ON_YOUR_MACHINE}:6567
: open the port to access the server (can be the same as the container one or another)

## Access the console

```bash
docker attach -it mind
```

To **detach without stopping** press:
CTRL-P CTRL-Q

That's the standard shortcut by docker

### Example Docker-Compose

```dockerfile
version: '2.4'
services:
    spigot:
        image: checker8763/spigot
        container_name: mind
        stdin_open: true
        tty: true
        ports:
            #Game Port
            - "{PORT_ON_YOUR_MACHINE}:6567"
            - "{PORT_ON_YOUR_MACHINE}:6567/udp"
            # OPTIONAL: for socket input
            # ->needs SOCKET_INPUT enabled 
            - "{PORT_ON_YOUR_MACHINE}:6859"
        volumes:
            # with a volume
            - "{VOLUME_NAME}:/home/mindustry"
            # Or with bindmound
            - "{PATH_TO_FOLDER}:/home/mindustry"
volumes:
    {VOLUME_NAME}: {}
```

## Config Environment Variables
**Feel free to change any default values**

    {KEY}={DEFAULT}
    # Game/Map
    MAP=fortress
    GAMEMODE=survival
    PLAYERLIMIT=off
    SHUFFLE=none
    # Config
    NAME=Server
    DESCRIPTION="Containered Mindustry Server by checker8763/mindustry"
    MESSAGE_OF_THE_DAY=off
    SHOW_CONNECT_MESSAGES=true
    ANTI_SPAM=true
    ENABLE_VOTEKICK=true
    ALLOW_CUSTOM_CLIENTS=false
    AUTO_UPDATE=false
    AUTOSAVE=false
    AUTOSAVE_AMOUNT=10
    AUTOSAVE_SPACING=300
    SOCKET_INPUT=false
    SOCKET_INPUT_ADDRESS=0.0.0.0

## Build it yourself

1. Clone this repo
2. Switch to the newly created folder
3. Build by executing `docker build --build-arg VERSION={INSERT_VERSION} --force-rm -q -t spigot:{INSERT_VERSION} .`

"--build-arg VERSION={INSERT_VERSION}"
: set the mindustry version that will be build

"--force-rm"
: always remove intermediate containers

"-q"
: no text output

"-t spigot:{INSERT_VERSION}"
: the tag for the created image

### Build fails
Remove intermediate images:

**This will remove every unused image!!!**

`docker image prune -f`

### Build inside a screen
**For experienced people**

You can build the image inside a screen so you can log off.
Only use if you are familliar with the  screen command.

1. `cd /server/Docker/Spigot`
2. `screen -S dockerbuild docker build --build-arg VERSION={INSERT_VERSION} --force-rm -q -t mindustry:{INSERT_VERSION} .`