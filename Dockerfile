FROM frolvlad/alpine-python2:latest
MAINTAINER subzero79

RUN pip install flexget

ADD src/ /root/

RUN apk add --update supervisor nano && \
	cp /root/supervisord.conf /etc/ && \
	adduser flexget -D

RUN rm -rf /root/.cache

VOLUME /config

EXPOSE 5050

CMD ["/bin/ash","/root/startup.sh"]

