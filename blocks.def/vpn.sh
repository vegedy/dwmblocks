#!/bin/sh

if wg >/dev/null 2>&1; then
    printf " no VPN"
else
    printf " VPN"
fi

