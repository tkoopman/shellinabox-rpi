# shellinabox-rpi
Docker image of latest version of shellinabox for Raspberry Pi

- [Introduction](#introduction)
- [How to Run](#howtorun)
- [Configuration](#config)
- [Links](#links)

# Introduction
Docker image for shellinabox. This image compiles shellinabox from source so it is the latest version from https://github.com/shellinabox/shellinabox

# How to Run
```shell
docker run \
    --name siab \
    -p 4200:4200 \
    -v /path/to/config/dir:/config \
    --env "TIMEZONE=$(cat /etc/timezone)" \
    --env "SSHServerIP=$(hostname -I | awk '{print $1;}')" \
    --restart=always \
    --detach \
    tkoopman/shellinabox-rpi
```

# Configuration
Config directory is /config. Unless you need special config or custom certificates you may not need to use this as default config will SSH to SSHServerIP variable for root path.
Default config file will be created if missing, that you can then use to modify.

# Links
Docker Hub: https://hub.docker.com/r/tkoopman/shellinabox-rpi/

Source: https://github.com/tkoopman/shellinabox-rpi
