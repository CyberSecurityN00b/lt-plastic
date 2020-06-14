#!/bin/bash
mkdir -p /tmp/plastic
PLASTIC_FILE=/tmp/plastic/$(hostname)-$(date +%Y%m%d-%H.%M.%S.plastic)

echo "Collecting to $PLASTIC_FILE..."

## USERS ######################################################################
cat /etc/passwd | sed 's/^/\[\/etc\/passwd\]\: /' >> $PLASTIC_FILE

## PROCESSES ##################################################################
ps -eo pid -o args | sed 's/^/\[process\]\: /' >> $PLASTIC_FILE

## PORTS ######################################################################
lsof -i -P -n | sed 's/^/\[port\]\: /' >> $PLASTIC_FILE

## SERVICES ###################################################################
service --status-all 2>/dev/null | sed 's/^/\[service\]\: /' >> $PLASTIC_FILE
systemctl -l --type service --all 2>/dev/null | sed 's/^/\[service\]\: /' >> $PLASTIC_FILE
for filename in /etc/init.d/*; do cksum $filename 2>/dev/null >> $PLASTIC_FILE;done

## CRON #######################################################################
for filename in /etc/cron.d/*; do cksum $filename 2>/dev/null | sed 's/^/\[cron\]\: /' >> $PLASTIC_FILE;done

## EXECUTABLE #################################################################
for path in ${PATH//:/ };do find $path -type f -executable -print0 2>/dev/null | xargs -0 cksum 2>/dev/null | sed 's/^/\[exec\]\: /' >> $PLASTIC_FILE;done

## CONFIG #####################################################################
find /etc -type f -print0 2>/dev/null | xargs -0 cksum 2>/dev/null | sed 's/^/\[conf\]\: /' >> $PLASTIC_FILE

## DIRWALK ####################################################################
find / -maxdepth 4 -mindepth 4 -path /sys -prune -o -path /proc -prune 2>/dev/null | sed 's/^/\[dirwalk\]\: /' >> $PLASTIC_FILE

echo "Done."