#!/bin/bash

if [ "${DELUGE_ALLOW_REMOTE,,}" != "true" ]; then
	DELUGE_ALLOW_REMOTE=false
fi

if [ ! -f "/config/.initialized" ]; then
	deluged -c /config
	sleep 1
	deluge-console -c /config config -s allow_remote ${DELUGE_ALLOW_REMOTE}
	deluge-console -c /config config -s autoadd_location /data/torrents
	deluge-console -c /config config -s download_location /data/downloads
	deluge-console -c /config config -s move_completed_path /data/completed
	deluge-console -c /config config -s torrentfiles_location /data/torrents
	deluge-console -c /config halt
	touch /config/.initialized
fi

if [ ! -z "${DELUGE_ADD_USER}" ]; then
  if [ ! -z "${DELUGE_ADD_PASS}" ]; then
		if [ ! -z `egrep ^${DELUGE_ADD_USER} /config/auth` ]; then
			sed -i '/^'${DELUGE_ADD_USER}':.*$/d' /config/auth
		fi
		echo "${DELUGE_ADD_USER}:${DELUGE_ADD_PASS}:10" >> /config/auth
  else
    echo Add user specified, but no password! Ignoring.
  fi
fi

exec deluged -d -c config
