FROM alpine:3.7

ENV CRON_SCHEDULE='0 * * * *' \
    LOGROTATE_SIZE='100M' \
    LOGROTATE_MODE='copytruncate' \
    LOGROTATE_PATTERN='/logs/*.log' \
    LOGROTATE_ROTATE='0' \
    LOG_USER_ID=1000 \
    LOG_GROUP_ID=1000

RUN apk --no-cache add logrotate tini gettext libintl \
    && mkdir -p /logs \
    && mkdir -p /etc/logrotate.d

RUN addgroup -g $LOG_GROUP_ID box
RUN adduser -s /bin/sh -D -H -u $LOG_USER_ID -S -G box box
RUN mkdir -p /etc/logrotate

COPY logrotate.tpl.conf /logrotate.tpl.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/crond", "-f", "-L", "/dev/stdout"]
