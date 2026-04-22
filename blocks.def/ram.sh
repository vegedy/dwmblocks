#!/bin/sh
ICON="RAM"
RAM=$(free -h | awk '/Speicher/ {print $3 "/" $2}')
printf "$ICON %s" "$RAM"
