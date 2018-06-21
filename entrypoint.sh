#!/bin/sh

# Docker Entrypoint, generates logrotate config file, sets up crontab and hand over to `tini`

addgroup -g $LOG_GROUP_ID box
adduser -s /bin/sh -D -H -u $LOG_USER_ID -S -G box box

cat /logrotate.tpl.conf | envsubst > /etc/logrotate.conf

echo "$CRON_SCHEDULE /usr/sbin/logrotate /etc/logrotate.conf" | crontab -

exec tini $@
