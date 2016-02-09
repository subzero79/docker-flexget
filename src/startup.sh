#/bin/sh

VERSION=$(flexget -V | tail -n 1)
DAEMON_UID=$(id -u flexget)
logDir="/config/logs"

## Install required dependancies

if [ -z "$pythonExtras" ]; then
  echo "Nothing to do"
else
  echo "Installing $pythonExtras"
  pip install $pythonExtras
fi

##Check UID requested by env var matches
if [ -z "$PUID" ];then
  echo "No UID change for username ${DAEMON_USERNAME}"
  sleep 3
else
  echo "Requested change of UID"
  if [ "$DAEMON_UID" != "$PUID" ]; then
    echo "Changing UID of flexget"
    deluser ${DAEMON_USERNAME}
    adduser ${DAEMON_USERNAME} -D -u "$PUID"
  else
    echo "UID matches"
  fi
fi

## Check log directory
if [ ! -d "$logDir" ]; then
  echo "Creating log directory...."
  mkdir -p "$logDir"
else
  echo "Log directory present...."
fi

## Check if Flexget needs to upgrades
if [ "$VERSION" = "You are on the latest release."  ]; then
  echo "Flexget up to date..."
else
  echo "Upgrading Flexget..."
  pip install --upgrade flexget $pythonExtras
fi

chown ${DAEMON_USERNAME} -Rv /config

/usr/bin/supervisord -c /etc/supervisord.conf
