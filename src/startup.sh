#/bin/sh

version=$(flexget -V | tail -n 1)
flexgetUID=$(id -u flexget)
logDir="/config/logs"

## Install required dependancies

if [ -z "$pythonExtras" ]; then
  echo "Nothing to do"
else
  echo "Installing $pythonExtras"
  pip install $pythonExtras
fi

##Check UID by env var matches
if [ "$flexgetUID" != "$PUID" ]; then
  echo "Changing UID of flexget"
  deluser flexget
  adduser flexget -D -u "$PUID"
else
  echo "UID matches"
fi

## Check log directory
if [ ! -d "$logDir" ]; then
  echo "Creating log directory...."
  mkdir -p "$logDir"
else
  echo "Log directory present...."
fi

## Check if Flexget needs to upgrades
if [ "$version" = "You are on the latest release."  ]; then
  echo "Flexget up to date..."
else
  echo "Upgrading Flexget..."
  pip install flexget --upgrade
fi


/usr/bin/supervisord -c /etc/supervisord.conf