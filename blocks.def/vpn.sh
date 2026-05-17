#!/bin/sh

if wg >/dev/null 2>&1; then
    printf " VPN"
else
    printf " no VPN"
fi

