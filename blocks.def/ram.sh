#!/bin/sh
RAM=$(free -m | awk '/Speicher/ {printf "%d/%dG", int($3/1024 + 0.5), int($2/1024 + 0.5)}')
printf " %s" "$RAM"
