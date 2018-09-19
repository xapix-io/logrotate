#!/bin/sh

# Docker Entrypoint, generates logrotate config file, sets up crontab and hand over to `tini`

cat /logrotate.tpl.conf | envsubst > /etc/logrotate/logrotate.conf

echo "$CRON_SCHEDULE /usr/sbin/logrotate /etc/logrotate/logrotate.conf" | crontab -

exec tini $@
