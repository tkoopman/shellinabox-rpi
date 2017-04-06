#!/bin/bash
set -e

if [ ! "$TIMEZONE" = "" ]; then
	echo ${TIMEZONE} >/etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata
	echo "Container timezone set to: $TIMEZONE"
else
	echo "Container timezone not modified"
fi

if [ ! -d /config/styles ]; then
    # Missing Styles
    cp -rn /etc/shellinabox/styles /config
fi

if [ ! -f /config/shellinabox.conf ]; then
    cp /etc/shellinabox/shellinabox.conf /config/
fi

. /config/shellinabox.conf

ARGS="--user=$user --group=$group --port=$port --cert=$cert --no-beep"
if [ "$loglevel" = "debug" ]; then
    ARGS+=" --debug"
fi
if [ "$loglevel" = "verbose" ]; then
    ARGS+=" --verbose"
fi
if [ "$ssl" = "false" ]; then
    ARGS+=" --disable-ssl"
fi

for addService in "${service[@]}"; do
     ARGS+=" --service $addService"
done

for addCSS in "${usercss[@]}"; do
    ARGS+=" --user-css '$addCSS'"
done

# Start services
echo "Command: shellinaboxd $ARGS"
sh -c "/bin/shellinaboxd $ARGS"
