Docker based on Flexget using Alpine image

To run place your config.yml in /some/path

You can use environmental variables to change daemon UID

PUID

You can also add python dependancies that are not included with default flexget with $pythonExtras environmental variable. For example

to run 
```
docker run -d \
  --name=flexget \
  -e PUID="1200" \
  -e pythonExtras="transmissionrpc python-telegram-bot"  \
  -v /some/path:/config \
  -v /some_other/downloads \
  subzero79/docker-flexget
```


Notes, make sure map properly paths in the config.yml as are seen inside the container, otherwise Flexget will check those paths and will not start if they do not exist.

Logs are in /some/path/logs in host or /config/logs inside the container

You can check them also with ```docker logs flexget```


