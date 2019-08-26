FROM kesch/deluge-common:1.3.15-1
LABEL maintainer=kennethj@eschrich.us

VOLUME /config
VOLUME /data

EXPOSE 58846
EXPOSE 58946
EXPOSE 58946/udp

COPY ./init.sh /init.sh

CMD ["bash","/init.sh"]
