#!/bin/bash -eux

yum --assumeyes install mlocate

# Update the locate database.
cp /etc/cron.daily/mlocate /etc/cron.hourly/mlocate && /etc/cron.daily/mlocate

# A very simple script designed to ensure the locate database gets updated
# automatically when the box is booted and provisioned.
printf "@reboot root bash -c '/usr/bin/updatedb ; rm --force /etc/cron.d/updatedb'\n" > /etc/cron.d/updatedb
chcon "system_u:object_r:system_cron_spool_t:s0" /etc/cron.d/updatedb
