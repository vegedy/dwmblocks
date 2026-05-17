#!/bin/sh
RAM=$(free -h | awk '/Speicher/ {print $3 "/" $2}')
printf " %s" "$RAM"
