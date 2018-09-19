#!/bin/sh

# Docker Entrypoint, generates logrotate config file, sets up crontab and hand over to `tini`

addgroup -g $LOG_GROUP_ID box
adduser -s /bin/sh -D -H -u $LOG_USER_ID -S -G box box
mkdir -p /etc/logrotate
cat /logrotate.tpl.conf | envsubst > /etc/logrotate/logrotate.conf

echo "$CRON_SCHEDULE /usr/sbin/logrotate /etc/logrotate/logrotate.conf" | crontab -

exec tini $@
