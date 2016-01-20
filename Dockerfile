FROM frolvlad/alpine-python2:latest
MAINTAINER subzero79

ENV DAEMON_USERNAME="flexget" DAEMON_NAME="Flexget" TERM=xterm 

RUN pip install flexget

ADD src/ /root/

RUN apk add --update supervisor nano ca-certificates && \
	cp /root/supervisord.conf /etc/ && \
	adduser ${DAEMON_USERNAME} -D

RUN rm -rf /root/.cache

VOLUME /config

EXPOSE 5050

CMD ["/bin/ash","/root/startup.sh"]

